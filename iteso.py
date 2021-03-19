import numpy as np

A = np.matrix( ((2,3), (3, 5)) )
B = np.matrix( ((1,2), (5, -1)) )
print(A)
print(B)

C = A * B
print(C)

# Matriz identidad
I = np.identity(3)
print(I)
