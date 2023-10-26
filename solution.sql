USE publications;

-- 1
SELECT authors.au_id AS `AUTHOR ID`, authors.au_lname AS `LAST NAME`, authors.au_fname AS `FIRST NAME`, titles.title AS `TITLE`, publishers.pub_name AS `PUBLISHER`
FROM authors
JOIN titleauthor ON authors.au_id = titleauthor.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN publishers ON publishers.pub_id = titles.pub_id;

SELECT COUNT(*) as `ROW COUNT`
FROM ( SELECT authors.au_id AS `AUTHOR ID`, authors.au_lname AS `LAST NAME`, authors.au_fname AS `FIRST NAME`, titles.title AS `TITLE`, publishers.pub_name AS `PUBLISHER`
FROM authors
JOIN titleauthor ON authors.au_id = titleauthor.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN publishers ON publishers.pub_id = titles.pub_id) AS subquery; -- count 25
SELECT COUNT(*) FROM titleauthor; -- count 25

-- 2
SELECT
    authors.au_id AS `AUTHOR ID`,
    authors.au_lname AS `LAST NAME`,
    authors.au_fname AS `FIRST NAME`,
    publishers.pub_name AS `PUBLISHER`,
    COUNT(titles.title) AS `TITLE COUNT`
FROM authors
JOIN titleauthor ON authors.au_id = titleauthor.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY authors.au_id, publishers.pub_name
ORDER BY `TITLE COUNT` DESC;

-- 3
SELECT
    authors.au_id AS `AUTHOR ID`,
    authors.au_lname AS `LAST NAME`,
    authors.au_fname AS `FIRST NAME`,
    SUM(sales.qty) AS `TOTAL`
FROM authors
JOIN titleauthor ON authors.au_id = titleauthor.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN sales ON titles.title_id = sales.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY `TOTAL` DESC
LIMIT 3;

--4
SELECT
    authors.au_id AS `AUTHOR ID`,
    authors.au_lname AS `LAST NAME`,
    authors.au_fname AS `FIRST NAME`,
    COALESCE(SUM(sales.qty), 0) AS `TOTAL`
FROM authors
JOIN titleauthor ON authors.au_id = titleauthor.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN sales ON titles.title_id = sales.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY `TOTAL` DESC;