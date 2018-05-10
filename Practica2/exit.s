#PURPOSE:
#
# Simple program that exits and return a status code back to the Linux kernel

#INPUT:
#none

#OUTPUT: returns a status code. This can be viewed
# by typing
#
# echo $?
#
# after running the program
#

#VARIABLES
# %eax holds the system call number
# %ebx holds the returns status
#
.section .data  # secction divide el programa en secciones e inicia
		# la seccion datos 
.section .text  # inicia la seccion de texto donde viven las instrucciones
		# del programa
		# 
.globl _start   # le indica al ensamblador que _start es importante y no debe
		# descartarse despues del ensamblaje porque el enlazador lo nece		# sitará
_start:         # _start es un simbolo, los simbolos generalmente se usan para			# marcar
		# ubicaiones de programas o datos
movl $1, %eax	# this is the linux kernel comand
		# number (system call) for exiting
		# a program

movl $0, %ebx	# this is the status number we will
		# return to the operating system.
		# Change this around and it will
		# return different things to
		# echo $?

int $0x80	# this wakes up the kernel to run
		# the exit comand
