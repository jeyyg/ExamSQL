/*1. Ajoutez la colonne salary, salaire annuel, dans la table pilots, définissez son type.
Vous donnerez la requête SQL pour modifier la table. Puis faites une requête pour ajouter les salaires respectifs suivants :*/
ALTER TABLE pilots ADD salary INT;

UPDATE pilots
SET salary = (CASE 
    WHEN name IN ('Alan', 'Sophie', 'Albert', 'Benoit') THEN 2000.0
    WHEN name IN ('Tom', 'Yi', 'Yan') THEN 1500.0
    ELSE 3000.0
END);

/*01.1 Quel est le salaire moyen.*/
SELECT AVG(salary) AS salaire_moyen
FROM pilots;

/*01.2 Calculez le salaire moyen par compagnie.*/
SELECT AVG(salary) AS salaire_moyen
FROM pilots
GROUP BY compagny;

/*01.3 Quels sont les pilots qui sont au-dessus du salaire moyen.*/
SELECT name, salary
FROM pilots
WHERE salary > (SELECT AVG(salary) FROM pilots);


/*01.4 Calculez l'étendu des salaires.*/
SELECT MAX(salary) - MIN(salary) AS etendu_des_dalaires
FROM pilots;

/*01.5 Quels sont les noms des compagnies qui payent leurs pilotes au-dessus de la moyenne ?*/
SELECT c.name, p.salary
FROM compagnies AS c
INNER JOIN pilots AS p
ON c.comp = p.compagny
WHERE p.salary > (SELECT AVG(salary) FROM pilots);

/*01.6 Quels sont les pilotes qui par compagnie dépasse(nt) le salaire moyen ?*/
SELECT p.name, p.salary, c.name
FROM pilots as p
INNER JOIN compagnies as c
ON p.compagny = c.comp
WHERE salary > (SELECT AVG(salary) FROM pilots)
GROUP BY c.name;


/*02.1 Faites une requête qui diminue de 40% le salaire des pilotes de la compagnie AUS.*/
SELECT salary*0.6, name
FROM pilots
WHERE compagny = 'AUS';

/*02.2 Vérifiez que les salaires des pilotes australiens sont tous inférieurs aux autres salaires des pilotes des autres compagnies.*/
SELECT salary, compagny
FROM pilots
WHERE salary = (compagny = "AUS") < ALL(SELECT salary FROM pilots)
GROUP BY compagny;

/*03.1 On aimerait savoir quels sont les types d'avions en commun que la compagnie AUS et FRE1 exploitent.*/
SELECT DISTINCT plane, compagny
FROM pilots
WHERE compagny='AUS'
AND plane IN (
  SELECT plane
  FROM pilots
  WHERE compagny='FRE1');


/*03.2 Quels sont les types d'avion que ces deux compagnies AUS et FRE1 exploitent (c'est l'UNION ici) ?*/
SELECT plane
FROM pilots
WHERE compagny='AUS'
UNION
SELECT plane
FROM pilots
WHERE compagny='FRE1';