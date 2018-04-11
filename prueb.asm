.file "a.c"
.globl m
	.data
	.align 4
	.type m, @object
	.size m, 4
m:
	.long 23
	.section	.rodata
.LC0:
	.string "abcd"
	.text
.globl main
	.type main, @function
main:
	leal 4(%esp), %ecx
	andl $-16, %esp
	pushl -4(%ecx)
	pushl %ebp
	movl %esp, %ebp
	pushl %ecx
	subl $20, %esp
	movl $12, -12(%ebp)
	movl $.LC0, -8(%ebp)
	addl $20, %esp
	popl %ecx
	popl %ebp
	leal -4(%ecx), %esp
	ret
	.size main, .-main
	.comm j,4,4
	.comm k,4,4
	.ident "GCC: (GNU) 4.3.2 20081105 (Red Hat 4.3.2-7)"
	.section	.note.GNU-stack,"",@progbits