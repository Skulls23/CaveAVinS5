-- Toute les requetes sont sous commentaires, il s'agit d'une habitude qu'un autre professeur nous a obligé a avoir
-- afin de pouvoir le lancer petit a petit via la console.
-- Comme je ne connait pas vos préférences j'ai donc fait comme ceci.
-- Si vous souhaitez decommentez toute les methodes vous pouvez find & replace /* et */ par rien, cela decommentera chaque méthode

-- Requête 1 : Cette requête nous permet d'obtenir les bouteilles dont le nom commence par 'Château' ou 'Domaine' à l'aide d'une REGEX.
-- Utilisation : C'est donc une requête qui permet la recherche par nom incomplet de bouteille, modifiable pour que la recherche ne soit pas que sur le debut mais tout le nom.

-- SELECT DISTINCT nom_bouteille FROM Bouteille WHERE nom_bouteille ~* '^(Château|Domaine).*' ORDER BY nom_bouteille;




-- Requete 2a - Cette requête nous renvoie les bouteilles de vin Rouge.
-- Utilisation : Une requête qui permet donc la recherche de bouteille selon leur Robe


-- Les resultats entre les jointures internes sont différentes des externes car ces dernières affiche toute la
-- table (ici celle à droite du join) y compris les tuples ne respectant pas la condition du WHERE

-- INTERNE 1
/*SELECT nom_bouteille, millesime_bouteille, volume_bouteille
FROM Bouteille INNER JOIN Categorie
ON Bouteille.id_categorie = Categorie.id_categorie
WHERE robe_bouteille = 'Rouge';*/

-- INTERNE 2
/*SELECT nom_bouteille, millesime_bouteille, volume_bouteille
FROM Bouteille,Categorie
WHERE Bouteille.id_categorie = Categorie.id_categorie AND robe_bouteille = 'Rouge';*/

-- EXTERNE
/* Affiche un résultat différent car la jointure externe ici à droite
affiche tous les tuples de robe_bouteille y compris les tuples ne respectant pas la condition du WHERE
ainsi on a des lignes de bouteilles à NULL pour robe_bouteille qui affiche Rosé ou Blanc*/

/*SELECT nom_bouteille, millesime_bouteille, volume_bouteille, robe_bouteille
FROM bouteille RIGHT JOIN categorie
ON Bouteille.id_categorie = categorie.id_categorie AND robe_bouteille = 'Rouge';*/




-- Requete 2b - Cette requête nous donne les nom des bouteilles goutées par Millicent Vadeboncoeur ainsi que la note attribuée par ce dernier.
-- Utilisation : Permet d'avoir des informations sur un Oenologue dont on connait le nom (bouteille dégustée et note attribuée).

-- INTERNE 1
/*SELECT nom_bouteille, nom_oenologue, note_degustation FROM Bouteille
INNER JOIN Degustation
ON Bouteille.id_bouteille = Degustation.id_bouteille
INNER JOIN Oenologue
ON Degustation.id_oenologue = Oenologue.id_oenologue
WHERE nom_oenologue = 'Millicent Vadeboncoeur';*/

-- INTERNE 2
/*SELECT nom_bouteille, nom_oenologue, note_degustation FROM Bouteille, Degustation,Oenologue
WHERE Bouteille.id_bouteille = Degustation.id_bouteille
AND  Degustation.id_oenologue = Oenologue.id_oenologue
AND nom_oenologue = 'Millicent Vadeboncoeur';*/

-- EXTERNE
-- Les résultats entre les jointures internes sont similaires à la jointure externe
-- car cette dernière en contient plusieurs, cela faisait que le tri est de plus en plus petit,
-- il faut que ce tuple contienne un élément qui est correct à la fois dans bouteille que dans dégustation et enfin dans oenologue

/*SELECT nom_bouteille, nom_oenologue, note_degustation
FROM Bouteille
RIGHT JOIN Degustation
ON Bouteille.id_bouteille = Degustation.id_bouteille
LEFT JOIN Oenologue
ON Degustation.id_oenologue = Oenologue.id_oenologue
WHERE nom_oenologue = 'Millicent Vadeboncoeur';*/




-- Requete 2c - Cette requête nous donne une bouteille avec son appellation.
-- Utilisation : Requête qui permet de lister toute les bouteilles et leur appellation rapidement.

-- INTERNE 1 :
/*SELECT nom_bouteille, millesime_bouteille, volume_bouteille,nom_appellation,categorie_appellation
FROM Bouteille
INNER JOIN Appellation
ON Bouteille.id_appellation = Appellation.id_appellation;*/

