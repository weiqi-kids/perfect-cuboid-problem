/* ==========================================================================
   Systematically test which products of Hilbert symbols are constant on V(Q_2)

   Enumerate all 2-adic V-points (mod 2^K), and for each compute the FULL
   bilinear form Hilbert(P,Q)_2 for all pairs (P,Q) of variables.

   Then look for linear combinations (in Z/2) that are constant.
   ========================================================================== */

inv2(x,y) = if(hilbert(x,y,2)==1, 0, 1);  \\ use 0/1 in F_2

\\ Enumerate 2-adic points (mod 2^K) systematically.
K = 7;  M = 2^K;

sqrt_mod(n, M) = {
  my(r=-1, t);
  for(t=0, M-1, if((t*t - n)%M == 0, r = t; break));
  r;
}

\\ Variables: x1=a, x2=b, x3=c, x4=d, x5=e, x6=f, x7=g
\\ For each V-point, compute a 7x7 symmetric matrix of inv2 values.
\\ Look at the 21 distinct symbols (i<=j).

\\ Build the data matrix: each row is a vector of 21 binary values
data = List();
points = List();
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
            \\ Compute 21 symbols inv2(X[i], X[j]) for i <= j with i,j in 1..7, ignoring diagonal
            \\ Actually use only i < j for non-diagonal symbols
            \\ Plus 7 diagonal symbols inv2(-1, X[i]) — these correspond to "(-1, x)" classes
            my(row = vector(21+7), idx = 0);
            for(i=1,7, for(j=i+1,7, idx = idx+1; row[idx] = inv2(X[i], X[j])));
            for(i=1,7, idx = idx+1; row[idx] = inv2(-1, X[i]));
            listput(data, row);
            listput(points, X);
          )
        )
      ))
    )
  ))
))
}
print("Number of 2-adic V-points (mod ",M,"): ", #data);

\\ Convert to F_2 matrix
n = #data;
m = #data[1];
print("Building ",n,"x",m," matrix...");
\\ Sample size cap
sample_n = min(n, 2000);
sample = vector(sample_n, i, data[i]);
sample_pts = vector(sample_n, i, points[i]);

\\ Find F_2-linear combinations c[1..m] such that sum c[j] * row[j] = constant for all rows
\\ Equivalently: append a column of 1's (constant) and find kernel.
\\ Treat each row as a vector in F_2^(m+1), where last entry is 1.
\\ Find c in F_2^(m+1) such that for all i, c . row_i = 0.
\\ This is the F_2-kernel of the augmented matrix.

M_mat = matrix(sample_n, m+1, i, j, if(j<=m, sample[i][j], 1));
\\ Convert to Mod 2
M_mod = Mat(Mod(M_mat, 2));
\\ Find kernel
K_basis = matker(M_mod);
print("Kernel of augmented matrix (F_2):");
print("dim = ", matsize(K_basis)[2]);
print();
print("Kernel basis vectors:");
for(k=1, matsize(K_basis)[2],
  my(v = K_basis[,k]);
  \\ Print the indices where v is 1
  my(supp = List(), ones);
  for(j=1, m+1, if(v[j]==Mod(1,2),
    listput(supp, j)
  ));
  print("  basis ",k,": ", Vec(supp));
);

print();
print("Label decoding:");
my(idx=0, lbl);
{
for(i=1,7, for(j=i+1,7, idx = idx+1;
  lbl = Vec(["a","b","c","d","e","f","g"]);
  print("  idx ",idx,": (",lbl[i],",",lbl[j],")")));
for(i=1,7, idx = idx+1;
  print("  idx ",idx,": (-1,",Vec(["a","b","c","d","e","f","g"])[i],")"));
print("  idx ",idx+1,": constant 1")
}
