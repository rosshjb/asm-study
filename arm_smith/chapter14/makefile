# make
# make DEBUG=1 -B
# make clean

UPPER1OBJS = main12.o upper1.o
UPPER2OBJS = main12.o upper2.o
UPPER3OBJS = upper3.o
UPPER4OBJS = main4.o upper4.o

ifdef DEBUG
	DEBUGFLGS = -g
else
	DEBUGFLGS =
endif

LSTFLGS =

.PHONY: all
all: upper1 upper2 upper3 upper4

%.o: %.s
	as $(DEBUGFLGS) $(LSTFLGS) $< -o $@

upper1: $(UPPER1OBJS)
	ld -o upper1 $(UPPER1OBJS)

upper2: $(UPPER2OBJS)
	ld -o upper2 $(UPPER2OBJS)

upper3: $(UPPER3OBJS)
	ld -o upper3 $(UPPER3OBJS)

upper4: $(UPPER4OBJS)
	ld -o upper4 $(UPPER4OBJS)

.PHONY: clean
clean:
	rm -f upper1 upper2 upper3 upper4 $(UPPER1OBJS) $(UPPER2OBJS) $(UPPER3OBJS) $(UPPER4OBJS)
