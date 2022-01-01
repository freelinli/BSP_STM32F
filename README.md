# BSP_STM32F



## HOW TO USE DOCKER

refer to docker/README.md

- before plugging in the stlink.
```
free@free-VirtualBox:~$ ls /dev/bus/usb/001/00*  -ls
0 crw-rw-r-- 1 root root 189, 0 1月   1 09:41 /dev/bus/usb/001/001
0 crw-rw-r-- 1 root root 189, 1 1月   1 09:42 /dev/bus/usb/001/002
```

- after plugging in the stlink.


```
free@free-VirtualBox:~$ ls /dev/bus/usb/001/00*  -ls
0 crw-rw-r-- 1 root root 189, 0 1月   1 09:41 /dev/bus/usb/001/001
0 crw-rw-r-- 1 root root 189, 1 1月   1 09:42 /dev/bus/usb/001/002
0 crw-rw-r-- 1 root root 189, 2 1月   1 09:58 /dev/bus/usb/001/003


sudo docker run -it --rm --privileged -v /dev/bus/usb/001/003:/dev/bus/usb/001/003 -v  $HOME:/home arm_build_gdb_env:v16.01


root@a4efc60f68fa:/# ls

bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin
srv  sys  tmp  usr  var

root@a4efc60f68fa:/# cd /home/

root@05d8e7cd1304:/home# st-info  --probe
Found 1 stlink programmers
 serial:     573f6d06513f54573338103f
 hla-serial: "\x57\x3f\x6d\x06\x51\x3f\x54\x57\x33\x38\x10\x3f"
 flash:      524288 (pagesize: 2048)
 sram:       65536
 chipid:     0x0414
 descr:      F1xx High-density


openocd  -f /usr/local/share/openocd/scripts/interface/stlink-v2.cfg  -f /usr/local/share/openocd/scripts/target/stm32f1x.cfg swd

```


## DELETE THE COMMENTS

```

%s/\/\/.*//g

```

## Folder tree

```
.
.
├── docker
│   ├── Dockerfile
│   ├── README.md
│   └── sources.list
├── libraries
│   ├── CMSIS
│   │   ├── core_cm3.c
│   │   ├── core_cm3.h
│   │   ├── core_cm3.o
│   │   ├── startup
│   │   ├── stm32f10x.h
│   │   ├── system_stm32f10x.c
│   │   ├── system_stm32f10x.h
│   │   └── system_stm32f10x.o
│   ├── FWlib
│   │   ├── inc
│   │   └── src
│   ├── README.md
│   ├── stm32_f103ze_flash.ld
│   └── stm32f10x_stdperiph_lib_um.chm
├── Makefile
├── out
│   ├── app.bin
│   ├── app.elf
│   └── app.map
├── README.md
└── user
    ├── led
    │   ├── bsp_led.c
    │   ├── bsp_led.h
    │   └── bsp_led.o
    ├── main.c
    ├── main.o
    ├── stm32f10x_conf.h
    ├── stm32f10x_it.c
    ├── stm32f10x_it.h
    └── stm32f10x_it.o


```


