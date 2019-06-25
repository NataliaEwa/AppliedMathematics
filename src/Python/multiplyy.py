import pytest
import numpy as np


class MatrixOperations:

    def Multiply(self, matrixA, matrixB):
        if len(matrixA[0]) != len(matrixB):
            return 'Wrong input types'
        result = [[0 for i in range(len(matrixB[0]))]
                  for j in range(len(matrixA))]
        for i in range(len(matrixA)):
            for j in range(len(matrixB[0])):
                for k in range(len(matrixB)):
                    result[i][j] += matrixA[i][k] * matrixB[k][j]
        return result
    pass

    def MultiplyWithNumpy(self, matrixA, matrixB):
        return np.matmul(matrixA, matrixB)
    pass


pass

myMatrixA = [[12, 7, 3],
             [4, 5, 6],
             [7, 8, 9]]

myMatrixB = [[5, 8, 1, 2],
             [6, 7, 3, 0],
             [4, 5, 9, 1]]


matrixOperations = MatrixOperations()
multiplied = matrixOperations.Multiply(myMatrixA, myMatrixB)
multipliedByNumpy = matrixOperations.MultiplyWithNumpy(myMatrixA, myMatrixB)

testResult = np.array_equal(multiplied, multipliedByNumpy)
if testResult:
    print('Matrix A')
    print(myMatrixA)
    print('Matrix B')
    print(myMatrixB)
    print('Multiplied matriix (AxB):')
    print(multiplied)
    print('Multiplied matriix by numphy:')
    print(multipliedByNumpy)
    print('Multiplied matrices are equal. Methods working good :)')
else:
    print('Multiplied matrices are not equal. Something went wrong.')

testdata = [
    ([[3]], [[6]], [[18]]),
    ([[1, 2]],   [[3], [4]], [[11]]),
    ([[1, 2, 3], [4, 5, -7]],  [[3, 0, 4], [2, 5, 1],
                                [-1, -1, 0]],  [[4, 7, 6], [29, 32, 21]])
]


@pytest.mark.parametrize("multiplicationFunc", [matrixOperations.Multiply, matrixOperations.MultiplyWithNumpy])
@pytest.mark.parametrize("a,b,expected", testdata)
def test_multiply(multiplicationFunc, a, b, expected):
    assert np.array_equal(multiplicationFunc(a, b), expected)


testdataImpossibleProducts = [
    ([[3, 4]], [[6, 7]]),
    ([[1, 2]], [[3, 4], [4, 5], [5, 6]])
]


@pytest.mark.parametrize("multiplicationFunc", [matrixOperations.Multiply, matrixOperations.MultiplyWithNumpy])
@pytest.mark.parametrize("a,b", testdataImpossibleProducts)
def test_multiplyIncompatibleMatrices(multiplicationFunc, a, b):
    with pytest.raises(Exception) as e:
        multiplicationFunc(a, b)