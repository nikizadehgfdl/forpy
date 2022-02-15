#!/bin/env python
#Inspired from https://github.com/wangsl/python-embedding
import sys
import numpy
import matplotlib.pyplot as plt
#import torch
#A test function with one argument
def py_plot1Darray(*x) :
    #print("py_plot1Darray",x[0].shape)
    print("py_plot1Darray: Shape of the input array x : ", x[0].shape)
    a=numpy.sum(x[0][:])
    print("py_plot1Darray: sum(x[:]) ", a)
    sys.stdout.flush()
    plt.plot(x[0][:-1],marker='o');plt.show();
    return a

def py_plot1Darrays(x1,x2) :
    #return 1
    print("py_plot1Darrays: Shape of the input array x : ", x1.shape, x2.shape)
    a=numpy.sum(x1[:])
    print("py_plot1Darrays: sum(x1) ", a)
    print("py_plot1Darrays: sum(x2) ", numpy.sum(x2))
    sys.stdout.flush()
    plt.plot(x1[:],marker='o',color='r',label='before vertdiff')
    plt.plot(x2[:],marker='*',color='b',label='after  vertdiff')
    plt.legend(loc='upper right')
    plt.show();
    return a


#A test function with two arguments
def py_test2(x,y) :
    print(' **** From py_test2 ****',x,y)
    sys.stdout.flush()
    a=sum(x)
    b=sum(y)
    return a,b

#A test function with no arguments
def py_test0():
    print(' **** From py_test0 ****')
    sys.stdout.flush()
    return 

from math import sin
#import torch
#import numpy  #This gives all kinds of library errors at runtime

def my_test_torch(x, y) :
    print(' From Python test: {}'.format(x.size))
    for i in range(x.size) :
        x[i] += 1.0

    a = torch.from_numpy(x)
    print(a)

    b = torch.from_numpy(x.astype(numpy.float32))
    print(b)

    if torch.cuda.is_available() :
        b_dev = b.cuda()
        print(b_dev)

    for i in range(y.size) :
        y[i] = 2*numpy.float64(b[i]) + 0.1

    print(y)

    sys.stdout.flush()
    
def print_args(*args, **kwargs):
    print("Arguments: ", args)
    print("Keyword arguments: ", kwargs)
    return "Returned from mymodule.print_args"

if __name__ == '__main__' :
    import numpy as np

    x = np.arange(10, dtype=numpy.float64)
    print(x)

    y = np.arange(10, dtype=numpy.float64)
    print(y)
    py_test2(x, y)
    plt.plot(x);plt.show();



