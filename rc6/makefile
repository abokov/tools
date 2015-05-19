CFLAGS = -g -Wall

CC = gcc
LIBS =  -lm 
INCLUDES =
OBJS = rc6.o rc6_main.o 
SRCS = rc6.cpp rc6_main.cpp
all: rc6_main

# The variable $@ has the value of the target. In this case $@ = psort
prog1: rc6.o ${OBJS}
	${CC} ${CFLAGS} ${INCLUDES} -o $@ rc6.o ${OBJS} ${LIBS}

.c.o:
	${CC} ${CFLAGS} ${INCLUDES} -c $<

depend: 
	makedepend ${SRCS}

clean:
	rm *.o core *~
tar:
	tar cf code.tar  Makefile *.c *.h testfile1

print:
	more Makefile $(HDRS) $(SRCS) | enscript -2r -p listing.ps


# DO NOT DELETE

