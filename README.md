# ESP8266 - Arduino port
Trying to unravel the arduino magic to simplify compilation for esp8266 mcus.

## Dependencies
* [esptool-ck](https://github.com/igrr/esptool-ck/); hoping to switch to simple (and more "official") [esptool](https://github.com/espressif/esptool)
* The xtensa-lx106 collection
* For now, the Arduino esp8266 library (hoping to get rid of a part of that)

## Usage
* `make` to build the bin
* `make flash` to flash the mcu

## Arduino esp8266 lib components
Inside the home arduino directory (*~/.arduino15* in my case)
* *packages/esp8266/hardware/esp8266/2.5.0-beta3/variants/d1_mini* -> pin definitions (similarly for other models)
* *packages/esp8266/hardware/esp8266/2.5.0-beta3/cores/esp8266* -> core arduino library
* *packages/esp8266/hardware/esp8266/2.5.0-beta3/tools/sdk/lib* -> sdk objects
* *packages/esp8266/hardware/esp8266/2.5.0-beta3/tools/sdk/include* -> sdk headers
* *packages/esp8266/hardware/esp8266/2.5.0-beta3/tools/sdk/libc/xtensa-lx106-elf/lib* -> libc objects
* *packages/esp8266/hardware/esp8266/2.5.0-beta3/tools/sdk/libc/xtensa-lx106-elf/include* -> libc headers

We could in theory get rid of the arduino library, although suppressing it seems to break the sdk part...

## Compilation in OMicroB
* *pgrm.c* -> *pgrm.esp_o* with `xtensa-lx106-elf-g++`
* *arducore.a*, *wrapper.o*, *pgrm.esp_o* -> *pgrm.esp_elf* with `xtensa-lx106-elf-ld`
* *pgrm.esp_elf* -> *pgrm.bin* with `esptool-ck`

## Implementation step
* Step 1: putting everything in (60Mo on disk): .text segment too big when linking with OMicroB...
