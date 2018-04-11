all: hello

hello:helloworld.asm
	nasm -f elf helloworld.asm -o helloworld.o
	gcc -m32 helloworld.o -o hello

hello1:hello.s
	as --32 -o hello.o hello.s
	gcc -m32 -o hello1 hello.s

hello2:helloworld.asm hello.s
	as --32 -o hello.o hello.s
	nasm -f elf -o helloworld.o helloworld.asm
	gcc -m32 -o hello2 hello.o helloworld.o

clean:
	rm- vf hello hello1 *.o		
