#include <string.h>
#include <stdlib.h>
#include <vpi_user.h>

PLI_INT32 fenum_compiletf(PLI_BYTE8 *user_data)
{
  vpiHandle systf_handle, arg_iterator, arg_handle;

  /* obtain a handle to the system task instance */
  systf_handle = vpi_handle(vpiSysTfCall, NULL);
  if (systf_handle == NULL)
  {
    vpi_printf("ERROR: $faultEnumerate failed to obtain systf handle\n");
    vpi_control(vpiFinish,0); /* abort simulation */
    return(0);
  }
  /* obtain handles to system task arguments */
  arg_iterator = vpi_iterate(vpiArgument, systf_handle);
  if (arg_iterator == NULL)
  {
    vpi_printf("ERROR: $faultEnumerate requires one argument\n");
    vpi_control(vpiFinish,0); /* abort simulation */
    return(0);
  }
  /* check the type of object in system task arguments */
  arg_handle = vpi_scan(arg_iterator);
  if (vpi_get(vpiType, arg_handle) != vpiConstant)
  {
    vpi_printf("ERROR: $faultEnumerate first argument must be a filename within quotes\n");
    vpi_free_object(arg_iterator); /* free iterator memory */
    vpi_control(vpiFinish,0); /* abort simulation */
    return(0);
  }
  arg_handle = vpi_scan(arg_iterator);
  if (arg_handle != NULL)
  {
    vpi_printf("ERROR: $faultEnumerate cannot have more than one argument\n");
    vpi_free_object(arg_iterator); /* free iterator memory */
    vpi_control(vpiFinish,0); /* abort simulation */
    return(0);
  }
  return(0);
}
PLI_INT32 fenum_calltf(PLI_BYTE8 *user_data)
{
  vpiHandle systf_handle, arg_iterator, arg_handle;
  vpiHandle module_iter, module_h, net_iter, net_h;
  s_vpi_value current_value;
  char *fileName, *netName;

  /* obtain a handle to the system task instance */
  systf_handle = vpi_handle(vpiSysTfCall, NULL);
  /* obtain handle to system task argument
  compiletf has already verified only 1 args with correct type */
  arg_iterator = vpi_iterate(vpiArgument, systf_handle);
  arg_handle = vpi_scan(arg_iterator);
  current_value.format = vpiStringVal;
  vpi_get_value(arg_handle, &current_value);
  fileName = current_value.value.str;
  vpi_printf("Fault file %s \n", fileName);
  FILE *flt_ptr = fopen(fileName, "w");
  if (flt_ptr)
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
        fprintf(flt_ptr, "%s SA0 DOM UND\n", netName);
        fprintf(flt_ptr, "%s SA1 DOM UND\n", netName);
      }
    }
    fclose(flt_ptr);
  }
  else
  {
    vpi_printf("ERROR: $faultEnumerate could not open fault file %s\n", fileName);
    vpi_control(vpiFinish, 1); /* abort simulation */
    return(0);
  }
  vpi_free_object(arg_iterator); /* free iterator memory */
  return(0);
}
void fenum_register()
{
  s_vpi_systf_data tf_data;
  tf_data.type = vpiSysTask;
  tf_data.sysfunctype = 0;
  tf_data.tfname = "$faultEnumerate";
  tf_data.calltf = fenum_calltf;
  tf_data.compiletf = fenum_compiletf;
  tf_data.sizetf = NULL;
  tf_data.user_data = NULL;
  vpi_register_systf(&tf_data) ;
  return;
}
void (*vlog_startup_routines[])() = {
  fenum_register,
  0
};
