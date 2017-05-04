function mandel(z,maxiter)
    c = z
    #maxiter = 1000
    for n = 1:maxiter
        if abs(z) > 2
            return n-1
        end
        z = z^2 + c
    end
    return maxiter
end

mandelperf(w,h,maxiter) = [ mandel(complex(r,i),maxiter) for i=-1.:(2.0/h):1., r=-2.0:(3.0/w):1 ]
sum(mandelperf(140,50,1e5))


