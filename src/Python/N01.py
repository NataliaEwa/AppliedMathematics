#! /usr/bin/env python3

# how to run:
#    pytest-3 matrixmult.py


import pytest
import numpy as np

a = np.array([[1, 2], [3, 4], [5, 6]])
b = a.transpose()

x=len(a)

c = [[0]*x for i in range(x)]

def multiply(a, b):
for i in x:
	for j in x:
			if i=1 and j=1
			C[i,j] = a[(i+x-1)%x,(j+x-1)%x]*b[(i+x-1)%x,(j+x-1)%x] + a[(i+x)x,(j+x-1)%x]*b[(i++x-1+%x,(j+x)%x] + a[(i+x+1)%x,(j+x-1)%x]*b[(i+x-1)%x,(j+x+1)%x]
    pass


def multiplyWithNumpy(a, b):
    # fix me!
    pass


testdata = [
    ([[3]], [[6]], [[18]]),
    ([[1, 2]],   [[3], [4]], [[11]]),
    ([[1, 2, 3], [4, 5, -7]],  [[3, 0, 4], [2, 5, 1], [-1, -1, 0]],  [[4, 7, 6], [29, 32, 21]])
]
@pytest.mark.parametrize("multiplicationFunc", [multiply, multiplyWithNumpy])
@pytest.mark.parametrize("a,b,expected", testdata)
def test_multiply(multiplicationFunc, a, b, expected):
    assert np.array_equal(multiplicationFunc(a, b), expected)


testdataImpossibleProducts = [
    ([[3, 4]], [[6, 7]]),
    ([[1, 2]], [[3, 4], [4, 5], [5, 6]])
]
@pytest.mark.parametrize("multiplicationFunc", [multiply, multiplyWithNumpy])
@pytest.mark.parametrize("a,b", testdataImpossibleProducts)
def test_multiplyIncompatibleMatrices(multiplicationFunc, a, b):
    with pytest.raises(Exception) as e:
        multiplicationFunc(a, b)