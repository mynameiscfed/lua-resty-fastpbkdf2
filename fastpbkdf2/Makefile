ifdef WITH_OPENMP
  CFLAGS += -fopenmp -DWITH_OPENMP
  LDFLAGS += -fopenmp
endif

CFLAGS += -std=c99 -O3 -g -Wall -Werror -Wextra -pedantic -fPIC
LDLIBS += -lcrypto
LD_LIBRARY_PATH ?= /usr/lib
CC := gcc

MAJOR := 0
MINOR := 1
NAME := fastpbkdf2
VERSION := $(MAJOR).$(MINOR)

all: testfastpbkdf2 libfastpbkdf2.a bench benchmulti lib

testfastpbkdf2: fastpbkdf2.o testfastpbkdf2.o

libfastpbkdf2.a: fastpbkdf2.o
	$(AR) r $@ $^

lib: lib$(NAME).so.$(VERSION)

lib$(NAME).so.$(VERSION): $(NAME).o
	$(CC) -shared -Wl,-soname,lib$(NAME).so.$(MAJOR) $^ -o $@

bench: bench.o fastpbkdf2.o
benchmulti: benchmulti.o fastpbkdf2.o

test: testfastpbkdf2
	./testfastpbkdf2

runbench: bench benchmulti
	./bench
	./benchmulti

install: lib
	install -m 644 lib$(NAME).so.$(VERSION) $(LD_LIBRARY_PATH)
	cd $(LD_LIBRARY_PATH) && \
	ldconfig -l lib$(NAME).so.$(VERSION) && \
	ln -s lib$(NAME).so.$(MAJOR) lib$(NAME).so

.PHONY : clean
clean:
	rm -f *.o *.so *.so.* libfastpbkdf2.a testfastpbkdf2
