# make
# make DEBUG=1 -B
# make clean

ifdef DEBUG
	DEBUGFLGS = -g
else
	DEBUGFLGS =
endif
LSTFLGS =

.PHONY: all
all: upper

upper: upper.c
	gcc $(DEBUGFLGS) -O3 -o upper upper.c

.PHONY: clean
clean:
	rm -f upper
