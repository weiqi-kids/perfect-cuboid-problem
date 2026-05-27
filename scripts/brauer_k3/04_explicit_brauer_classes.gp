\\ Script 04 v2: Explicit Brauer classes evaluation.
\\
\\ alpha_1 = (-1, b*(d+a))_{Q(V')}    [face a^2 + b^2 = d^2]
\\ alpha_2 = (-1, c*(e+b))_{Q(V')}    [face b^2 + c^2 = e^2]
\\ alpha_3 = (-1, c*(f+a))_{Q(V')}    [face a^2 + c^2 = f^2]

default(parisize, 1000000000);

print("======================================================");
print("Script 04: Explicit Brauer classes on Euler bricks");
print("======================================================");
print("");
print("alpha_1 = (-1, b*(d+a))    [face a^2+b^2=d^2]");
print("alpha_2 = (-1, c*(e+b))    [face b^2+c^2=e^2]");
print("alpha_3 = (-1, c*(f+a))    [face a^2+c^2=f^2]");
print("");

bricks = [[44, 117, 240], [85, 132, 720], [140, 480, 693], [160, 231, 792], [187, 1020, 1584], [240, 252, 275], [1008, 1100, 1155]];
nbrick = length(bricks);
pp_list = [2, 3, 5, 7, 11, 13, 17, 19, 23];
npp = length(pp_list);

print("Number of bricks: ", nbrick);
print("Primes to test: ", pp_list);
print("");

\\ Storage arrays for invariants:
\\ inv_table[k, i, j] = inv_{pp_list[j]}(alpha_i(brick_k))
all_results = matrix(nbrick, 3 * npp);

{
for(k = 1, nbrick,
  brick = bricks[k];
  a = brick[1]; b = brick[2]; c = brick[3];
  d2 = a^2 + b^2;
  e2 = b^2 + c^2;
  f2 = a^2 + c^2;
  d = sqrtint(d2); e = sqrtint(e2); f = sqrtint(f2);
  if(d^2 != d2 || e^2 != e2 || f^2 != f2,
    print("ERROR: not an Euler brick: ", brick);
  );
  print("==== Brick ", k, " (a,b,c) = (", a, ",", b, ",", c, ") ====");
  print("  d=", d, ", e=", e, ", f=", f);
  s1 = b * (d + a);
  s2 = c * (e + b);
  s3 = c * (f + a);
  print("  s1 = b(d+a) = ", s1, "    (factored: ", factor(abs(s1)), ", sign=", sign(s1), ")");
  print("  s2 = c(e+b) = ", s2, "    (factored: ", factor(abs(s2)), ", sign=", sign(s2), ")");
  print("  s3 = c(f+a) = ", s3, "    (factored: ", factor(abs(s3)), ", sign=", sign(s3), ")");
  inv_row = vector(3 * npp);
  for(j = 1, npp,
    p = pp_list[j];
    inv1 = (1 - hilbert(-1, s1, p)) / 2;
    inv2 = (1 - hilbert(-1, s2, p)) / 2;
    inv3 = (1 - hilbert(-1, s3, p)) / 2;
    inv_row[j] = inv1;
    inv_row[npp + j] = inv2;
    inv_row[2*npp + j] = inv3;
    all_results[k, j] = inv1;
    all_results[k, npp + j] = inv2;
    all_results[k, 2*npp + j] = inv3;
  );
  print("  alpha_1 invs at ", pp_list, ": ", vector(npp, j, inv_row[j]));
  print("  alpha_2 invs at ", pp_list, ": ", vector(npp, j, inv_row[npp + j]));
  print("  alpha_3 invs at ", pp_list, ": ", vector(npp, j, inv_row[2*npp + j]));
  print("");
);
}

print("======================================================");
print("Tabular: each row is a brick, columns alpha_i at each prime.");
print("Column groups: alpha_1 @ [2,3,5,7,11,13,17,19,23], alpha_2 @ ..., alpha_3 @ ...");
print("======================================================");
print(all_results);

\\ Check: for each prime p and each alpha_i, is the value CONSTANT across bricks?
print("");
print("Constancy of inv_p(alpha_i) across the 7 bricks:");
{
for(i = 1, 3,
  for(j = 1, npp,
    p = pp_list[j];
    col = vector(nbrick, k, all_results[k, (i-1)*npp + j]);
    is_const = (vecmin(col) == vecmax(col));
    print("  alpha_", i, " at p=", p, ": values = ", col, "  ", if(is_const, "[CONSTANT]", "[VARIES]"));
  );
);
}

print("");
print("======================================================");
print("Reciprocity check: sum_p inv_p(alpha_i(brick_k)) over ALL places.");
print("Brick is a rational point on V'(Q), so reciprocity says sum = 0 mod 1.");
print("======================================================");

{
for(k = 1, nbrick,
  brick = bricks[k];
  a = brick[1]; b = brick[2]; c = brick[3];
  d = sqrtint(a^2 + b^2);
  e = sqrtint(b^2 + c^2);
  f = sqrtint(a^2 + c^2);
  s1 = b * (d + a);
  s2 = c * (e + b);
  s3 = c * (f + a);
  \\ Full prime set: all primes dividing s_i.
  full_pp = Set();
  for(idx = 1, 3,
    s_idx = if(idx == 1, s1, if(idx == 2, s2, s3));
    f_s = factor(abs(s_idx));
    for(r = 1, matsize(f_s)[1], full_pp = setunion(full_pp, Set([f_s[r, 1]])));
  );
  full_pp = setunion(full_pp, Set([2]));
  full_pp = Vec(full_pp);
  arch_i1 = if(s1 < 0, 1, 0);
  arch_i2 = if(s2 < 0, 1, 0);
  arch_i3 = if(s3 < 0, 1, 0);
  sum_i1 = arch_i1;
  sum_i2 = arch_i2;
  sum_i3 = arch_i3;
  for(j = 1, length(full_pp),
    p = full_pp[j];
    sum_i1 = sum_i1 + (1 - hilbert(-1, s1, p)) / 2;
    sum_i2 = sum_i2 + (1 - hilbert(-1, s2, p)) / 2;
    sum_i3 = sum_i3 + (1 - hilbert(-1, s3, p)) / 2;
  );
  print("Brick ", k, " ", brick, " reciprocity (alpha_1, alpha_2, alpha_3) mod 2: (",
    lift(Mod(sum_i1, 2)), ", ", lift(Mod(sum_i2, 2)), ", ", lift(Mod(sum_i3, 2)),
    ")  [should be (0,0,0)]");
);
}

print("");
print("======================================================");
print("Done.");
print("======================================================");
quit;
