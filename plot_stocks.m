lb = zeros(6, 1);

A3 = [8 15 0 5 0 10
     7 1 2 15 7 12
     8 1 11 0 10 25
     2 10 5 4 13 7
     5 0 0 7 10 25
     5 5 3 12 8 0
     5 3 5 8 0 7
     1 2 1 5 0 2
     2 2 1 2 2 1
     1 0 3 2 2 0
     -340/60 -713/60 -856/60 -62/60 -1899/60 -1653/60];
 
 stocks = zeros(1, 100/5);
 percents = zeros(1, 100/5);
 
 
for i=0:100/5
   percent = i * 5;
   b3 = [4800; 4800; 4800; 4800; 4800; 4800; 4800; 350; 620; 485; -10512*percent/100];

   f3 = [5 5 6 10 5 4];
   x3 = linprog(f3, A3, b3, [], [], lb);
   
   stock = 5*x3(1) + 5*x3(2) + 6*x3(3) + 10*x3(4) + 5*x3(5) + 4*x3(6);
   percents(i+1) = percent;
   stocks(i+1) = stock;
end

plot(percents, stocks);
title('Evolution du stock en fonction de l''objectif de marge à atteindre');
xlabel('Pourcentage de la marge maximale à atteindre (contrainte)');
ylabel('Quantités en stock');