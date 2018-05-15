
#PROPOSITO: programa para ilustrar como funcionan las funciones
# Este programa podrá calcular el valor de
# 2³+5²
#
# Todo en el programa principal se almacena en registros,
# entonces la seccion de datos no tiene nada
.section .data
.section .text
.globl _start
_start:
pushl $3			#empuje el segundo argumento
pushl $2			#empuje el primer argumento
call power			#llama a la funcion potencia
addl $8, %esp			#mueve el puntero de la pila hacia atras
pushl %eax			#guarda la primera respuesta antes de
				#llamar a la siguiente funcion
pushl $2			#enpuja el segundo argumento
pushl $5			#empuja el primer argumento
call power			#llama la funcion
addl $8, %esp			#mueve el puntero de la pila hacia atras
popl %ebx			#La segunda respuesta ya esta en %eax. Guardamos
				#la primera respuesta en la pila, así que
				#ahora podemos sacarla en %ebx
addl %eax, %ebx			#agregalops juntos
				#el resultado esta en %ebx
movl $1, %eax			#salir (%ebx es retornado)
int $0x80

#PROPOSITO: Este programa es usado para calcular el valor
# de un numero elebado a una potencia.
#
#INPUT: Primer argumento - el numero base
# Segundo argumento - la potencia a elebar el numero
#
#OUTPUT: Dara el resultado como un valor entero
#
#VARIABLES:
# %ebx - tiene el numero base
# %ecx - tiene la potencia
#
# -4(%ebp) - contiene el resultado actual
#
# %eax se usa para almacenamiento temporal
#
.type power, @function
power:
pushl %ebp				#guardar puntero de base antigua
movl %esp, %ebp				#hace que le puntero de la pila sea el
					#puntero de la base
subl $4, %esp				#tener espacio para almacenamiento local
movl 8 (%ebp), %ebx			#pone el primer argumento en %eax
movl 12 (%ebp), %ecx			#pone el segundo argumento en %ecx
movl %ebx, -4 (%ebp)			#almacena el resultado actual
power_loop_start:
cmpl $1, %ecx				#si la potencia es 1, hemos acabado
je end_power
movl -4 (%ebp), %eax 			#mueve el resultado actual en  %eax
imull %ebx, %eax			#multiplica el resultado actual por
					#el resultado actual
movl %eax, -4 (%ebp)			#almacena el resultado actual
decl %ecx				#decrese la potencia
jmp power_loop_start			#corre desde la siguiente potencia
end_power:
movl -4 (%ebp), %eax			#el valor de retorno va en %eax
movl %ebp, %esp				#restaura el puntero de la pila
popl %ebp				#restaura el puntero base
ret
