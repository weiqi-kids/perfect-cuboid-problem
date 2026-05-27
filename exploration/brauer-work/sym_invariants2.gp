/* ==========================================================================
   Find F_2 linear combinations of Hilbert symbols constant on V(Q_2).
   ========================================================================== */

\\ allocatemem(0); \\ default
default(parisize, "200M");

inv2(x,y) = if(hilbert(x,y,2)==1, 0, 1);

K = 6;  M = 2^K;

sqrt_mod(n, M) = {
  my(r=-1, t);
  for(t=0, M-1, if((t*t - n)%M == 0, r = t; break));
  r;
}

\\ Build all V-points (mod M) with constraints, store reduced data
data = List();
{
for(a=1, M-1, if(a%2==1,
  for(b=4, M-1, if(b%4==0 && b%8!=0,
    if(issquare(Mod(a^2+b^2, M)),
      my(d = sqrt_mod((a^2+b^2)%M, M));
      for(c=16, M-1, if(c%16==0,
        if(issquare(Mod(b^2+c^2, M)) && issquare(Mod(a^2+c^2, M)) && issquare(Mod(a^2+b^2+c^2, M)),
          my(e = sqrt_mod((b^2+c^2)%M, M),
             f = sqrt_mod((a^2+c^2)%M, M),
             g = sqrt_mod((a^2+b^2+c^2)%M, M));
          if(d!=0 && e!=0 && f!=0 && g!=0,
            my(X = [a, b, c, d, e, f, g]);
            \\ Compute 21 + 7 = 28 symbols + a constant 1
            my(row = vector(29), idx = 0);
            for(i=1,7, for(j=i+1,7, idx = idx+1; row[idx] = inv2(X[i], X[j])));
            for(i=1,7, idx = idx+1; row[idx] = inv2(-1, X[i]));
            row[29] = 1;
            listput(data, row)
          )
        )
      ))
    )
  ))
))
}
print("Number of V-points (mod ",M,"): ", #data);

\\ Build matrix in F_2 manually as a small matrix
n = #data;
\\ Sample reasonable number
sample_n = min(n, 1000);
\\ Convert each row to a sequence of bits
rows = vector(sample_n, i, vector(29, j, data[i][j] % 2));

\\ Now do Gaussian elimination in F_2 to find ker(M^T)?
\\ Equivalently, find col vector c such that for all rows r, r . c = 0 in F_2.
\\ Build the dual: matrix with rows = unknowns, n columns; row operations.
\\ Easier: build matrix where each row is one V-point's data; find right nullspace.

\\ Use PARI's matker on a Mod 2 matrix, built more carefully:
M_mod = matrix(sample_n, 29);
{
for(i=1, sample_n,
  for(j=1, 29,
    M_mod[i,j] = Mod(rows[i][j], 2)
  )
);
}

K_basis = matker(M_mod * Mod(1,2));
print("Kernel dim of M (data x 29) over F_2: ", matsize(K_basis)[2]);
print();

\\ Print the kernel vectors with labels
labels = vector(29);
{
my(varNames = ["a","b","c","d","e","f","g"], idx = 0);
for(i=1, 7, for(j=i+1,7,
  idx = idx+1;
  labels[idx] = Strprintf("(%s,%s)", varNames[i], varNames[j])
));
for(i=1, 7,
  idx = idx+1;
  labels[idx] = Strprintf("(-1,%s)", varNames[i])
);
labels[29] = "ONE";
}

{
for(k=1, matsize(K_basis)[2],
  my(s = "");
  for(j=1, 29,
    if(K_basis[j,k] == Mod(1,2),
      s = Str(s, " ", labels[j])
    )
  );
  print("Basis ",k,":", s)
);
}
