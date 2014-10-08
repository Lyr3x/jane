Jane
======

Jane is in a early development state.

##What is Jane?
- A system to control home devices e.g.: AVR, TV or other IR devices
- Jane uses Tasker with AutoVoice to control the system with your voice

##What is working?
- Infrared control code receiving
- Sending single infrared codes via Tasker using AutoVoice
- Sinatra Webserver

##Requirements
- Raspberry PI + raspbian
- eurocard or plugboard
- 1x IR-Emitter - TSAL 6200
- 1x IR-Receiver - TSOP4838
- 1x 1 kOhm Resistor 
- 1x 100 Ohm Resistor
- 1x bipolar Transistor NPN - BC547C
- WiFi-stick recommended for more flexibility

##Circuit plan

![Alt text](https://raw.githubusercontent.com/Lyr3x/Jarvis/master/circuit/Circuit-plan_Steckplatine.png "Circuit Plan")

##Software installation
###LIRC
**Enter the following commands:**
- ```$ sudo apt-get install lirc```
- ```$ sudo vim /etc/modules```
- **Add the following lines:**
- ```lircv_dev```
- ```lirc_rpi gpio_in_pin=22 gpio_out_pin=23```

###LIRC configuration
- ```$ cd /etc/lirc/```
- ```$ sudo vim hardware.conf```
Enter/comment the following line: 
- ```LIRCD_ARGS="--listen"``` TCP Listener at Port 8765
- ```#START_LIRCMD=false```
- ```#START_IREXEC=false```
- ```LOAD_MODULES=true```
- ```DRIVER="default"```
- ```DEVICE="/dev/lirc0"```
- ```MODULES="lirc_rpi"```
Save and quit the file and execute the following
- ```$ sudo /etc/init.d/lirc restart```

##Read key codes

- The standard configuration file is located in ```/etc/lirc/lircd.conf```
- For the first tests, create the file ```~/led.conf```
- LIRC have a lot options for key bindings, to see the options execute:
- ```$ irrecord -list namespace```
- Notice the keys you need
- To test the receiver execute: ```$ sudo irrecord -d /dev/lirc0 ~/led.conf```
- All commands are stored in ~/led.conf now. Copy the whole content in ```/etc/lirc/lircd.conf```
- For each control you have to repeat this procedure

### Send commands

- First restart the lirc daemon ```sudo /etc/init.d/lirc restart```
- To send a command execute: ```$ irsend SEND_ONCE "name of the control" "key"```
- example: ```$ irsend SEND_ONCE TV KEY_POWER```

### Android App
The Android app is located in a seperate repostiroy:
- [Jane-app](https://github.com/Lyr3x/Jarvis-app)
- 
### Coming Features
- Webinterface


## License
see [LICENSE](https://github.com/Lyr3x/Jarvis/blob/master/LICENSE) files
