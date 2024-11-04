# make
# make DEBUG=1
# make DEBUG=1 -B
# make clean

UPPEROBJS = main.o upper.o

ifdef DEBUG
	DEBUGFLGS = -g
else
	DEBUGFLGS =
endif

all : upper

%.o: %.S
	gcc $(DEBUGFLGS) -c $< -o $@

$.o: $.s
	as $(DEBUGFLGS) $< -o $@

upper: $(UPPEROBJS)
	ld -o upper $(UPPEROBJS)

clean:
	rm $(UPPEROBJS) upper upper.txt
