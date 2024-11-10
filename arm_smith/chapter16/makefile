# make
# make DEBUG=1 -B
# make clean

UPPEROBJS = main.o upper.o

ifdef DEBUG
	DEBUGFLGS = -g
else
	DEBUGFLGS =
endif

LSTFLGS =

.PHONY: all
all: upper upper-pie upper-canary

%.o: %.s
	as $(DEBUGFLGS) $(LSTFLGS) $< -o $@

upper: $(UPPEROBJS)
	ld -o upper $(UPPEROBJS)

upper-pie: $(UPPEROBJS)
	ld -pie -o upper-pie $(UPPEROBJS)

upper-canary: upper.c
	gcc -o upper-canary -fstack-protector-all -O3 upper.c

.PHONY: clean
clean:
	rm -f upper upper-pie upper-canary $(UPPEROBJS)
