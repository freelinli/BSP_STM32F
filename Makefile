PWD=$(shell pwd)
OUTDIR=${PWD}/out
TARGET=${OUTDIR}/app
CC=arm-none-eabi-gcc
GDB=arm-none-eabi-gdb
OBJCOPY=arm-none-eabi-objcopy
NOT_INCLUDE_DIR=demo
RM=rm -f
CORE=3
CPUFLAGS=-mthumb -mcpu=cortex-m$(CORE)
LDFLAGS = -T libraries/stm32_f103ze_flash.ld -Wl,-cref,-u,Reset_Handler -Wl,-Map=$(TARGET).map -Wl,--gc-sections -Wl,--defsym=malloc_getpagesize_P=0x80 -Wl,--start-group -lc -lm -Wl,--end-group --specs=nano.specs --specs=nosys.specs -std=gnu99
CFLAGS=$(INCFLAGS) -D STM32F10X_HD -D USE_STDPERIPH_DRIVER -g -o

INCFLAGS=-I $(PWD)/libraries/CMSIS -I $(PWD)/libraries/CMSIS/startup -I $(PWD)/libraries/FWlib/inc -I $(PWD)/user  -I $(PWD)/user/led
C_SRC=$(shell find . -path ./$(NOT_INCLUDE_DIR)  -prune -o -type f -name '*.c' -print)
C_OBJ=$(C_SRC:%.c=%.o)

START_SRC=$(shell find ./ -name 'startup_stm32f10x_hd.s')
START_OBJ=$(START_SRC:%.s=%.o)

all:bin

$(TARGET):$(START_OBJ) $(C_OBJ)
	$(CC) $^ $(CPUFLAGS) $(LDFLAGS) $(CFLAGS) $(TARGET).elf
	ls -lsh ${TARGET}*
	file ${TARGET}*
$(C_OBJ):%.o:%.c
	$(CC) -c $^ $(CPUFLAGS) $(CFLAGS) $@

$(START_OBJ):$(START_SRC)
	$(CC) -c $^ $(CPUFLAGS) $(CFLAGS) $@
bin:$(TARGET)
	$(OBJCOPY) $(TARGET).elf $(TARGET).bin
hex:
	$(OBJCOPY) $(TARGET).elf -Oihex $(TARGET).hex
debug: $(TARGET).elf
	@printf "  GDB DEBUG $<\n"
	openocd  -f /usr/share/openocd/scripts/interface/stlink-v2.cfg -f /usr/share/openocd/scripts/target/stm32f1x.cfg > /dev/null &
	# $(GDB) -> target remote localhost:3333 -> monitor reset -> monitor halt -> load -> b main -> info b -> c
	@echo "Using GDB to debug, then killall openocd after debugging~"
clean:
	$(RM) $(shell find ./ -name '*.o') $(TARGET).* *~
download:
	openocd  -f /usr/share/openocd/scripts/interface/stlink-v2.cfg -f /usr/share/openocd/scripts/target/stm32f1x.cfg -c init -c  "reset halt" -c "flash write_image erase $(TARGET).bin" -c "reset run" -c shutdown 
