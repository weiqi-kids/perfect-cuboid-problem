\\ V_q(F_p) counts for q = 20/21, primes of good reduction
\\ V_q: c^2 + q^2 = e^2, c^2 + 1 = f^2, c^2 + 1 + q^2 = g^2

default(parisize, 2000000000);

q0_num = 20; q0_den = 21;

\\ Bad primes: those dividing 21, 29 (the d_0 numerator), and all 5 factor conductors
\\ Conductors: 4305 = 3*5*7*41, 3045 = 3*5*7*29, 48720 = 2^4*3*5*7*29, 68880 = 2^4*3*5*7*41, 249690 = 2*3*5*7*29*113
\\ So primes {2, 3, 5, 7, 29, 41, 113, ...} are bad. Try p = 11, 13, 17, 19, 23, 31, 37, 43

count_Vq_Fp(p) = {
    my(qinv, qp, cnt, c, e2, f2, g2, n_e, n_f, n_g, factor);
    if(gcd(p, q0_den) != 1, return(-1));
    qinv = lift(Mod(q0_den, p)^(-1));
    qp = Mod(q0_num * qinv, p);
    cnt = 0;
    for(c = 0, p-1,
        e2 = Mod(c, p)^2 + qp^2;
        f2 = Mod(c, p)^2 + 1;
        g2 = Mod(c, p)^2 + 1 + qp^2;
        \\ Each square condition: 2 solutions if nonzero square, 1 if zero, 0 if non-square
        n_e = if(e2 == 0, 1, if(issquare(e2), 2, 0));
        n_f = if(f2 == 0, 1, if(issquare(f2), 2, 0));
        n_g = if(g2 == 0, 1, if(issquare(g2), 2, 0));
        cnt += n_e * n_f * n_g;
    );
    return(cnt);
};

\\ At c = 0: e^2 = q^2 (2 sols), f^2 = 1 (2 sols), g^2 = 1+q^2 = (29/21)^2 (2 sols)
\\ Always gives 8 affine points (the degenerate locus) for any p coprime to 21*29

print("V_{20/21}(F_p) affine counts:");
print("p\t#V(F_p)\tdiff from 8");
forprime(p = 11, 100, if(p != 29 && p != 41 && p != 113, c = count_Vq_Fp(p); print(p, "\t", c, "\t", c - 8)));
quit;
