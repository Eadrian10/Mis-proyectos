
#PROPOSITO: Dado un numero, este programa calcula el factorial
# del numero dado. Por ejemolo, el factorial de:
# 3 es 3*2*1, o 6. El factorial de
# 4 es 4*3*2*1 o 24, y así sucesivamente.
#

# Este programa muestra como llamar una funcion recursivamente

.section .data

# Este programa no tiene datos globales

.section .text
.globl _start
.globl factorial		#esto no es necesario a menos que deseemos
				#compartir esta función entre otros programas
_start:
pushl $4			#El factorial toma un argumento: el número
				#que queremos un factorial de. Entonces, se 
				#empuja
call factorial			#corre la funcion factorial
addl $4, %esp			#comprime el parametro que se empujo en la pila
movl %eax, %ebx			#el factorial debuelve la respuesta en %eax,
				#pero queremos que sea en %ebx para enviarla
				#como estado de salida
movl $1, %eax			#llama a la funcion de salida del kernel
int $0x80

#Este es la funcion real de la funcion 
.type factorial,@function
factorial:
pushl %ebp			#cosas de funcion estandar - tenemos que
				#restaurar %ebp a su estado previo antes de
				#devolver, así que tenemos que empujarlo
movl %esp, %ebp			#Estp es porque no queremos modificar el 
				#puntero de la pila, por lo que usamos %ebp
movl 8 (%ebp), %eax		#Esto mueve el primer argumento a 
				#%eax 4 (%ebp) contiene la direccion de retorno,
				#y 8 (%ebp) contiene el primer parametro
cmpl $1, %eax			#Si le nuemero es 1, ese es nuestro caso base,
				#y simplemente regresamos (1 ya esta en %eax
				#como el valor de retorno)
je end_factorial
decl %eax			#en otro caso, drecese el valor
pushl %eax			#empuja para nuestra llamada a factorial
call factorial			#llama a factorial
movl 8 (%ebp), %ebx		#%eax tiene el valor de retorno, asi que 
				#carga nuestros parametros en %ebx
imull %ebx, %eax		#multiplique eso por el resultado de la ultima
				#llamada a factorial (en %eax), la respuesta 
				#se almacena en %eax, lo cual es bueno ya que
				#es donde van los valores de retorno
end_factorial:
movl %ebp, %esp			#funcion estandar devuelve stuff-we
popl %ebp			#tiene que restaurar %ebp y %esp a donde estaban
				#antes de que la funcion comenzara a regresar
				#a la funcion (esto tambien muestra el valor de 
				#retorno)
ret
