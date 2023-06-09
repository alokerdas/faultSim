#include <string.h>
#include <stdlib.h>
#include <vpi_user.h>

PLI_INT32 fsim_simulate_faulty_machine(p_cb_data cb_data);
PLI_INT32 fsim_simulate_good_machine(p_cb_data cb_data);
typedef struct ReadFaultData {
  vpiHandle fault_h; /* pointer to store handle for a Verilog object */
  char faultModel[4];
  char faultClass[4];
  char faultStatus[4];
} s_ReadFaultData, *p_ReadFaultData;
typedef struct ReadStimData {
  int faultIndex;
  int patIndex;
  int totalFaults;
  int detectedFaults;
  char *gm_value;
  FILE *pat_ptr; /* test vector file pointer */
  FILE *rpt_ptr; /* test vector file pointer */
  vpiHandle patin_h; /* pointer to store handle for a Verilog object */
  vpiHandle patout_h; /* pointer to store handle for a Verilog object */
  p_ReadFaultData *fault_data; /* array of fault objects */
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
    vpi_printf("ERROR: $faultSimulate requires five arguments\n");
    vpi_control(vpiFinish,0); /* abort simulation */
    return(0);
  }
  /* check the type of object in system task arguments */
  arg_handle = vpi_scan(arg_iterator);
  arg_type = vpi_get(vpiType, arg_handle);
  if (arg_type != vpiReg)
  {
    vpi_printf("ERROR: $faultSimulate first argument must be a reg\n");
    vpi_free_object(arg_iterator); /* free iterator memory */
    vpi_control(vpiFinish,0); /* abort simulation */
    return(0);
  }
  /* check the type of object in system task arguments */
  arg_handle = vpi_scan(arg_iterator);
  arg_type = vpi_get(vpiType, arg_handle);
  if (arg_type != vpiNet)
  {
    vpi_printf("ERROR: $faultSimulate second argument must be a reg\n");
    vpi_free_object(arg_iterator); /* free iterator memory */
    vpi_control(vpiFinish,0); /* abort simulation */
    return(0);
  }
  /* check that there are no more system task arguments */
  arg_handle = vpi_scan(arg_iterator);
  arg_type = vpi_get(vpiType, arg_handle);
  if (arg_type != vpiReg)
  {
    vpi_printf("ERROR: $faultSimulate third argument must be a filename within quotes\n");
    vpi_free_object(arg_iterator); /* free iterator memory */
    vpi_control(vpiFinish,0); /* abort simulation */
    return(0);
  }
  arg_handle = vpi_scan(arg_iterator);
  arg_type = vpi_get(vpiType, arg_handle);
  if (arg_type != vpiReg)
  {
    vpi_printf("ERROR: $faultSimulate fourth argument must be a filename within quotes\n");
    vpi_free_object(arg_iterator); /* free iterator memory */
    vpi_control(vpiFinish,0); /* abort simulation */
    return(0);
  }
  arg_handle = vpi_scan(arg_iterator);
  arg_type = vpi_get(vpiType, arg_handle);
  if (arg_type != vpiReg)
  {
    vpi_printf("ERROR: $faultSimulate fifth argument must be a filename within quotes\n");
    vpi_free_object(arg_iterator); /* free iterator memory */
    vpi_control(vpiFinish,0); /* abort simulation */
    return(0);
  }
  arg_handle = vpi_scan(arg_iterator);
  if (arg_handle != NULL)
  {
    vpi_printf("ERROR: $faultSimulate cannot have more than five arguments\n");
    vpi_free_object(arg_iterator); /* free iterator memory */
    vpi_control(vpiFinish,0); /* abort simulation */
    return(0);
  }
  return(0);
}
PLI_INT32 fsim_calltf(PLI_BYTE8 *user_data)
{
  vpiHandle cb_h, systf_handle, arg_iterator, arg_handle;
  vpiHandle module_iter, module_h, net_iter, net_h;
  s_vpi_value current_value;
  s_cb_data cb_data_s;
  s_vpi_time time_s;
  p_ReadStimData StimData;
  p_ReadFaultData *FaultData;
  char faultName[64];
  char *fileName, *netName;

  StimData = (p_ReadStimData) malloc(sizeof(s_ReadStimData));
  StimData->faultIndex = 0;
  StimData->patIndex = 0;
  StimData->detectedFaults = 0;
  /* obtain a handle to the system task instance */
  systf_handle = vpi_handle(vpiSysTfCall, NULL);
  /* obtain handle to system task argument
  compiletf has already verified only 3 args with correct type */
  current_value.format = vpiBinStrVal; /* read value as a string */
  arg_iterator = vpi_iterate(vpiArgument, systf_handle);
  StimData->patin_h = vpi_scan(arg_iterator); // read first argument (input register)
  StimData->patout_h = vpi_scan(arg_iterator); // read second argument (output signal)

  arg_handle = vpi_scan(arg_iterator);
  current_value.format = vpiStringVal;
  vpi_get_value(arg_handle, &current_value);
  fileName = current_value.value.str;
  vpi_printf("Fault file %s \n", fileName);
  FILE *flt_ptr = fopen(fileName, "r");
  if (flt_ptr)
  {
    char oneline[128];
    while (fgets(oneline, 128, flt_ptr))
      StimData->faultIndex++;
    StimData->totalFaults = StimData->faultIndex;
    FaultData = malloc((StimData->faultIndex+1) * sizeof(p_ReadFaultData));
    StimData->fault_data = FaultData;

    rewind(flt_ptr);
    StimData->fault_data[StimData->faultIndex] = NULL;
    p_ReadFaultData oneFault = malloc(sizeof(s_ReadFaultData));
    while (fscanf(flt_ptr, "%s %s %s %s\n", faultName, oneFault->faultModel, oneFault->faultClass, oneFault->faultStatus) != EOF)
    {
      // find the fault handle
      module_iter = vpi_iterate(vpiModule, NULL);
      module_h = vpi_scan(module_iter);
      module_iter = vpi_iterate(vpiModule, module_h);
      module_h = vpi_scan(module_iter);
      if (module_h)
      {
        net_iter = vpi_iterate(vpiNet, module_h);
        while ((net_h = vpi_scan(net_iter)))
        {
          netName = vpi_get_str(vpiFullName, net_h);
          if (!strcmp(netName, faultName))
          {
            oneFault->fault_h = net_h;
          }
        }
      }
      StimData->faultIndex--;
      StimData->fault_data[StimData->faultIndex] = oneFault;
      oneFault = malloc(sizeof(s_ReadFaultData));
    }
    fclose(flt_ptr);
  }
  else
  {
    vpi_printf("ERROR: $faultSimulate could not open fault file %s\n", fileName);
    vpi_control(vpiFinish, 1); /* abort simulation */
    return(0);
  }
  arg_handle = vpi_scan(arg_iterator);
  current_value.format = vpiStringVal;
  vpi_get_value(arg_handle, &current_value);
  fileName = current_value.value.str;
  vpi_printf("Pattern file %s \n", fileName);
  StimData->pat_ptr = fopen(fileName, "w");
  if (!StimData->pat_ptr)
  {
    vpi_printf("ERROR: $faultSimulate could not open pattern file %s\n", fileName);
    vpi_control(vpiFinish, 1); /* abort simulation */
    return(0);
  }
  arg_handle = vpi_scan(arg_iterator);
  current_value.format = vpiStringVal;
  vpi_get_value(arg_handle, &current_value);
  fileName = current_value.value.str;
  vpi_printf("Fault report file %s \n", fileName);
  StimData->rpt_ptr = fopen(fileName, "w");
  if (!StimData->rpt_ptr)
  {
    vpi_printf("ERROR: $faultSimulate could not open fault report file %s\n", fileName);
    vpi_control(vpiFinish, 1); /* abort simulation */
    return(0);
  }
  vpi_free_object(arg_iterator); /* free iterator memory */

  /* setup a callback for start of simulation */
  time_s.type = vpiSimTime;
  time_s.low = 0;
  time_s.high = 0;
  cb_data_s.reason = cbReadWriteSynch;
  cb_data_s.cb_rtn = fsim_simulate_good_machine;
  cb_data_s.obj = NULL;
  cb_data_s.time = &time_s;
  cb_data_s.user_data = (PLI_BYTE8 *)systf_handle; /* pass systf_h */
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
  tf_data.tfname = "$generatePatterns";
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

PLI_INT32 fsim_simulate_good_machine(p_cb_data cb_data)
{
  vpiHandle systf_h, cb_h;
  s_cb_data data_s;
  s_vpi_time time_s;
  s_vpi_value value_s;
  p_ReadStimData StimData; /* pointer to a ReadStimData structure */
  PLI_INT32 inputSize;
  char *onePat;
  int j;

  /* retrieve system task handle from user_data */
  systf_h = (vpiHandle)cb_data->user_data;
  /* get ReadStimData pointer from work area for this task instance */
  StimData = (p_ReadStimData)vpi_get_userdata(systf_h);
  StimData->gm_value = NULL;
  inputSize = vpi_get(vpiSize, StimData->patin_h);
  onePat = malloc(inputSize+1 * sizeof(char));
  switch (StimData->patIndex++)
  {
    case 0:
    {
      j = 0;
      while (j < inputSize)
        onePat[j++] = '0';
    }
    break;
    case 1:
    {
      j = 0;
      while (j < inputSize)
      {
        onePat[j++] = '0';
        onePat[j++] = '1';
      }
    }
    break;
    case 2:
    {
      j = 0;
      while (j < inputSize)
      {
        onePat[j++] = '1';
        onePat[j++] = '0';
      }
    }
    break;
    case 3:
    {
      j = 0;
      while (j < inputSize)
        onePat[j++] = '1';
    }
    break;
    default:
    {
      fclose(StimData->pat_ptr);
      fclose(StimData->rpt_ptr);
      vpi_control(vpiFinish, 1); /* finish simulation */
      vpi_printf("Total faults %d  Detected %d  Coverage %d\n", StimData->totalFaults, StimData->detectedFaults, 100 * StimData->detectedFaults/StimData->totalFaults);
      return(0);
    }
      // atpg algorithms
    break;
  }
  onePat[inputSize] = '\0';
  if (StimData->detectedFaults == StimData->totalFaults)
  {
    fclose(StimData->pat_ptr);
    fclose(StimData->rpt_ptr);
    vpi_control(vpiFinish, 1); /* finish simulation */
    vpi_printf("Total faults %d  Detected %d  Coverage %d\n", StimData->totalFaults, StimData->detectedFaults, 100 * StimData->detectedFaults/StimData->totalFaults);
    return(0);
  }
  else
  {
    fprintf(StimData->pat_ptr, "%s\n", onePat);
    vpi_printf("Total faults %d  Detected %d  Coverage %d\n", StimData->totalFaults, StimData->detectedFaults, 100 * StimData->detectedFaults/StimData->totalFaults);
    value_s.format = vpiBinStrVal;
    value_s.value.str = onePat;
    vpi_put_value(StimData->patin_h, &value_s, NULL, vpiNoDelay);
    vpi_printf("Pat has the value %s\n", value_s.value.str);
  }
  if (onePat)
    free(onePat);
  /* schedule callback to this routine when time to read next vector */
  time_s.type = vpiSimTime;
  time_s.low = 0;
  time_s.high = 0;
  data_s.reason = cbReadWriteSynch;
  data_s.cb_rtn = fsim_simulate_faulty_machine;
  data_s.obj = NULL; /* object required for scaled delays */
  data_s.time = &time_s;
  data_s.value = NULL;
  data_s.user_data = (PLI_BYTE8 *)systf_h;
  cb_h = vpi_register_cb(&data_s);
  if (vpi_chk_error(NULL))
    vpi_printf("An error occurred registering ReadNextStim callback\n");
  else
    vpi_free_object(cb_h); /* don’t need callback handle */

  return (0);
}
PLI_INT32 fsim_simulate_faulty_machine(p_cb_data cb_data)
{
  vpiHandle systf_h, cb_h;
  s_cb_data data_s;
  s_vpi_time time_s;
  s_vpi_value value_s;
  p_ReadFaultData oneFlt;
  p_ReadStimData StimData;
  char *netName;

  /* retrieve system task handle from user_data */
  systf_h = (vpiHandle)cb_data->user_data;
  /* get ReadStimData pointer from work area for this task instance */
  StimData = (p_ReadStimData)vpi_get_userdata(systf_h);

  value_s.format = vpiBinStrVal;
  vpi_get_value(StimData->patout_h, &value_s);
  if(!StimData->gm_value)
  {
    StimData->gm_value = strdup(value_s.value.str);
    vpi_printf("Output has the GM value %s\n", StimData->gm_value);
  }
  else
  {
    oneFlt = StimData->fault_data[StimData->faultIndex++];
    netName = vpi_get_str(vpiFullName, oneFlt->fault_h);
    if (strcmp(StimData->gm_value, value_s.value.str))
    {
      vpi_printf("Output has the FM value %s\n", value_s.value.str);
      vpi_printf("Fault %s %s detected\n", netName, oneFlt->faultModel);
      strcpy(oneFlt->faultStatus, "DET");
      StimData->detectedFaults++;
      fprintf(StimData->rpt_ptr, "%s %s %s DET\n", netName, oneFlt->faultModel, oneFlt->faultClass);
    }
    vpi_put_value(oneFlt->fault_h, &value_s, NULL, vpiReleaseFlag);
  }

  /* read next fault from the fault array */
  oneFlt = StimData->fault_data[StimData->faultIndex];
  while (oneFlt && !strcmp(oneFlt->faultStatus, "DET"))
    oneFlt = StimData->fault_data[++StimData->faultIndex];
  if (oneFlt)
  {
    if (!strcmp(oneFlt->faultModel, "SA0"))
      value_s.value.str = "0";
    if (!strcmp(oneFlt->faultModel, "SA1"))
      value_s.value.str = "1";
    vpi_put_value(oneFlt->fault_h, &value_s, NULL, vpiForceFlag);

    /* schedule callback to this routine when time to read next vector */
    time_s.type = vpiSimTime;
    time_s.low = 0;
    time_s.high = 0;
    data_s.reason = cbReadWriteSynch;
    data_s.cb_rtn = fsim_simulate_faulty_machine;
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
  else
  {
    StimData->faultIndex = 0;
    /* schedule callback to GM routine when time to read next vector */
    time_s.type = vpiSimTime;
    time_s.low = 0;
    time_s.high = 0;
    data_s.reason = cbReadWriteSynch;
    data_s.cb_rtn = fsim_simulate_good_machine;
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
  return (0);
}
