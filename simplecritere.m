lb = zeros(6, 1);

% Critères du comptable
A1 = [8 15 0 5 0 10
 	7 1 2 15 7 12
 	8 1 11 0 10 25
 	2 10 5 4 13 7
 	5 0 0 7 10 25
 	5 5 3 12 8 0
 	5 3 5 8 0 7
 	1 2 1 5 0 2
 	2 2 1 2 2 1
 	1 0 3 2 2 0];

b1 = [4800; 4800; 4800; 4800; 4800; 4800; 4800; 350; 620; 485];

f1 = [-340/60 -713/60 -856/60 -62/60 -1899/60 -1653/60];
x1 = linprog(f1, A1, b1, [], [], lb);

% Critères du responsable d’atelier
A2 = A1;
b2 = b1;

f2 = [1; 1; 1; 1; 1; 1];
x2 = linprog(-f2, A2, b2, [], [], lb);

%Critère du responsable des stocks
%On met en contrainte d’avoir 80% du bénef max (sinon pour minimiser le stock on produirait 0 produits).
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

b3 = [4800; 4800; 4800; 4800; 4800; 4800; 4800; 350; 620; 485; -10512*.6];

f3 = [5 5 6 10 5 4];
x3 = linprog(f3, A3, b3, [], [], lb);

% Critère du responsable commercial
% On veut un bénefice maximum, en essayant d’équilibrer les quantités des familles (car il existe une infinité de solutions si on cherche uniquement à équilibrer les quantités). On veut que l’écart de quantité des familles soit borné entre EPSYLON ET -EPSYLON.
% Grace à la formule du responsable d’atelier, nous avons calculé le maximum de produits atteignable par une famille.
% ABC = 345.83 DEF = 341.16
% Ecart maximum = Max des deux familles = 345.83
% On limite epsylon à 0% de l’écart maximum des familles
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
EPSYLON = 0;
b4 = [4800; 4800; 4800; 4800; 4800; 4800; 4800; 350; 620; 485; EPSYLON; EPSYLON];
f4 = [-340/60 -713/60 -856/60 -62/60 -1899/60 -1653/60];
x4 = linprog(f4, A4, b4, [], [], lb);

% Crière du responsable du personnel
% On utilise encore la contrainte de 60% du bénéfice car sinon on ne produit rien
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

b5 = [4800; 4800; 4800; 4800; 4800; 4800; 4800; 350; 620; 485; -10512*0.8];

f5 = [13 1 11 7 20 50];
x5 = linprog(f5, A5, b5, [], [], lb);


% Matrice de gains 1
G1 = matricegain(x1, x2, x3, x4, x5, f1, f2, f3, f4, f5);
% On dégrade le bénéfice max à 9000€

% Du coup on refait les calculs avec une contrainte benef <= 9000

