# make
# make clean

HelloWorld: HelloWorld.o
	ld -o HelloWorld HelloWorld.o

HelloWorld.o: HelloWorld.s
	as -o HelloWorld.o HelloWorld.s

clean:
	rm HelloWorld.o HelloWorld
