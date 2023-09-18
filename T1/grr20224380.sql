-- Questão 1 
SELECT id, populacao
FROM cidade;

-- Questão 2 
SELECT *
FROM cidade
WHERE populacao<130000; 

-- Questão 3
SELECT id, populacao
FROM cidade AS c, cidademar AS m 
WHERE c.id=m.cidade AND c.populacao<130000; 

-- Questão 4
SELECT id, populacao
FROM cidade AS c JOIN cidademar AS m ON c.id=m.cidade
WHERE c.populacao<130000; 

-- Questão 5
SELECT p.nome
FROM pais AS p 
JOIN paiscontinente AS pc ON pc.pais=p.codigo
WHERE pc.continente='Europe'
INTERSECT
SELECT p.nome
FROM paisreligiao AS pr 
JOIN pais AS p ON p.codigo=pr.pais;

-- Questão 6
--A :={Paises e linguas}
--B :={Linguas}
--A/B := {Paises que falam todas as linguas}

SELECT DISTINCT pl1.pais
FROM   paislingua AS pl1
WHERE  NOT EXISTS (
    (SELECT l1.lingua  FROM lingua AS l1)
    EXCEPT
    (SELECT pl2.lingua FROM paislingua AS pl2 WHERE pl1.pais=pl2.pais)
);

-- Questão 7
SELECT c.id, c.pais
FROM cidademar AS m
JOIN cidaderio AS r ON r.cidade=m.cidade
JOIN cidade    AS c ON r.cidade=c.id
WHERE c.pais IN (
    SELECT pc.pais 
    FROM paiscontinente AS pc
    WHERE pc.continente='Asia'
);

-- Questão 8
SELECT c.id
FROM cidade AS c
EXCEPT
SELECT m.cidade
FROM cidademar AS m; 

-- Questão 9
SELECT pc.continente, SUM(p.populacao) AS populacao
FROM paiscontinente AS pc 
JOIN pais AS p ON p.codigo=pc.pais
GROUP BY pc.continente;

-- Questão 10
SELECT pc.continente, SUM(p.populacao) AS populacao, MAX(p.pib) AS pibMax, MIN(p.pib) AS pibMin
FROM paiscontinente AS pc 
JOIN pais AS p ON p.codigo=pc.pais
GROUP BY pc.continente
HAVING  MIN(p.area) < MIN(p.pib);
