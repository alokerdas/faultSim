#include <vpi_user.h>

typedef struct ReadStimData {
  FILE *file_ptr; /* test vector file pointer */
  vpiHandle patin_h; /* pointer to store handle for a Verilog object */
  vpiHandle patout_h; /* pointer to store handle for a Verilog object */
} s_ReadStimData, *p_ReadStimData;

PLI_INT32 fsim_compiletf(PLI_BYTE8 *user_data)
{
  vpiHandle systf_handle, arg_iterator, arg_handle;
  PLI_INT32 arg_type;

  /* obtain a handle to the system task instance */
  systf_handle = vpi_handle(vpiSysTfCall, NULL);
  if (systf_handle == NULL)
  {
    vpi_printf("ERROR: $faultSimulate failed to obtain systf handle\n");
    vpi_control(vpiFinish,0); /* abort simulation */
    return(0);
  }
  /* obtain handles to system task arguments */
  arg_iterator = vpi_iterate(vpiArgument, systf_handle);
  if (arg_iterator == NULL)
  {
    vpi_printf("ERROR: $faultSimulate requires 3 argument\n");
    vpi_control(vpiFinish,0); /* abort simulation */
    return(0);
  }
  /* check the type of object in system task arguments */
  arg_handle = vpi_scan(arg_iterator);
  arg_type = vpi_get(vpiType, arg_handle);
  if (arg_type != vpiReg)
  {
    vpi_printf("ERROR: $faultSimulate first arg must be a reg\n");
    vpi_free_object(arg_iterator); /* free iterator memory */
    vpi_control(vpiFinish,0); /* abort simulation */
    return(0);
  }
  /* check the type of object in system task arguments */
  arg_handle = vpi_scan(arg_iterator);
  arg_type = vpi_get(vpiType, arg_handle);
  if (arg_type != vpiNet)
  {
    vpi_printf("ERROR: $faultSimulate second arg must be a reg\n");
    vpi_free_object(arg_iterator); /* free iterator memory */
    vpi_control(vpiFinish,0); /* abort simulation */
    return(0);
  }
  /* check that there are no more system task arguments */
  arg_handle = vpi_scan(arg_iterator);
  arg_type = vpi_get(vpiType, arg_handle);
  if (arg_type != vpiConstant)
  {
    vpi_printf("ERROR: $faultSimulate third arg must be filename within quotes\n");
    vpi_free_object(arg_iterator); /* free iterator memory */
    vpi_control(vpiFinish,0); /* abort simulation */
    return(0);
  }
  arg_handle = vpi_scan(arg_iterator);
  arg_type = vpi_get(vpiType, arg_handle);
  if (arg_type != vpiConstant)
  {
    vpi_printf("ERROR: $faultSimulate fourth arg must be filename within quotes\n");
    vpi_free_object(arg_iterator); /* free iterator memory */
    vpi_control(vpiFinish,0); /* abort simulation */
    return(0);
  }
  arg_handle = vpi_scan(arg_iterator);
  if (arg_handle != NULL)
  {
    vpi_printf("ERROR: $faultSimulate cannot have more than three arguments\n");
    vpi_free_object(arg_iterator); /* free iterator memory */
    vpi_control(vpiFinish,0); /* abort simulation */
    return(0);
  }
  return(0);
}
PLI_INT32 fsim_simulate_fault(p_cb_data cb_data)
{
  char vector[1024]; /* fixed max. size, should use malloc instead */
  int delay;
  vpiHandle systf_h, cb_h;
  s_cb_data data_s;
  s_vpi_time time_s;
  s_vpi_value value_s;
  p_ReadStimData StimData; /* pointer to a ReadStimData structure */
  /* retrieve system task handle from user_data */
  systf_h = (vpiHandle)cb_data->user_data;
  /* get ReadStimData pointer from work area for this task instance */
  StimData = (p_ReadStimData)vpi_get_userdata(systf_h);
  value_s.format = vpiBinStrVal;
  vpi_get_value(StimData->patout_h, &value_s);
  vpi_printf("net o has the value %s\n", value_s.value.str);
  /* read next line from the file */
  char onePat[3];
  if (fscanf(StimData->file_ptr, "%s\n", onePat) == EOF)
  {
    vpi_printf("End-Of-File.\n");
    fclose(StimData->file_ptr);
    vpi_control(vpiFinish, 1); /* abort simulation */
    return(0);
  }
  else
  {
    value_s.format = vpiBinStrVal;
    value_s.value.str = onePat;
    vpi_put_value(StimData->patin_h, &value_s, NULL, vpiNoDelay);
    vpi_printf("Pat has the value %s\n", value_s.value.str);
  }
  /* schedule callback to this routine when time to read next vector */
  time_s.type = vpiSimTime;
  time_s.low = 0;
  time_s.high = 0;
  data_s.reason = cbReadWriteSynch;
  data_s.cb_rtn = fsim_simulate_fault;
  data_s.obj = NULL; /* object required for scaled delays */
  data_s.time = &time_s;
  data_s.value = NULL;
  data_s.user_data = (PLI_BYTE8 *)systf_h;
  cb_h = vpi_register_cb(&data_s);
  if (vpi_chk_error(NULL))
    vpi_printf("An error occurred registering ReadNextStim callback\n");
  else
    vpi_free_object(cb_h); /* don’t need callback handle */
}
PLI_INT32 fsim_calltf(PLI_BYTE8 *user_data)
{
  vpiHandle cb_h, systf_handle, arg_iterator, arg_handle, reg_handle, net_handle;
  s_vpi_value current_value;
  s_cb_data cb_data_s;
  p_ReadStimData StimData; /* pointer to a ReadStimData structure */
  s_vpi_time time_s;

  /* obtain a handle to the system task instance */
  systf_handle = vpi_handle(vpiSysTfCall, NULL);
  /* obtain handle to system task argument
  compiletf has already verified only 3 args with correct type */
  current_value.format = vpiBinStrVal; /* read value as a string */
  arg_iterator = vpi_iterate(vpiArgument, systf_handle);
  reg_handle = vpi_scan(arg_iterator);
  /* read current value */
  vpi_get_value(reg_handle, &current_value);
  vpi_printf("Signal %s ", vpi_get_str(vpiFullName, reg_handle));
  vpi_printf("has the value %s\n", current_value.value.str);

  net_handle = vpi_scan(arg_iterator);
  /* read current value */
  vpi_get_value(net_handle, &current_value);
  vpi_printf("Signal %s ", vpi_get_str(vpiFullName, net_handle));
  vpi_printf("has the value %s\n", current_value.value.str);

  arg_handle = vpi_scan(arg_iterator);
  current_value.format = vpiStringVal;
  vpi_get_value(arg_handle, &current_value);
  char *patFileName = current_value.value.str;
  vpi_printf("Pattern file %s \n", patFileName);
  FILE *patFile = fopen(patFileName, "r");
  if (!patFile)
  {
    vpi_printf("ERROR: $faultSimulate could not open pattern file %s\n", patFileName);
    vpi_control(vpiFinish, 1); /* abort simulation */
    return(0);
  }
  char onePat[3];
  if (fscanf(patFile, "%s\n", onePat) != EOF)
  {
  current_value.format = vpiBinStrVal;
  current_value.value.str = onePat;
  vpi_put_value(reg_handle, &current_value, NULL, vpiNoDelay);
  vpi_get_value(net_handle, &current_value);
  vpi_printf("net o has the value %s\n", current_value.value.str);
  vpi_get_value(reg_handle, &current_value);
  vpi_printf("Pat has the value %s\n", current_value.value.str);
  }

  arg_handle = vpi_scan(arg_iterator);
  current_value.format = vpiStringVal;
  vpi_get_value(arg_handle, &current_value);
  vpi_printf("Fault file %s \n", current_value.value.str);

  vpi_free_object(arg_iterator); /* free iterator memory */

  /* setup a callback for start of simulation */
  time_s.type = vpiSimTime;
  time_s.low = 0;
  time_s.high = 0;
  cb_data_s.reason = cbReadWriteSynch;
  cb_data_s.cb_rtn = fsim_simulate_fault;
  cb_data_s.obj = NULL;
  cb_data_s.time = &time_s;
  cb_data_s.user_data = (PLI_BYTE8 *)systf_handle; /* pass systf_h */
  StimData = (p_ReadStimData)malloc(sizeof(s_ReadStimData));
  StimData->file_ptr = patFile;
  StimData->patin_h = reg_handle;
  StimData->patout_h = net_handle;
  vpi_put_userdata(systf_handle, (PLI_BYTE8 *)StimData);
  cb_h = vpi_register_cb(&cb_data_s);
  vpi_free_object(cb_h); /* don’t need callback handle */
  return(0);
}
void fsim_register()
{
  s_vpi_systf_data tf_data;
  tf_data.type = vpiSysTask;
  tf_data.sysfunctype = 0;
  tf_data.tfname = "$faultSimulate";
  tf_data.calltf = fsim_calltf;
  tf_data.compiletf = fsim_compiletf;
  tf_data.sizetf = NULL;
  tf_data.user_data = NULL;
  vpi_register_systf(&tf_data) ;
  return;
}
void (*vlog_startup_routines[])() = {
  fsim_register,
  0
};

