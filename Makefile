CC = g++
CFLAGS = -O3 -march=native
LDFLAGS =
OPENCLINC = -I//apps/opencl_sdk/1.1.0/include
OPENCLLIB = /apps/opencl_sdk/1.1.0/lib/libOpenCL.so

all: es2 es1

es1: es1.c
	gcc $(CFLAGS) -fopenmp $< -o $@ -lm

es2: es2.cpp
	$(CC) $(CFLAGS) $< -o $@ $(OPENCLINC) $(OPENCLLIB)

clean:
	rm es2 es1
