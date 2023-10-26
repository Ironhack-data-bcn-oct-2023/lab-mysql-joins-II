USE publications;

-- Challenge 1
-- In this challenge you will write a MySQL SELECT query that joins various tables
-- to figure out what titles each author has published at which publishers.
-- Your output should have at least the following columns:

-- AUTHOR ID - the ID of the author
-- LAST NAME - author last name
-- FIRST NAME - author first name
-- TITLE - name of the published title
-- PUBLISHER - name of the publisher where the title was published

SELECT
	authors.au_id AS author_id,
	authors.au_lname AS last_name,
    authors.au_fname AS first_name,
    titles.title,
    publishers.pub_name AS publisher
	FROM authors
		JOIN titleauthor
			ON authors.au_id = titleauthor.au_id
		JOIN titles
			ON titleauthor.title_id = titles.title_id
		JOIN publishers
			ON titles.pub_id = publishers.pub_id

-- Challenge 2
-- how many titles each author has published at each publisher

SELECT
	authors.au_id AS author_id,
	authors.au_lname AS last_name,
    authors.au_fname AS first_name,
    pub_name,
    COUNT(*) AS titles_count
	FROM authors
		JOIN titleauthor
			ON authors.au_id = titleauthor.au_id
		JOIN titles
			ON titleauthor.title_id = titles.title_id
		JOIN publishers
			ON titles.pub_id = publishers.pub_id
	GROUP BY authors.au_id, publishers.pub_name
    
-- Challenge 3

-- Who are the top 3 authors who have sold the highest number of titles? Write a query to find out.

-- Your output should have the following columns:
-- AUTHOR ID - the ID of the author
-- LAST NAME - author last name
-- FIRST NAME - author first name
-- TOTAL - total number of titles sold from this author
-- Your output should be ordered based on TOTAL from high to low.
-- Only output the top 3 best selling authors.

SELECT
	authors.au_id AS author_id,
	authors.au_lname AS last_name,
    authors.au_fname AS first_name,
    SUM(qty) AS total
	FROM authors
		JOIN titleauthor
			ON authors.au_id = titleauthor.au_id
		JOIN titles
			ON titleauthor.title_id = titles.title_id
		JOIN sales
			ON titles.title_id = sales.title_id
	GROUP BY authors.au_id
    ORDER BY total DESC
    LIMIT 3;
    
    
-- Challenge 4
-- Now modify your solution in Challenge 3 so that the output will display all 23 authors instead of the top 3.
-- Note that the authors who have sold 0 titles should also appear in your output (ideally display 0 instead of NULL as the TOTAL).
-- Also order your results based on TOTAL from high to low.


SELECT
	authors.au_id AS author_id,
	authors.au_lname AS last_name,
    authors.au_fname AS first_name,
    COALESCE(SUM(qty), 0) AS total
	FROM authors
		LEFT JOIN titleauthor
			ON authors.au_id = titleauthor.au_id
		LEFT JOIN titles
			ON titleauthor.title_id = titles.title_id
		LEFT JOIN sales
			ON titles.title_id = sales.title_id
	GROUP BY authors.au_id
    ORDER BY total DESC
	LIMIT 23;

