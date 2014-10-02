lb = zeros(6, 1);

A5 = [8 15 0 5 0 10
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
 
 tempstravaux = zeros(1, 100/5);
 percents = zeros(1, 100/5);
 
 
for i=0:100/5
   percent = i * 5;
   margepercent = percent / 100;

    b5 = [4800; 4800; 4800; 4800; 4800; 4800; 4800; 350; 620; 485; -10512*margepercent];

    f5 = [13 1 11 7 20 50];
    x5 = linprog(f5, A5, b5, [], [], lb);
   
    tempstravail = 13*x5(1) + 1*x5(2) + 11*x5(3) + 7*x5(4) + 20*x5(5) + 50*x5(6);
    percents(i+1) = percent;
    tempstravaux(i+1) = tempstravail;
end

scatter(percents, tempstravaux);
title('Evolution du temps de travail cumulé des machines 3 et 5 en fonction de l''objectif de marge à atteindre');
xlabel('Pourcentage de la marge maximale à atteindre (contrainte)');
ylabel('Temps de travail cumulé (minutes)');