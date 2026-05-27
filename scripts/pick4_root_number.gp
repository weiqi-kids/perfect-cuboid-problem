build(m, n) = {my(a = m^2-n^2, b = 2*m*n, s = m^2+n^2); return(ellinit([0, s^2, 0, (a*b)^2, 0]));};

print("=== Local root numbers ===");
for(m = 2, 12, for(n = 1, m-1, if(gcd(m,n) == 1 && (m+n) % 2 == 1, my(E = build(m,n)); my(Em = ellminimalmodel(E)); my(N = ellglobalred(Em)[1]); my(p_list = factor(N)[,1]); my(w = ellrootno(Em)); my(local_ws = vector(#p_list, i, ellrootno(Em, p_list[i]))); print("(", m, ",", n, ") w=", w, " primes=", p_list~, " local_w=", local_ws))));

print("\n=== a-b mod 8 vs root number ===");
for(m = 2, 16, for(n = 1, m-1, if(gcd(m,n) == 1 && (m+n) % 2 == 1, my(a = m^2-n^2, b = 2*m*n); my(E = build(m,n)); my(Em = ellminimalmodel(E)); my(w = ellrootno(Em)); print("(m,n)=(", m, ",", n, ") a-b=", a-b, " mod 8=", lift(Mod(a-b,8)), " w=", w))));

print("\n=== u mod patterns vs root number ===");
for(m = 2, 16, for(n = 1, m-1, if(gcd(m,n) == 1 && (m+n) % 2 == 1, my(u = m^2-2*m*n-n^2, v = m^2+2*m*n-n^2); my(E = build(m,n)); my(Em = ellminimalmodel(E)); my(w = ellrootno(Em)); print("(m,n)=(", m, ",", n, ") u=", u, " v=", v, " u mod 8=", lift(Mod(u,8)), " v mod 8=", lift(Mod(v,8)), " sign(u*v)=", sign(u*v), " w=", w))));

print("\n=== Tally of root number by sign(u*v) ===");
sgn_pos_wp1 = 0; sgn_pos_wm1 = 0; sgn_neg_wp1 = 0; sgn_neg_wm1 = 0;
for(m = 2, 16, for(n = 1, m-1, if(gcd(m,n) == 1 && (m+n) % 2 == 1, my(u = m^2-2*m*n-n^2, v = m^2+2*m*n-n^2); my(E = build(m,n)); my(Em = ellminimalmodel(E)); my(w = ellrootno(Em)); my(s = sign(u*v)); if(s > 0 && w == 1, sgn_pos_wp1++); if(s > 0 && w == -1, sgn_pos_wm1++); if(s < 0 && w == 1, sgn_neg_wp1++); if(s < 0 && w == -1, sgn_neg_wm1++))));
print("sign(uv)>0, w=+1: ", sgn_pos_wp1, "   w=-1: ", sgn_pos_wm1);
print("sign(uv)<0, w=+1: ", sgn_neg_wp1, "   w=-1: ", sgn_neg_wm1);

quit;
