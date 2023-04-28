#include <vpi_user.h>
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
  /* check that there are no more system task arguments */
  arg_handle = vpi_scan(arg_iterator);
  arg_type = vpi_get(vpiType, arg_handle);
  if (arg_type != vpiConstant)
  {
    vpi_printf("ERROR: $faultSimulate second arg must be filename within quotes\n");
    vpi_free_object(arg_iterator); /* free iterator memory */
    vpi_control(vpiFinish,0); /* abort simulation */
    return(0);
  }
  arg_handle = vpi_scan(arg_iterator);
  arg_type = vpi_get(vpiType, arg_handle);
  if (arg_type != vpiConstant)
  {
    vpi_printf("ERROR: $faultSimulate second arg must be filename within quotes\n");
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
PLI_INT32 fsim_calltf(PLI_BYTE8 *user_data)
{
  vpiHandle systf_handle, arg_iterator, arg_handle, reg_handle;
  s_vpi_value current_value;
  /* obtain a handle to the system task instance */
  systf_handle = vpi_handle(vpiSysTfCall, NULL);
  /* obtain handle to system task argument
  compiletf has already verified only 3 args with correct type */
  arg_iterator = vpi_iterate(vpiArgument, systf_handle);
  reg_handle = vpi_scan(arg_iterator);
  /* read current value */
  current_value.format = vpiBinStrVal; /* read value as a string */
  vpi_get_value(reg_handle, &current_value);
  vpi_printf("Signal %s ", vpi_get_str(vpiFullName, reg_handle));
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
  if (fscanf(patFile, "%s\n", onePat))
  {
  current_value.format = vpiBinStrVal;
  current_value.value.str = onePat;
  vpi_put_value(reg_handle, &current_value, NULL, vpiNoDelay);
  vpi_printf("has the value %s\n", current_value.value.str);
  }
  else
  {
    vpi_printf("ERROR: $faultSimulate could not read pattern \n");
    vpi_control(vpiFinish, 1); /* abort simulation */
    return(0);
  }

  arg_handle = vpi_scan(arg_iterator);
  current_value.format = vpiStringVal;
  vpi_get_value(arg_handle, &current_value);
  vpi_printf("Fault file %s \n", current_value.value.str);

  vpi_free_object(arg_iterator); /* free iterator memory */
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

