GCC:=g++
# -lzmq
LIB_GLOG:=$(shell pkg-config --static --libs libglog)
LIBS=-lcrypto -lssl -lboost_thread -lboost_filesystem -lcurl -lboost_system -lboost_regex -lconfig++ $(LIB_GLOG) -lm  -levent -levent_pthreads -lpthread
CFLAGS=-std=c++11 -ggdb -O0 -Wall

PLATFORM=$(shell uname -s)
ifeq ($(PLATFORM),Darwin)
OPENCL_LIBS=-framework OpenCL
else
OPENCL_LIBS=-lOpenCL
endif



all: poolwatcher

poolwatcher: PoolWatcherMain.o Watcher.o Utils.o Common.o bitcoin/chainparams.o bitcoin/util.o bitcoin/core.o bitcoin/script.o # bitcoin/key.o
	$(GCC) $^ -o $@ $(CFLAGS) $(LIBS)

%.o: %.cc
	$(GCC) $^ -o $@ -c $(CFLAGS)
bitcoin/%.o: bitcoin/%.cpp
	$(GCC) $^ -o $@ -c $(CFLAGS)

clean:
	rm -f *.o poolwatcher

