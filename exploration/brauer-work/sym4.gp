/* ==========================================================================
   Enlarged Brauer class candidate space: add d±a, d±b, e±b, e±c, f±a, f±c,
   g±a, g±b, g±c, a±b, b±c, a±c, and the prime 2.
   ========================================================================== */

default(parisize, "1G");

inv2(x,y) = if(hilbert(x,y,2)==1, 0, 1);

K = 6;  M = 2^K;

sqrt_all_mod(n, M) = {
  my(L = List(), t);
  for(t=0, M-1, if((t*t - n)%M == 0, listput(L, t)));
  Vec(L);
}

sqcl_of(x) = {
  if(x % M == 0, return([99, 99]));
  my(v, u, xint = x % M);
  if(xint < 0, xint += M);
  v = valuation(xint, 2);
  u = (xint / 2^v) % 8;
  if(u <= 0, u += 8);
  [v % 2, u];
}

\\ Construct a representative integer with the given square class, but more carefully
\\ Choose an actual mod-M element, not just square class.
\\ Hilbert symbols only depend on square class mod 8 (for odd things) and v mod 2.
\\ For p=2 specifically, the symbol depends on class in Q_2^*/(Q_2^*)^2.
\\ A representative integer is: 2^(v mod 2) * (u mod 8). To get a Z_2^* element with
\\ class [u] mod 8 with v_2 = 0: use u itself (since u in {1, 3, 5, 7}).
\\ To get class with v=1 (v_2 odd): use 2*u.
\\ But 2*u with u in {1,3,5,7} gives {2, 6, 10, 14} — these are 4 distinct classes.
\\ Total classes: 8.

\\ Actually for picking a representative integer for the Hilbert symbol calc,
\\ the actual mod-M residue matters because (P, Q)_2 needs P, Q ∈ Q_2^*.
\\ A representative in Z that has the right square class works: just use, say,
\\ 2^(v mod 2) * (u mod 8) directly as an integer.

\\ Let's track this carefully. For each variable x ∈ {a, b, c, d, e, f, g}, we
\\ know its actual residue mod M (since we enumerate). The square class is
\\ determined. For Hilbert symbols (x, y)_2, we can just use the mod-M reps.

\\ Sum/diff variables: e.g. d-a as an integer mod M. This is meaningful.

data = List();
{
for(a=1, M-1, if(a%2==1,
  for(b=4, M-1, if(b%4==0 && b%8!=0,
    my(d2 = (a^2+b^2)%M);
    if(issquare(Mod(d2, M)),
      for(c=16, M-1, if(c%16==0,
        my(e2 = (b^2+c^2)%M, f2 = (a^2+c^2)%M, g2 = (a^2+b^2+c^2)%M);
        if(issquare(Mod(e2, M)) && issquare(Mod(f2, M)) && issquare(Mod(g2, M)),
          \\ Iterate over choices of sqrt for d, e, f, g
          my(dsqrts = sqrt_all_mod(d2, M),
             esqrts = sqrt_all_mod(e2, M),
             fsqrts = sqrt_all_mod(f2, M),
             gsqrts = sqrt_all_mod(g2, M));
          for(id=1, #dsqrts, for(ie=1, #esqrts, for(if_=1, #fsqrts, for(ig=1, #gsqrts,
            my(d = dsqrts[id], e = esqrts[ie], f = fsqrts[if_], g = gsqrts[ig]);
            if(d > 0 && e > 0 && f > 0 && g > 0,
              \\ Compute candidate variables: basic 7 + 12 combinations + (-1) and 2
              \\ Var list: a,b,c,d,e,f,g, d-a,d+a,d-b,d+b, e-b,e+b,e-c,e+c, f-a,f+a,f-c,f+c,
              \\           g-a,g+a,g-b,g+b,g-c,g+c, a-b,a+b,b-c,b+c,a-c,a+c, -1, 2
              my(vars = [a,b,c,d,e,f,g, d-a,d+a,d-b,d+b, e-b,e+b,e-c,e+c, f-a,f+a,f-c,f+c,
                         g-a,g+a,g-b,g+b,g-c,g+c, a-b,a+b,b-c,b+c,a-c,a+c, -1, 2]);
              \\ Take mod M, ensure non-zero
              my(N = #vars, ok = 1);
              for(i=1, N, vars[i] = vars[i] % M; if(vars[i]==0, ok = 0; break));
              if(ok,
                \\ Make Hilbert symbols for all pairs (i<j) and constant 1.
                my(symbols = List(), Nsym);
                for(i=1, N, for(j=i+1, N,
                  listput(symbols, inv2(vars[i], vars[j]))
                ));
                Nsym = #symbols;
                listput(symbols, 1);
                \\ Add to data
                listput(data, Vec(symbols))
              )
            )
          ))))
        )
      ))
    )
  ))
))
}
print("Total data rows: ", #data);
\\ Number of symbols
NV = 33;
NS = NV*(NV-1)/2 + 1;
print("Number of features (symbols + constant): ", NS);

\\ Deduplicate
data_set = Set(data);
print("Unique rows: ", #data_set);

\\ For each pair (i,j) construct label
labels = vector(NS);
{
my(varNames = ["a","b","c","d","e","f","g",
               "d-a","d+a","d-b","d+b","e-b","e+b","e-c","e+c",
               "f-a","f+a","f-c","f+c","g-a","g+a","g-b","g+b","g-c","g+c",
               "a-b","a+b","b-c","b+c","a-c","a+c","-1","2"], idx=0);
for(i=1, NV, for(j=i+1, NV,
  idx = idx+1;
  labels[idx] = Strprintf("(%s,%s)", varNames[i], varNames[j])
));
labels[NS] = "ONE";
}

\\ Build kernel
print("Building ",#data_set,"x",NS," matrix...");
M_mod = matrix(#data_set, NS, i, j, Mod(data_set[i][j], 2));
K_basis = matker(M_mod);
print("Kernel dim: ", matsize(K_basis)[2]);
print();

{
for(k=1, matsize(K_basis)[2],
  my(s = "");
  for(j=1, NS,
    if(K_basis[j,k] == Mod(1,2),
      s = Str(s, " ", labels[j])
    )
  );
  if(#s < 200,
    print("Basis ",k,":", s)
  ,
    print("Basis ",k,": (long, support size ", sum(j=1,NS,if(K_basis[j,k]==Mod(1,2),1,0)), ")")
  )
);
}
