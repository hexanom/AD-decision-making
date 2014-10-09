function [ matrice_discordance ] = discordance( )

 % D(a, b) = Max(ebk, eak) k£P- / echmax
 
ecart = 0; % Max(ejk - eik)
echmax = 10; % toutes les notes sont sur 10

% la matrice des jugements
matrice_jugements =[ 6 5 5 5;
        5 4 9 3;
        3 4 7 3;
        3 7 5 4;
        5 4 3 9;
        2 5 7 3;
        5 4 2 9;
        3 5 7 4;];
[nbLignes, nbColonnes] = size(matrice_jugements);

matrice_discordance = zeros(nbLignes, nbLignes);

 % matrice de matrice_discordance

% on compare toutes les notes de chaque critère
for i = 1:nbLignes, 
	for j = 1:nbLignes, 
		if i~=j
			% On prend l'écart max sur l'ensemble des critères
			for k = 1:nbColonnes,
				if (ecart < (matrice_jugements(j,k) - matrice_jugements(i, k))) 
					ecart = matrice_jugements(j,k) - matrice_jugements(i, k);
				end;
			end;
			matrice_discordance(i,j) = ecart / echmax;
			ecart = 0;
		end;
	end;
end;