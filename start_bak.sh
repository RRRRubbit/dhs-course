#!/bin/bash 

module_a="module load mentor/ams/2017.1-64"
module_ls="module list"
 
echo $module_a
list=("module list")

echo "Starting Questasim"


cd 
if [ -d dhs/vhdl -o -d ../dhs/vhdl ]
	then 
		echo "VHDL files already exist!"
        cd dhs
        cd vhdl
        eval "$module_a"
        eval "$module_ls"
        cp -f /home/4all/tmp/DHS_VHDL/src/pwm_controller.vhd ./src/
#        mv ./src/pwm_driver.vhd ./src/pwm_driver.vhd.bak
#        cp -f /home/4all/tmp/DHS_VHDL/src/pwm_driver.vhd ./src/
        if [ -d work ]
            then
            echo "work library already exist!"
            vsim src/tb_PWM_digital_top.vhd src/pwm_digital_top.vhd src/tb_pwm_driver.vhd src/pwm_driver.vhd &
        else
            vlib work
            vsim src/tb_PWM_digital_top.vhd src/pwm_digital_top.vhd src/tb_pwm_driver.vhd src/pwm_driver.vhd &
        fi
else
    if [ -d dhs ]
        then
        cd dhs
        mkdir vhdl
        cd vhdl
        rsync -r --exclude=start.* /home/4all/tmp/DHS_VHDL/ .
        eval "$module_a"
        vlib work
        vsim src/tb_PWM_digital_top.vhd src/pwm_digital_top.vhd src/tb_pwm_driver.vhd src/pwm_driver.vhd &

    else
        mkdir dhs
        cd dhs
        mkdir vhdl
        cd vhdl
        rsync -r --exclude=start.* /home/4all/tmp/DHS_VHDL/ .
        eval "$module_a"
        vlib work
        vsim src/tb_PWM_digital_top.vhd src/pwm_digital_top.vhd src/tb_pwm_driver.vhd src/pwm_driver.vhd &
    fi
fi

