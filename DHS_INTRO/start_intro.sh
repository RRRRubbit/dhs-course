#!/bin/bash 

module_a="module load mentor/ams/2017.1-64"
module_ls="module list"
 
echo $module_a
list=("module list")

echo "Starting Questasim"


cd 
if [ -d dhs_intro -o -d ../dhs_intro ]
#if [ -d dhs/vhdl -o -d ../dhs/vhdl ]
	then 
		echo "VHDL files already exist!"
        cd dhs_intro
#        cd vhdl
        eval "$module_a"
        eval "$module_ls"

        if [ -d work ]
            then
            echo "work library already exist!"
            vsim src/pwm_controller.vhd src/tb_pwm_controller.vhd &
        else
            vlib work
            vsim src/pwm_controller.vhd src/tb_pwm_controller.vhd &
        fi
else
    if [ -d dhs_intro ]
        then
        cd dhs_intro
#        mkdir vhdl
#        cd vhdl
        rsync -r --exclude=start_lab*.* /home/4all/tmp/DHS_INTRO/ .
        eval "$module_a"
        vlib work
        vsim src/fa.vhd src/halfadder.vhd src/or_gate.vhd test/tb_fa.vhd &

    else
        mkdir ../dhs_intro
        ln -s ../dhs_intro/ ../.SLinux4/dhs_intro
        ln -s ../dhs_intro/ ../.SLinux5/dhs_intro
        ln -s ../dhs_intro/ ../.SLinux6/dhs_intro
        ln -s ../dhs_intro/ ../.SLinux7/dhs_intro
        cd dhs_intro
#        mkdir vhdl
#        cd vhdl
        rsync -r --exclude=start_lab*.* /home/4all/tmp/DHS_INTRO/ .
        eval "$module_a"
        vlib work
        vsim src/fa.vhd src/halfadder.vhd src/or_gate.vhd test/tb_fa.vhd &
        
    fi
fi

