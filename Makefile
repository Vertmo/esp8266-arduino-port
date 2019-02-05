all: test.bin

test.o: test.c
	xtensa-lx106-elf-g++ -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ -I/home/vertmo/.arduino15/packages/esp8266/hardware/esp8266/2.5.0-beta3/tools/sdk/include -I/home/vertmo/.arduino15/packages/esp8266/hardware/esp8266/2.5.0-beta3/tools/sdk/lwip2/include -I/home/vertmo/.arduino15/packages/esp8266/hardware/esp8266/2.5.0-beta3/tools/sdk/libc/xtensa-lx106-elf/include -I/tmp/arduino_build_653877/core -c -w -Os -g -mlongcalls -mtext-section-literals -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -fno-exceptions -DF_CPU=80000000L -DLWIP_OPEN_SRC -DTCP_MSS=536 -DLWIP_FEATURES=1 -DLWIP_IPV6=0 -DARDUINO=10807 -DARDUINO_ESP8266_WEMOS_D1MINI -DARDUINO_ARCH_ESP8266 "-DARDUINO_BOARD=\"ESP8266_WEMOS_D1MINI\"" -DFLASHMODE_DIO -DESP8266 -I/home/vertmo/.arduino15/packages/esp8266/hardware/esp8266/2.5.0-beta3/cores/esp8266 -I/home/vertmo/.arduino15/packages/esp8266/hardware/esp8266/2.5.0-beta3/variants/d1_mini test.c -o test.o

test.esp_elf: test.o
	xtensa-lx106-elf-gcc -fno-exceptions -g -w -Os -nostdlib -Wl,--no-check-sections -u app_entry -u _printf_float -u _scanf_float -Wl,-static -L/home/vertmo/.arduino15/packages/esp8266/hardware/esp8266/2.5.0-beta3/tools/sdk/lib -Lld -L/home/vertmo/.arduino15/packages/esp8266/hardware/esp8266/2.5.0-beta3/tools/sdk/libc/xtensa-lx106-elf/lib -Teagle.flash.4m.ld -Wl,--gc-sections -Wl,-wrap,system_restart_local -Wl,-wrap,spi_flash_read -o test.esp_elf -Wl,--start-group test.o arducore.a -lhal -lphy -lpp -lnet80211 -llwip2-536-feat -lwpa -lcrypto -lmain -lwps -lbearssl -laxtls -lespnow -lsmartconfig -lairkiss -lwpa2 -lstdc++ -lm -lc -lgcc -Wl,--end-group -Lld

test.bin: test.esp_elf
	esptool -eo eboot.elf -bo test.bin -bm dio -bf 40 -bz 4M -bs .text -bp 4096 -ec -eo test.esp_elf -bs .irom0.text -bs .text -bs .data -bs .rodata -bc -ec

flash: test.bin
	esptool -cd nodemcu -cp /dev/ttyUSB0 -cb 115200 \
	-ca 0x00000 -cf test.bin

clean:
	rm -rf *.o *.d *.esp_elf *.bin

.PHONY: all flash clean