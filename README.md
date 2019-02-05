# ESP8266 - Arduino port
Trying to unravel the arduino magic to simplify compilation for esp8266 mcus.

## Dependencies
* [esptool-ck](https://github.com/igrr/esptool-ck/); hoping to switch to simple (and more "official") [esptool](https://github.com/espressif/esptool)
* The xtensa-lx106 collection
* For now, the Arduino esp8266 library (hoping to get rid of a part of that)

## Usage
* `make` to build the bin
* `make flash` to flash the mcu
