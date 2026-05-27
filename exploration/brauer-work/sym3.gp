/* ==========================================================================
   Correct enumeration: include all sqrt choices (both signs) for d, e, f, g.
   ========================================================================== */

default(parisize, "500M");

inv2(x,y) = if(hilbert(x,y,2)==1, 0, 1);

K = 6;  M = 2^K;

\\ Find all sqrts of n mod M
sqrt_all_mod(n, M) = {
  my(L = List(), t);
  for(t=0, M-1, if((t*t - n)%M == 0, listput(L, t)));
  Vec(L);
}

\\ For our purposes, we only need representative for each square class.
\\ Two square classes occur typically: u mod 8 vs (8 - u) mod 8 = -u mod 8.
\\ Actually 4 sqrts of n give 2 square classes (s, -s mod sq).

\\ Get unique square classes from sqrt list
sqcl_of(x) = {
  my(v, u);
  if(x==0, return([99, 99]));  \\ sentinel
  v = valuation(x, 2);
  u = (x / 2^v) % 8;
  if(u < 0, u += 8);
  [v % 2, u];
}

sqrt_classes(n, M) = {
  my(allsq = sqrt_all_mod(n, M), classes = List(), s);
  for(i=1, #allsq,
    s = sqcl_of(allsq[i]);
    if(!setsearch(Set(classes), s),
      listput(classes, s)
    )
  );
  Vec(classes);
}

\\ Now for each (a, b, c) valid mod M, ITERATE over all choices of square classes for d,e,f,g.

data = List();
{
for(a=1, M-1, if(a%2==1,
  for(b=4, M-1, if(b%4==0 && b%8!=0,
    my(d2 = (a^2+b^2)%M);
    if(issquare(Mod(d2, M)),
      for(c=16, M-1, if(c%16==0,
        my(e2 = (b^2+c^2)%M, f2 = (a^2+c^2)%M, g2 = (a^2+b^2+c^2)%M);
        if(issquare(Mod(e2, M)) && issquare(Mod(f2, M)) && issquare(Mod(g2, M)),
          my(dcl = sqrt_classes(d2, M),
             ecl = sqrt_classes(e2, M),
             fcl = sqrt_classes(f2, M),
             gcl = sqrt_classes(g2, M));
          for(id=1, #dcl, for(ie=1, #ecl, for(if_=1, #fcl, for(ig=1, #gcl,
            \\ Build a representative 2-adic element for each variable
            \\ from its square class. Easiest: just use the class (v_2 mod 2, u mod 8)
            \\ directly; Hilbert symbol depends only on classes mod 8.
            my(sa = sqcl_of(a), sb = sqcl_of(b), sc = sqcl_of(c));
            my(sd = dcl[id], se = ecl[ie], sf = fcl[if_], sg = gcl[ig]);
            \\ Build representatives in Z: x = 2^sx[1] * sx[2] (with adjusting to be in Z_2)
            my(repr = (s) -> if(s[1]==0, s[2], 2*s[2]));
            my(ra=repr(sa), rb=repr(sb), rc=repr(sc), rd=repr(sd), re=repr(se), rf=repr(sf), rg=repr(sg));
            my(X = [ra,rb,rc,rd,re,rf,rg]);
            my(row = vector(29), idx = 0);
            for(i=1,7, for(j=i+1,7, idx = idx+1; row[idx] = inv2(X[i], X[j])));
            for(i=1,7, idx = idx+1; row[idx] = inv2(-1, X[i]));
            row[29] = 1;
            listput(data, row)
          ))))
        )
      ))
    )
  ))
))
}
print("Number of V-square-class profiles (mod ",M,"): ", #data);

\\ Deduplicate
data_set = Set(data);
print("Unique profiles: ", #data_set);

\\ Build matrix
n = #data_set;
sample = vector(n, i, data_set[i]);

M_mod = matrix(n, 29, i, j, Mod(sample[i][j], 2));

K_basis = matker(M_mod);
print("Kernel dim of M (data x 29) over F_2: ", matsize(K_basis)[2]);
print();

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

\\ Verify by recomputing one example explicitly
print("\nVerification on (a,b,c) = (275, 252, 240), d=373, e=348, f=365");
print("g^2 = 196729, g = sqrt(196729) in Q_2");
\\ g^2 mod 64 = 196729 mod 64
g2_real = 275^2 + 252^2 + 240^2;
print("g^2 = ", g2_real, " mod 64 = ", g2_real % 64);
print("g^2 in Q_2 -- square class: it depends on g^2 mod 8 (odd unit).");
print("g^2 = ",factor(g2_real));
\\ g^2 / 2^v(g^2) -- check if g^2 is a square in Q_2
\\ g^2 = 196729 has v_2 = ?
print("v2(g^2) = ", valuation(g2_real, 2));
\\ Odd, so g is odd unit in Z_2.
print("g^2 mod 8 = ", g2_real % 8);
\\ g^2 mod 8 = 1, so g = ±1 mod 8.
