USE publications;

-- Challenge 1 - Who Have Published What At Where?
	-- titles, author, publishers
    -- Columns: au_id (authors), au_lname (authors), au_fname (authors), title (titles), pub_name (publishers)
SELECT authors.au_id AS AUTHOR_ID, authors.au_lname AS LAST_NAME, authors.au_fname AS FIRST_NAME, titles.title AS TITLE, publishers.pub_name AS PUBLISHER
		FROM authors
			JOIN titleauthor
				ON authors.au_id = titleauthor.au_id
			JOIN titles
				ON titleauthor.title_id = titles.title_id
			JOIN publishers
				ON titles.pub_id = publishers.pub_id
		ORDER BY authors.au_id;

-- Challenge 2 - Who Have Published How Many At Where?
	-- how many titles each author has published at each publisher
SELECT authors.au_id AS `AUTHOR ID`, authors.au_lname AS `LAST NAME`, authors.au_fname AS `FIRST NAME`,
publishers.pub_name AS PUBLISHER, COUNT(titles.title) AS `TITLE COUNT`
		FROM authors
			JOIN titleauthor
				ON authors.au_id = titleauthor.au_id
			JOIN titles
				ON titleauthor.title_id = titles.title_id
			JOIN publishers
				ON titles.pub_id = publishers.pub_id
		GROUP BY authors.au_id, publishers.pub_name
		ORDER BY `TITLE COUNT` DESC;

-- Challenge 3 - Best Selling Authors
	-- top 3 authors who have sold the highest number of titles
SELECT authors.au_id AS `AUTHOR ID`, authors.au_lname AS `LAST NAME`, authors.au_fname AS `FIRST NAME`, SUM(qty) AS TOTAL
	FROM authors
		JOIN titleauthor
			ON authors.au_id = titleauthor.au_id
		JOIN titles
			ON titleauthor.title_id = titles.title_id
		JOIN sales
			ON titles.title_id = sales.title_id
	GROUP BY authors.au_id
	ORDER BY TOTAL DESC
    LIMIT 3;

-- Challenge 4 - Best Selling Authors Ranking
	-- All 23 authors. Note that the authors who have sold 0 titles should also appear in your output
SELECT authors.au_id AS `AUTHOR ID`, authors.au_lname AS `LAST NAME`, authors.au_fname AS `FIRST NAME`, COALESCE(SUM(qty), 0) AS TOTAL
	FROM authors
		LEFT JOIN titleauthor
			ON authors.au_id = titleauthor.au_id
		LEFT JOIN titles
			ON titleauthor.title_id = titles.title_id
		LEFT JOIN sales
			ON titles.title_id = sales.title_id
	GROUP BY authors.au_id
	ORDER BY TOTAL DESC;