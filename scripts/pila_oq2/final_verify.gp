\\ independent re-verification of key F3 non-squares + the offhand arithmetic claim
print("issquare(3560089) = ", issquare(3560089), "  1887^2 = ", 1887^2, "  3560089-1887^2 = ", 3560089-1887^2);
print("issquare(3560089/1334025) = ", issquare(3560089/1334025));
print("issquare(706225/53361) = ", issquare(706225/53361));
print("issquare(73225/1936) = ", issquare(73225/1936));
print("issquare(3885154101909721/86325747057225) = ", issquare(3885154101909721/86325747057225));
\\ note: 73225/1936 -- check numerator: 73225 = 5^2 * 29 * 101 ? 
print("73225 factor: ", factor(73225));  \\ if square-times-nonsquare
print("issquare(73225) = ", issquare(73225), " issquare(1936)=", issquare(1936));
quit;
