lb = zeros(6, 1);

A4 = [8 15 0 5 0 10
     7 1 2 15 7 12
     8 1 11 0 10 25
     2 10 5 4 13 7
     5 0 0 7 10 25
     5 5 3 12 8 0
     5 3 5 8 0 7
     1 2 1 5 0 2
     2 2 1 2 2 1
     1 0 3 2 2 0
     1 1 1 -1 -1 -1
    -1 -1 -1 1 1 1];
 
 benefs = zeros(1, 100/5);
 percents = zeros(1, 100/5);
 QTEMAX = 345.83;
 
 
for i=0:100/5
   percent = i * 5;
   
   EPSYLON = percent/100 * QTEMAX;
   b4 = [4800; 4800; 4800; 4800; 4800; 4800; 4800; 350; 620; 485; EPSYLON; EPSYLON];
   f4 = [-340/60 -713/60 -856/60 -62/60 -1899/60 -1653/60];
   x4 = linprog(f4, A4, b4, [], [], lb);
   
   benef = 340/60*x4(1) + 713/60*x4(2) + 856/60*x4(3) + 62/60*x4(4) + 1899/60*x4(5) + 1653/60*x4(6);
   percents(i+1) = percent;
   benefs(i+1) = benef;
end

plot(percents, benefs);
title('Evolution de la marge en fonction de l''écart maximum autorisé entre les productions des deux familles');
xlabel('Ecart maximum autorisé (pourcentage de la qtte maximum de la famille ABC)');
ylabel('Marge');