# Copyright (C) 2017-2018  Elias Rabel
#To use with Intel
#module load intel_compilers/oneapi
#LD_LIBRARY_PATH=/net2/nnz/opt/miniconda/lib:/usr/local/x64/intel/oneapi/compiler/2021.3.0/linux/compiler/lib/intel64_lin 

FC=ifort
!FC=gfortran
FFLAGS=-Wall -g -O2
PY_VERSION=3

ifeq ($(FC),ifort)
  FFLAGS=-warn all -g -O2
endif

PYTHON=python3

ifeq ($(PY_VERSION),2)
  PYTHON=python2
  FFLAGS+=-DPYTHON2
endif

PYTHON_CONFIG=$(PYTHON)-config

ifeq ($(PY_DEBUG), 1)
  PYTHON_CONFIG=$(PYTHON)-dbg-config
  FFLAGS+= -DPy_DEBUG
endif

#LDFLAGS=`$(PYTHON_CONFIG) --ldflags`
LDFLAGS += -L/net2/nnz/opt/miniconda/lib -lpython3.8

run: simple_example
	./simple_example

simple_example: simple_example.o  forpy_mod.o 
	$(FC) $(FFLAGS) $(LDFLAGS) $^ -o $@

forpy_mod.o: ../forpy_mod.F90
	$(FC) $(FFLAGS) -c -o $@ $<

%.o: %.F90
	$(FC) $(FFLAGS) -c -o $@ $<

clean:
	rm -f *.o
	rm -f *.mod
	rm -f forpy_mod.F90
	rm -f simple_example
	rm -f *.pyc
	rm -rf __pycache__

simple_example.o: forpy_mod.o
