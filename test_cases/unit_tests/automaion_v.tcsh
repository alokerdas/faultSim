#!/usr/bin/tcsh -f

set script_dir = "$PWD"
set gatesToCheck = "$*"
if ($#gatesToCheck < 1) then
  echo "Usage ./automaion_v.tcsh *"
  echo "Usage ./automaion_v.tcsh ad*"
  echo "Usage ./automaion_v.tcsh adder"
  echo "Use * to run similar directories. For example a* will run all the directories starting with a"
  exit (1)
endif

set path=($HOME/projects/install/iverilog/bin $path)
set local_cmd = "./runme"
set default_cmd1 = "iverilog ../atpg.vpi ../faultEnum.vpi test.v"
set default_cmd2 = "./a.out"
set patlist = "pat.txt"
set faultlist = "fault.txt"
set faultlog = "fault.rpt"
set faultgold = "$faultlog.gold"
set fullog = "$script_dir/detailed.log"
set faillog = "$script_dir/fail.log"
set paslog = "$script_dir/pas.log"
rm -f $fullog $faillog $paslog

iverilog-vpi ../../source/faultEnum.c
iverilog-vpi ../../source/atpg.c
foreach gate ($gatesToCheck)
  if (-d $gate ) then
    cd $gate
    echo "Running $gate..."
    echo "Running $gate..." >>& $fullog
    if (-e $local_cmd) then
      $local_cmd >>& $fullog
    else
      $default_cmd1 >>& $fullog
      $default_cmd2 >>& $fullog
    endif
    if (-e $faultlog) then
      if (-z $faultlog) then
        echo "$gate did not run properly"
        echo "$gate did not run properly" >> $fullog
      else
        # iverilog ran correctly
        if (-e $faultgold) then
          diff $faultgold $faultlog >>& $fullog
          if ($status) then
            echo $gate FAIL
            echo $gate FAIL >> $faillog
          else
            echo $gate PASS
            echo $gate PASS >> $paslog
            rm -f $faultlog $faultlist $patlist a.out
          endif
        else
          # copy fault log to fault golden log
          mv $faultlog $faultgold
        endif
      endif
    else
echo debug
      echo "$gate did not run properly"
      echo "$gate did not run properly" >> $fullog
      echo "$gate did not run properly" >> $faillog
    endif
    cd ..
  else
    echo "No directory, Skipping the $gate"
    echo "No directory, Skipping the $gate" >> $fullog
    echo "No directory, Skipping the $gate" >> $faillog
  endif
end
