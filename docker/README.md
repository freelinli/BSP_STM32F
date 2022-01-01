# How to build
```
docker build -t arm_build_gdb_env:v16.01 .

sudo docker images | grep env
arm_build_gdb_env                 v16.01               54186d335d1b        5 minutes ago       757MB
```
# How to donwload
```
docker pull freelin/arm_build_gdb_env:v16.01
or
docker run -it --rm --privileged -v  $HOME:/home freelin/arm_build_gdb_env:v16.01
```
# How to use
```
sudo docker run -it --rm --privileged -v /dev/bus/usb/001/003:/dev/bus/usb/001/003 -v  $HOME:/home arm_build_gdb_env:v16.01
```
- Notice: Set your usb device of stlink

# Where to get gcc
[download](https://launchpad.net/gcc-arm-embedded/+download)

[gcc-arm-none-eabi-5_4](https://launchpadlibrarian.net/287101520/gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2)

# How to GDB debug
```
free@free-VirtualBox:~/stm32f$ arm-none-eabi-gdb  out/app.elf 
GNU gdb (7.10-1ubuntu3+9) 7.10
Copyright (C) 2015 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "--host=x86_64-linux-gnu --target=arm-none-eabi".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
<http://www.gnu.org/software/gdb/documentation/>.
For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from out/app.elf...done.
(gdb) target remote 127.0.0.1:3333
Remote debugging using 127.0.0.1:3333
Info : accepting 'gdb' connection on tcp/3333
Info : device id = 0x10036414
Info : flash size = 512kbytes
undefined debug reason 7 - target needs reset
0x00000000 in ?? ()
(gdb) l
1	#include "stm32f10x.h"
2	#include "bsp_led.h"
3	
4	#include <stdio.h>
5	
6	void Delay(__IO uint32_t nCount);
7	
8	#define DELAY_TIME 0x5fffff
9	
10	int main(void)
(gdb) l
11	{
12		LED_GPIO_Config();	 
13		
14		while (1) {
15			LED1( ON );
16			Delay(DELAY_TIME);
17			LED1( OFF );
18	
19			LED2( ON );
20			Delay(DELAY_TIME);
(gdb) b 14
Breakpoint 1 at 0x8001374: file user/main.c, line 14.
(gdb) c
Continuing.
Note: automatically using hardware breakpoints for read-only addresses.
Warn : WARNING! The target is already running. All changes GDB did to registers will be discarded! Waiting for target to halt.
WARNING! The target is already running. All changes GDB did to registers will be discarded! Waiting for target to halt.


Breakpoint 1, main () at user/main.c:15
15			LED1( ON );
(gdb) 
Continuing.
Info : halted: PC: 0x08001376


Breakpoint 1, main () at user/main.c:15
15			LED1( ON );
(gdb) 
Continuing.
Info : halted: PC: 0x08001376

Breakpoint 1, main () at user/main.c:15
15			LED1( ON );
(gdb) c
Continuing.
Info : halted: PC: 0x08001376

Breakpoint 1, main () at user/main.c:15
15			LED1( ON );
(gdb) info
"info" must be followed by the name of an info command.
List of info subcommands:

info address -- Describe where symbol SYM is stored
info all-registers -- List of all registers and their contents
info args -- Argument variables of current stack frame
info auto-load -- Print current status of auto-loaded files
info auto-load-scripts -- Print the list of automatically loaded Python scripts
info auxv -- Display the inferior's auxiliary vector
info bookmarks -- Status of user-settable bookmarks
info breakpoints -- Status of specified breakpoints (all user-settable breakpoints if no argument)
info classes -- All Objective-C classes
info common -- Print out the values contained in a Fortran COMMON block
info copying -- Conditions for redistributing copies of GDB
info dcache -- Print information on the dcache performance
info display -- Expressions to display when program stops
info exceptions -- List all Ada exception names
info extensions -- All filename extensions associated with a source language
info files -- Names of targets and files being debugged
info float -- Print the status of the floating point unit
info frame -- All about selected stack frame
info frame-filter -- List all registered Python frame-filters
info functions -- All function names
info guile -- Prefix command for Guile info displays
info handle -- What debugger does when program gets various signals
info inferiors -- IDs of specified inferiors (all inferiors if no argument)
info line -- Core addresses of the code for a source line
info locals -- Local variables of current stack frame
info macro -- Show the definition of MACRO
info macros -- Show the definitions of all macros at LINESPEC
info mem -- Memory region attributes
info os -- Show OS data ARG
info pretty-printer -- GDB command to list all registered pretty-printers
info probes -- Show available static probes
info proc -- Show /proc process information about any running process
info program -- Execution status of the program
info record -- Info record options
info registers -- List of integer registers and their contents
info scope -- List the variables local to a scope
info selectors -- All Objective-C selectors
info set -- Show all GDB settings
info sharedlibrary -- Status of loaded shared object libraries
info signals -- What debugger does when program gets various signals
info skip -- Display the status of skips
info source -- Information about the current source file
info sources -- Source files in the program
info stack -- Backtrace of the stack
info static-tracepoint-markers -- List target static tracepoints markers
info symbol -- Describe what symbol is at location ADDR
info target -- Names of targets and files being debugged
info tasks -- Provide information about all known Ada tasks
info terminal -- Print inferior's saved terminal status
info threads -- Display currently known threads
info tracepoints -- Status of specified tracepoints (all tracepoints if no argument)
info tvariables -- Status of trace state variables and their values
---Type <return> to continue, or q <return> to quit---q
Quit
(gdb) info thread
  Id   Target Id         Frame 
* 1    Remote target     main () at user/main.c:15
(gdb) 

```