-- INTERNE 2 :
/*SELECT nom_bouteille, millesime_bouteille, volume_bouteille,nom_appellation,categorie_appellation
FROM Bouteille,Appellation
WHERE Bouteille.id_appellation = Appellation.id_appellation;*/

-- EXTERNE :
-- On a les mêmes résultats car on a pas de clause WHERE et donc tous les tuples ont une correspondance bouteille, appellation
/*SELECT nom_bouteille, millesime_bouteille, volume_bouteille,nom_appellation,categorie_appellation
FROM Bouteille LEFT JOIN Appellation
ON Bouteille.id_appellation = Appellation.id_appellation;*/





-- Requete 2d - Cette requête nous renvoie les bouteilles et leur prix si on ne les a plus en stock.
-- Utilisation : Cette requête nous donne les bouteilles qu'on a plus en stock ainsi que leur prix si on veut les racheter.


-- INTERNE 1:
/*SELECT Bouteille.nom_bouteille, Bouteille.millesime_bouteille, Bouteille.volume_bouteille, qte_bouteille, prix_bouteille
FROM Bouteille INNER JOIN Quantite
ON Bouteille.nom_bouteille = Quantite.nom_bouteille
AND Bouteille.millesime_bouteille = Quantite.millesime_bouteille
AND Bouteille.volume_bouteille = Quantite.volume_bouteille
WHERE qte_bouteille = 0;*/

-- INTERNE 2 :
/*SELECT Bouteille.nom_bouteille, Bouteille.millesime_bouteille, Bouteille.volume_bouteille, qte_bouteille, prix_bouteille
FROM Bouteille, Quantite
WHERE Bouteille.nom_bouteille = Quantite.nom_bouteille
AND Bouteille.millesime_bouteille = Quantite.millesime_bouteille
AND Bouteille.volume_bouteille = Quantite.volume_bouteille
AND qte_bouteille = 0;*/

-- EXTERNE
-- Même résultat entre interne et externe car toutes les bouteilles ont une correspondance dans quantité.
/*SELECT Bouteille.nom_bouteille, Bouteille.millesime_bouteille, Bouteille.volume_bouteille, qte_bouteille, prix_bouteille
FROM Bouteille LEFT JOIN Quantite
ON Bouteille.nom_bouteille = Quantite.nom_bouteille
AND Bouteille.millesime_bouteille = Quantite.millesime_bouteille
AND Bouteille.volume_bouteille = Quantite.volume_bouteille
WHERE qte_bouteille = 0;*/




-- Requête 3 : elle nous renvoie les vins de catégorie d’appellation ‘Vin de table’ ainsi que les vins dont le stock est supérieur à 5 grâce à UNION.
-- Utilisation : Nous permet de chercher une bouteille d'une appellation recherchée et d'un stock qui nous convient.


/*SELECT id_bouteille, nom_bouteille, robe_bouteille, millesime_bouteille
FROM Bouteille JOIN Appellation
ON Bouteille.id_appellation = Appellation.id_appellation
JOIN Categorie
ON Bouteille.id_categorie = Categorie.id_categorie
WHERE categorie_appellation = 'Vin de table'
UNION
SELECT id_bouteille, nom_bouteille, robe_bouteille, millesime_bouteille
FROM Bouteille NATURAL JOIN Quantite
JOIN Categorie
ON Bouteille.id_categorie = Categorie.id_categorie
WHERE qte_bouteille > 5;*/




-- Requête 4 : Elle permet d'afficher les vins blanc qui ne portent pas l'appellation VDQS, on utilise NOT IN car EXCEPT n'existe pas en MySQL.
-- Utilisation : Si on veut choisir une bouteille d'une robe précise mais qui ne porte pas une certaine appellation.

/*SELECT id_bouteille, nom_bouteille, millesime_bouteille
FROM Bouteille JOIN Categorie
ON Bouteille.id_categorie = Categorie.id_categorie
WHERE robe_bouteille = 'Blanc'
AND id_bouteille NOT IN (
SELECT id_bouteille
FROM Bouteille JOIN Appellation
ON Bouteille.id_appellation = Appellation.id_appellation
WHERE categorie_appellation = 'VDQS');*/




