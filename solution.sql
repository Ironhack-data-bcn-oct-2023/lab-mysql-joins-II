USE PUBLICATIONS; 

-- 1. 
SELECT authors.au_id AS "AUHTOR ID", authors.au_fname AS "FIRST NAME", authors.au_lname AS "LAST NAME", titles.title AS "TITLE", publishers.pub_name AS "PUBLISHER"
FROM authors
JOIN titleauthor ON	authors.au_id = titleauthor.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN publishers ON titles.pub_id = publishers.pub_id;

-- 2. 
SELECT authors.au_id AS "AUHTOR ID", authors.au_lname AS "LAST NAME", authors.au_fname AS "FIRST NAME", publishers.pub_name AS "PUBLISHER", COUNT(*) AS "TITLES COUNT"
FROM authors
JOIN titleauthor ON	authors.au_id = titleauthor.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY authors.au_id, authors.au_fname, authors.au_lname, publishers.pub_name;

-- 3. 
SELECT authors.au_id AS "AUHTOR ID", authors.au_lname AS "LAST NAME", authors.au_fname AS "FIRST NAME", titles.ytd_sales AS "TOTAL"
FROM authors
JOIN titleauthor ON	authors.au_id = titleauthor.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_fname, authors.au_lname, titles.ytd_sales
ORDER BY titles.ytd_sales DESC
LIMIT 3; 

-- 4. 
SELECT authors.au_id AS "AUHTOR ID", authors.au_lname AS "LAST NAME", authors.au_fname AS "FIRST NAME", titles.ytd_sales AS "TOTAL"
FROM authors
JOIN titleauthor ON	authors.au_id = titleauthor.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_fname, authors.au_lname, titles.ytd_sales
ORDER BY titles.ytd_sales DESC;




