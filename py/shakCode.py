import numpy as np
import time
import matplotlib.pyplot as plt

def shakCode():
    tic = time.time()
    zz = np.arange(-2, 2, 0.01)
    n = 200
    alpha = np.random.rand(n, 1)
    m = np.linalg.norm(np.sum(alpha))/2
    y2 = iteratoverfuncnewton(alpha, zz, m)
    plt.plot(zz, y2)
    elapsedTime = time.time() - tic
    print(f"Execution time: {elapsedTime} seconds")
    elapsedTime = elapsedTime / 60
    print(f"Execution time: {elapsedTime:.4f} minutes")

def iteratoverfuncnewton(alpha, zz, m):
    n = alpha.shape[0]
    correctedvs = np.zeros(zz.shape[0])
    for i in range(zz.shape[0]):
        values = newton(zz[i], alpha, m, 25)
        correctedvs[i] = -(np.imag((values**2)[0]/(n*np.pi*zz[i])))
        print(f"z={zz[i]}")
    return correctedvs

def newton(z, alpha, m, iter):
    guess = -1j
    current = 0
    for _ in range(iter):
        f, fp = func1examplenewt(z, alpha, m, guess)
        if fp != 0:
            current = guess - f/fp
            guess = current
    return guess

def func1examplenewt(z, alpha, m, guess):
    n = alpha.shape[0]
    xp = 1
    yp = 0
    rp = 0
    for i in range(n):
        xp = xp * (z - alpha[i] * guess)
    for i in range(n):
        if z - alpha[i] * guess != 0:
            yp = yp + alpha[i] * (xp / (z - alpha[i] * guess))
    y = 2 * m * guess * xp - yp
    for i in range(n):
        for j in range(n):
            if i != j:
                ff = (z - alpha[i] * guess) * (z - alpha[j] * guess)
                if ff != 0:
                    rp = rp + alpha[i] * (alpha[j] * xp / ff)
    dy = 2 * m * (xp - guess * yp) + rp
    return y, dy

shakCode()