-- Requete 5a : affiche le nom de l’oenologue ayant dégusté un vin portant le nom d’appellation “Côte de Brouilly” le 24 Septembre 2018.
-- Utilisation : Utile pour savoir si une certaine appellation de vin a été dégusté à une date précise et si oui permet d'obtenir le ou les gouteurs de ce type de vin pour peut-etre les contacter.
-- Utilise une sous-requête dans WHERE via l'opérateur =.

/*SELECT nom_oenologue
FROM Oenologue
WHERE nom_oenologue = (SELECT nom_oenologue
                       FROM Oenologue JOIN Degustation
                       ON Oenologue.id_oenologue = Degustation.id_oenologue
                       JOIN Bouteille
                       ON Degustation.id_bouteille = Bouteille.id_bouteille
                       JOIN Appellation
                       ON Bouteille.id_appellation = Appellation.id_appellation
                       WHERE date_degustation = '24-Sep-18'
                       AND nom_appellation = 'Côte de Brouilly');*/


-- Requête 5b : affiche les vins rosés de type Vin tranquille et ayant reçu une note supérieure à 10 lors des dégustations.
-- Utilisation : Nous permet d'obtenir un vin de type et robe souhaité qui a eu une note superieure à celle voulue ici la moyenne.
-- Utilise une sous-requête dans WHERE via l'opéraeur IN.

/*SELECT Bouteille.id_bouteille, nom_bouteille, millesime_bouteille, note_degustation
FROM Bouteille JOIN Categorie
ON Bouteille.id_categorie = Categorie.id_categorie
JOIN Degustation
ON Degustation.id_bouteille = Bouteille.id_bouteille
WHERE Bouteille.id_bouteille IN ( SELECT Bouteille.id_bouteille
                                  FROM Bouteille JOIN Degustation
                                  ON Bouteille.id_bouteille = Degustation.id_bouteille
                                  WHERE note_degustation > 10.0 )
AND robe_bouteille = 'Rosé'
AND type_bouteille = 'Vin tranquille';*/


-- Requête 5c : affiche les notes que mettent les oenologues selon les millésimes depuis une requête qui donne toute les dégustations en détail.
-- Utilisation : Nous permet d'obtenir toutes les notes mises par les différents oenologues selon l'année des bouteilles de façon rapides.
-- Utilise une sous-requête dans la clause FROM.

/*SELECT millesime_bouteille, note_degustation, nom_oenologue
FROM (SELECT nom_bouteille, millesime_bouteille, volume_bouteille, note_degustation, date_degustation, nom_oenologue
      FROM Bouteille INNER JOIN Degustation
      ON Bouteille.id_bouteille = Degustation.id_bouteille
      INNER JOIN Oenologue
      ON Degustation.id_oenologue = Oenologue.id_oenologue) Degustation_Detail;*/


-- Requête 5d : Affiche le nom de la bouteille, la date de la degustation et la note de la degustation pour les notes supérieures a 10,
-- Depuis une requête qui donne les degustation et les bouteilles,
-- Depuis une requête qui donne les dégustation en détail.
-- Utilisation : Permet d'avoir les bouteilles bien notées et la date de note.
-- Utilise une sous-requêtes imbriquée dans une autre sous requête.

/*SELECT nom_bouteille, date_degustation, note_degustation FROM
    (SELECT nom_bouteille, millesime_bouteille, volume_bouteille, note_degustation, date_degustation
    FROM
   	 (SELECT nom_bouteille, millesime_bouteille, volume_bouteille, note_degustation, date_degustation, nom_oenologue
		 FROM Bouteille INNER JOIN Degustation
		 ON Bouteille.id_bouteille = Degustation.id_bouteille
		 INNER JOIN Oenologue
		 ON Degustation.id_oenologue = Oenologue.id_oenologue)
		 Degustation_Detail)
 	Degustation_Bouteille
WHERE note_degustation > 10;*/


-- Requête 5e : Affiche les bouteilles dont le prix est inférieur au prix moyen des bouteilles.
-- Utilisation : Permet le lister les bouteilles les moins chères de notre cave si on veut en racheter par exemple.
-- Utilise une sous-requête synchronisée.

/*SELECT nom_bouteille, millesime_bouteille, volume_bouteille, prix_bouteille
FROM Bouteille bouteilleOut
WHERE prix_bouteille < (
                       	SELECT AVG(prix_bouteille)
                       	FROM Bouteille bouteileIN);*/




-- Requête 6 : Renvoie le nom des bouteilles d'exception, on considère une bouteille d'exception si sa note est supérieure ou égale à 18.
-- Utilisation : avoir une bouteille très bien notée rapidement.
-- Par sous-requete :

