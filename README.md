Jarvis
======

Jarvis (not the final name) is a very early project.

##What is Jarvis?
- A system to control home devices e.g.: AVR, TV or other IR devices via infrarot
- Jarvis use Tasker with AutoVoice to control the system with your voice

##Requirements
- Raspberry PI + raspbian
- eurocard or plugboard
- 1x IR-Emitter - TSAL 6200
- 1x IR-Receiver - TSOP4838
- 1x 1.5 Ohm Resistor 
- 1x 200 Ohm Resistor
- 1x bipolar Transistor NPN - BC547C

##Circuit plan

coming soon!

##Software installation
###LIRC
**Enter the following commands:**
- ```$ sudo apt-get install lirc```
- ```$ sudo vim /etc/modules```
- **Add the following lines:**
- ```lircv_dev```
- ```lirc_rpi gpio_in_pin=17 gpio_out_pin=18```

###LIRC configuration
- ```$ cd /etc/lirc/```
- ```$ sudo vim hardware.conf```
Enter/comment the following line: 
- ```LIRCD_ARGS="-listen"``` TCP Listener at Port 8765
- ```#START_LIRCMD=false```
- ```#START_IREXEC=false```
- ```LOAD_MODULES=true```
- ```DRIVER="default```
- ```DEVICE="/dev/lirc0```
- ```MODULES="lirc_rpi"```
Save and quit the file and execute the following
- ```sudo /etc/init.d/lirc restart```

##Read key codes

coming soon!
