USE publications;

-- 1. Who have published what at where?
SELECT authors.au_id AS ID, authors.au_lname AS Surname, authors.au_fname AS Name, titles.title AS Title, publishers.pub_name AS Publisher
FROM publishers
JOIN titles ON publishers.pub_id=titles.pub_id
JOIN titleauthor ON titles.title_id=titleauthor.title_id
JOIN authors ON titleauthor.au_id=authors.au_id;

-- 2. Who have published how many at where?
SELECT authors.au_id AS ID, authors.au_lname AS Surname, authors.au_fname AS Name, publishers.pub_name AS Publisher, COUNT(titles.title) AS Count
FROM publishers
JOIN titles ON publishers.pub_id=titles.pub_id
JOIN titleauthor ON titles.title_id=titleauthor.title_id
JOIN authors ON titleauthor.au_id=authors.au_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname, publishers.pub_name;

-- 3. Best selling authors.
SELECT authors.au_id AS ID, authors.au_lname AS Surname, authors.au_fname AS Name, COUNT(titles.title) AS Count
FROM publishers
JOIN titles ON publishers.pub_id=titles.pub_id
JOIN titleauthor ON titles.title_id=titleauthor.title_id
JOIN authors ON titleauthor.au_id=authors.au_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY Count DESC
LIMIT 3;

-- 4. Best selling authors ranking
SELECT authors.au_id AS ID, authors.au_lname AS Surname, authors.au_fname AS Name, COUNT(titles.title) AS Count
FROM publishers
RIGHT JOIN titles ON publishers.pub_id=titles.pub_id
RIGHT JOIN titleauthor ON titles.title_id=titleauthor.title_id
RIGHT JOIN authors ON titleauthor.au_id=authors.au_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY Count DESC;