-- Par sous-requete
/*SELECT nom_bouteille
FROM   bouteille
WHERE  id_bouteille IN (
    SELECT id_bouteille
    FROM   degustation
    WHERE  note_degustation >= 18
    );*/

-- Par jointure

/*SELECT nom_bouteille
FROM   bouteille NATURAL JOIN degustation
WHERE  note_degustation >=18;*/




-- Requête 7a : Requête affichant les vins blancs ainsi que la moyenne de leur note calculée à partir des notes attribuées lors des dégustations.
-- Utilisation : Permet d'avoir les bouteilles de robe souhaitée et leur note moyenne de toutes leur degustations.

/*SELECT id_bouteille, nom_bouteille,
       (
           SELECT AVG(note_degustation)
           FROM Degustation
           WHERE Degustation.id_bouteille = Bouteille.id_bouteille
       ) moyenne
FROM Bouteille JOIN Categorie
ON Bouteille.id_categorie = Categorie.id_categorie
WHERE robe_bouteille = 'Blanc';*/

-- Requête 7b : Requête affichant le prix total des bouteilles de la cave (prix_bouteille x nombre de bouteille).
-- Utilisation : Permet de savoir rapidement la valeur de la cave.

/*SELECT SUM(prix_bouteille * qte_bouteille) as Prix_cave
FROM Bouteille JOIN Quantite
ON Bouteille.nom_bouteille = Quantite.nom_bouteille
AND Bouteille.volume_bouteille = Quantite.volume_bouteille
AND Bouteille.millesime_bouteille = Quantite.millesime_bouteille;*/




-- Requête 8a : Renvoie le prix total des bouteilles de la cave classé par robe.
-- Utilisation : Permet de savoir rapidement la valeur additionnée des bouteilles de chaque type de notre cave si on en avait seulement 1 de chaque.

/*SELECT   robe_bouteille, sum(prix_bouteille) AS prix_total
FROM     categorie NATURAL JOIN bouteille
GROUP BY robe_bouteille;*/

-- Requête 8b : Renvoie la moyenne des notes donnéees par les oenologues.
-- Utilisation : Voir si les oenologues mettent en moyenne de bonnes ou mauvaises notes.

/*SELECT   nom_oenologue, cast(avg(note_degustation)AS DECIMAL (4,2)) AS note_moyenne
FROM     oenologue NATURAL JOIN degustation
GROUP BY nom_oenologue;*/




--Requête 9a : Renvoie le nom des oenologues fortunés qui ont gouté plus d'une bouteille et dont la somme de celle ci est supérieure a 300€ avec l'utilisation de HAVING.
-- Utilisation : Savoir quel oenologues ont gouté des bouteilles 'chères' ou beaucoup de bouteilles pour peut-être les contacter.

/*SELECT   nom_oenologue
FROM     oenologue o JOIN degustation d ON o.id_oenologue = d.id_oenologue
                     JOIN bouteille   b ON b.id_bouteille = d.id_bouteille
GROUP BY nom_oenologue
HAVING   count(note_degustation) > 1 AND sum(prix_bouteille) > 300;*/

-- Requête 9b : Renvoie le nom et millésime des bouteilles quand le stock de celle ci est vide avec l'utilisation de HAVING.
-- Utilisation : avoir rapidement le nom et l'année des bouteilles qu'on a plus.

/*SELECT b.nom_bouteille, b.millesime_bouteille
FROM bouteille b JOIN quantite q ON  b.nom_bouteille = q.nom_bouteille
                                 AND b.volume_bouteille = q.volume_bouteille
                                 AND b.millesime_bouteille = q.millesime_bouteille
GROUP BY b.nom_bouteille, b.millesime_bouteille
HAVING   sum(qte_bouteille) = 0;*/




-- Requête 10 : Compare la bouteille d’ID 1 avec les bouteilles d’ ID 5 à 10.
-- Utilisation : pourrait permettre de comparer une bouteille avec toutes les autres ou avec seulement certaines comme ici.

/*Select b1.nom_bouteille nom_1, b1.millesime_bouteille millesime_1, b1.prix_bouteille prix_1,
b2.nom_bouteille nom_2, b2.millesime_bouteille millesime_2, b2.prix_bouteille prix_2
FROM Bouteille b1, Bouteille b2
WHERE b1.id_bouteille = 1
AND b2.id_bouteille BETWEEN 5 AND 10;*/
