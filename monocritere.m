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

b3 = [4800; 4800; 4800; 4800; 4800; 4800; 4800; 350; 620; 485; -10512*.8];

f3 = [5 5 6 10 5 4];
x3 = linprog(f3, A3, b3, [], [], lb);

% Critère du responsable commercial
% On veut un bénefice maximum, en essayant d’équilibrer les quantités des familles (car il existe une infinité de solutions si on cherche uniquement à équilibrer les quantités). On veut que l’écart de quantité des familles soit borné entre EPSYLON ET -EPSYLON.
% Grace à la formule du responsable d’atelier, nous avons calculé le maximum de produits atteignable par une famille.
% ABC = 345.83 DEF = 341.16
% Ecart maximum = Max des deux familles = 345.83
% On limite epsylon à 10% de l’écart maximum des familles = 35
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
EPSYLON = 35;
b4 = [4800; 4800; 4800; 4800; 4800; 4800; 4800; 350; 620; 485; EPSYLON; EPSYLON];
f4 = [-340/60 -713/60 -856/60 -62/60 -1899/60 -1653/60];
x4 = linprog(f4, A4, b4, [], [], lb);

% Crière du responsable du personnel
% On utilise encore la contrainte de 80% du bénéfice car sinon on ne produit rien
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
