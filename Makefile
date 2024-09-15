all: firmware.elf
hello.txt:
	echo "hello world!" > hello.txt

CPP=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-cpp

main.i: main.c
	$(CPP) main.c > main.i

clean:
	rm -f main.i hello.txt main.o main.s second.o firmware.elf

.PHONY: clean

CC=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-gcc
AS=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-as

main.s: main.i
	$(CC) -S main.i

%.o: %.s
	$(AS) $< -o $@

LD=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-ld
SRC=main.c second.c
OBJS=$(patsubst %.c,%.o,$(SRC))

firmware.elf: $(OBJS)
	$(LD) -o $@ $^