Ai1 = [8 15 0 5 0 10
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

bi1 = [4800; 4800; 4800; 4800; 4800; 4800; 4800; 350; 620; 485; -9000];

fi1 = [-340/60 -713/60 -856/60 -62/60 -1899/60 -1653/60];
xi1 = linprog(fi1, Ai1, bi1, [], [], lb);

% F1 mais inutile car on retrouve la mm valeur max
Li1 = zeros(1,5);
Li1(1, 1) = sum(xi1' .* fi1);
Li1(1, 2) = sum(xi1' .* f2');
Li1(1, 3) = sum(xi1' .* f3);
Li1(1, 4) = xi1(1) + xi1(2) + xi1(3) - xi1(4) - xi1(5) - xi1(6);
Li1(1, 5) = sum(xi1' .* f5);

% F2 avec la dégradation du bénéf max
Ai2 =[8 15 0 5 0 10
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
bi2 = [4800; 4800; 4800; 4800; 4800; 4800; 4800; 350; 620; 485; -9000];

fi2 = [1 1 1 1 1 1];
xi2 = linprog(-fi2, Ai2, bi2, [], [], lb);

ValeurFi2 = sum(xi2' .* fi2);

% F3 avec degradation
Ai3 = [8 15 0 5 0 10
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

bi3 = [4800; 4800; 4800; 4800; 4800; 4800; 4800; 350; 620; 485; -9000];

fi3 = [5 5 6 10 5 4];
xi3 = linprog(fi3, Ai3, bi3, [], [], lb);

ValeurFi3 = sum(xi3' .* fi3);

% F4 avec degradation
Ai4 = [8 15 0 5 0 10
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
EPSYLON = 0;
bi4 = [4800; 4800; 4800; 4800; 4800; 4800; 4800; 350; 620; 485; -9000];
fi4 = [-340/60 -713/60 -856/60 -62/60 -1899/60 -1653/60];
xi4 = linprog(fi4, Ai4, bi4, [], [], lb);

ValeurFi4 = xi4(1) + xi4(2) + xi4(3) - xi4(4) - xi4(5) - xi4(6);

% F4 avec degradation
Ai5 = [8 15 0 5 0 10
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

bi5 = [4800; 4800; 4800; 4800; 4800; 4800; 4800; 350; 620; 485; -9000];

fi5 = [13 1 11 7 20 50];
xi5 = linprog(fi5, Ai5, bi5, [], [], lb);

ValeurFi5 = sum(xi5' .* fi5);
% CAlcul de 

% Ai2 = Ai1;
% bi2 = bi1;
% 
% fi2 = [1; 1; 1; 1; 1; 1];
% xi2 = linprog(-fi2, Ai2, bi2, [], [], lb);
% 
% Ai3 = [8 15 0 5 0 10
%  	7 1 2 15 7 12
%  	8 1 11 0 10 25
%  	2 10 5 4 13 7
%  	5 0 0 7 10 25
%  	5 5 3 12 8 0
%  	5 3 5 8 0 7
%  	1 2 1 5 0 2
%  	2 2 1 2 2 1
%  	1 0 3 2 2 0
%  	-340/60 -713/60 -856/60 -62/60 -1899/60 -1653/60];
% 
% bi3 = [4800; 4800; 4800; 4800; 4800; 4800; 4800; 350; 620; 485; -9000];
% 
% fi3 = [5 5 6 10 5 4];
% xi3 = linprog(fi3, Ai3, bi3, [], [], lb);
% 
% Ai4 = [8 15 0 5 0 10
%  	7 1 2 15 7 12
%  	8 1 11 0 10 25
%  	2 10 5 4 13 7
%  	5 0 0 7 10 25
%  	5 5 3 12 8 0
%  	5 3 5 8 0 7
%  	1 2 1 5 0 2
%  	2 2 1 2 2 1
%  	1 0 3 2 2 0
%      1 1 1 -1 -1 -1
%     -1 -1 -1 1 1 1
%  	-340/60 -713/60 -856/60 -62/60 -1899/60 -1653/60];
% EPSYLON = 0;
% bi4 = [4800; 4800; 4800; 4800; 4800; 4800; 4800; 350; 620; 485; EPSYLON; EPSYLON; -9000];
% fi4 = [-340/60 -713/60 -856/60 -62/60 -1899/60 -1653/60];
% xi4 = linprog(fi4, Ai4, bi4, [], [], lb);
% 
% Ai5 = [8 15 0 5 0 10
%  	7 1 2 15 7 12
%  	8 1 11 0 10 25
%  	2 10 5 4 13 7
%  	5 0 0 7 10 25
%  	5 5 3 12 8 0
%  	5 3 5 8 0 7
%  	1 2 1 5 0 2
%  	2 2 1 2 2 1
%  	1 0 3 2 2 0
%  	-340/60 -713/60 -856/60 -62/60 -1899/60 -1653/60];
% 
% bi5 = [4800; 4800; 4800; 4800; 4800; 4800; 4800; 350; 620; 485; -9000];
% 
% fi5 = [13 1 11 7 20 50];
% xi5 = linprog(fi5, Ai5, bi5, [], [], lb);
% 
% 
% % Matrice de gains 2
% G2 = matricegain(xi1, xi2, xi3, xi4, xi5, fi1, fi2, fi3, fi4, fi5);