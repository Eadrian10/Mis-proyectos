#PROPOSITO: Este programa encuentra el maximo numero de una
#	    lista de datos.
#
# %ebx - Dato más grande encontrado
# %eax - Dato actual
#
# La siguiente localidad de memoria se uso:
#
# data_items - contiene los datos de la lista. A 0 es usado
#
# para terminar lo datos

.section .data
data_items:			#These are the data items
.long 3,67,34,222,45,75,54,34,44,33,22,11,66,0

.section .text

.globl _start
_start:
movl $0, %edi			#mover 0 al registro de indice
movl data_items(,%edi,4), %eax	#carga el primer byte de datos
movl %eax, %ebx			#este es le primer elemento de la lista,
				#%eax este es el mas grande
start_loop:
cmpl $0, %eax			#comprueba si hemos llegado al final
je loop_exit
incl %edi			#carga el siguiente valor
movl data_items(,%edi,4),%eax
cmpl %ebx, %eax			#comprueba valores
jle start_loop			#salta al ciclo si es nuevo
				#uno que no es el más grande
movl %eax, %ebx			#mueve el valor como el más grande
jmp start_loop			#salta al inicio del ciclo

loop_exit:

# %ebx es el codigo de estado para la llamada al sistema de salida
# y ya tiene el numero maximo
movl $1, %eax			#1 es la llamada de salida
int $0x80

