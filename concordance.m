function [ matrice_concordance ] = concordance()

% concordance : création de la matrice de concordance 
% C(a, b) = Somme(k £ P+UP=) pk / somme des poids

poids = [1,1, 1, 1]; % les poids des critères g1, g2, g3 et g4 (ici chaque critere a pour poids 1)
somme_poids = sum(poids); % la somme des poids

% la matrice des jugements
matrice_jugements = [ 6 5 5 5;
        5 4 9 3;
        3 4 7 3;
        3 7 5 4;
        5 4 3 9;
        2 5 7 3;
        5 4 2 9;
        3 5 7 4;];
		
[nbLignes, nbColonnes] = size(matrice_jugements);

% Matrice de concordance
matrice_concordance = zeros(nbLignes, nbLignes);

% Calcul de matrice_concordance
for i=1:nbLignes,
    for j=1:nbLignes,
        if (i~=j) 
            for k=1:nbColonnes,
                if (matrice_jugements(i,k)>=matrice_jugements(j,k))
                    matrice_concordance(i,j) = matrice_concordance(i,j) + poids(k);
                end;
            end;
            matrice_concordance(i,j) = matrice_concordance(i,j)/somme_poids;
        end;
    end;    
end;
end