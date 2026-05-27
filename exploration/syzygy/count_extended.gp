\\ Extended point counts and structural analysis

countV_affine(p) = {
  my(total, chi, N1, N2, N3, N4);
  chi = vector(p);
  chi[1] = 1;
  for(y=1, p-1,
    chi[(y*y)%p + 1] = chi[(y*y)%p + 1] + 1;
  );
  total = 0;
  for(a=0, p-1,
    for(b=0, p-1,
      for(c=0, p-1,
        N1 = (a*a + b*b) % p;
        N2 = (b*b + c*c) % p;
        N3 = (a*a + c*c) % p;
        N4 = (a*a + b*b + c*c) % p;
        total = total + chi[N1+1] * chi[N2+1] * chi[N3+1] * chi[N4+1];
      );
    );
  );
  return(total);
}

print("Extended count over more primes");
print("p  |V_proj|  |V_proj|/(p^2)  Weil-style trace estimate");
{
forprime(p = 2, 53,
  if(p > 2,
    my(aff, proj);
    aff = countV_affine(p);
    proj = (aff - 1)/(p - 1);
    \\ For surface S of degree d in P^6, expect |S(F_p)| = p^2 + a_p*p + 1
    \\ + O(p) corrections from cohomology, with |a_p| ≤ b_2 * sqrt(p) by Weil.
    \\ Solve a_p ≈ (proj - p^2 - 1)/p
    my(ap_est = (proj - p*p - 1)*1.0/p);
    print("p=", p, "  proj=", proj, "  (#-p^2-1)/p=", ap_est);
  );
);
}

\\ Check if V has linear subvarieties (degenerate components):
\\ Setting some variables 0: e.g., a=0 forces b^2=d^2, c^2=e^2, c^2=f^2, b^2+c^2=g^2
\\ This gives many "trivial" points on coordinate hyperplanes.
\\ Compute # points on a=0 slice
countV_a0_affine(p) = {
  my(total, chi, N2, N3, N4);
  chi = vector(p);
  chi[1] = 1;
  for(y=1, p-1,
    chi[(y*y)%p + 1] = chi[(y*y)%p + 1] + 1;
  );
  total = 0;
  \\ a=0: Q1: b^2 = d^2; Q2: b^2+c^2=e^2; Q3: c^2=f^2; Q4: b^2+c^2=g^2
  for(b=0, p-1,
    for(c=0, p-1,
      \\ d s.t. d^2 = b^2: chi[b^2+1] options
      \\ e s.t. e^2 = b^2+c^2
      \\ f s.t. f^2 = c^2
      \\ g s.t. g^2 = b^2+c^2
      N2 = (b*b + c*c) % p;
      total = total + chi[(b*b)%p + 1] * chi[N2+1] * chi[(c*c)%p + 1] * chi[N2+1];
    );
  );
  return(total);
}

print("\nDegenerate locus: V ∩ {a=0}");
{
forprime(p = 3, 23,
  my(aff = countV_a0_affine(p));
  my(proj = if(p>1, (aff-1)/(p-1), 0));
  print("p=", p, "  |V∩{a=0}|_aff=", aff, "  proj=", proj);
);
}

\\ Compute # points where abc != 0 (the "nontrivial" locus relevant to PCP)
countV_nontrivial(p) = {
  my(total, chi, N1, N2, N3, N4);
  chi = vector(p);
  chi[1] = 1;
  for(y=1, p-1,
    chi[(y*y)%p + 1] = chi[(y*y)%p + 1] + 1;
  );
  total = 0;
  for(a=1, p-1,
    for(b=1, p-1,
      for(c=1, p-1,
        N1 = (a*a + b*b) % p;
        N2 = (b*b + c*c) % p;
        N3 = (a*a + c*c) % p;
        N4 = (a*a + b*b + c*c) % p;
        \\ Require nontrivial: d,e,f,g all nonzero
        \\ chi[N+1] - [N==0] gives # nonzero solutions
        my(c1 = chi[N1+1] - if(N1==0, 1, 0));
        my(c2 = chi[N2+1] - if(N2==0, 1, 0));
        my(c3 = chi[N3+1] - if(N3==0, 1, 0));
        my(c4 = chi[N4+1] - if(N4==0, 1, 0));
        total = total + c1 * c2 * c3 * c4;
      );
    );
  );
  return(total);
}

print("\nNontrivial locus: abc*def*g != 0");
{
forprime(p = 3, 23,
  my(nt = countV_nontrivial(p));
  print("p=", p, "  |V_nontriv|_aff=", nt);
);
}

quit;
