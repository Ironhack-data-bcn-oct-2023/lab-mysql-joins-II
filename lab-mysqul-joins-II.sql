use publications;
-- Challenge 1 - Who Have Published What At Where?
-- In this challenge you will write a MySQL SELECT query that joins various tables to figure out what titles each author has published at which publishers. Your output should have at least the following columns:

-- AUTHOR ID - the ID of the author
-- LAST NAME - author last name
-- FIRST NAME - author first name
-- TITLE - name of the published title
-- PUBLISHER - name of the publisher where the title was published
-- If your query is correct, the total rows in your output should be the same as the total number of records in Table titleauthor. =query = 25
SELECT COUNT(*)
FROM titleauthor;
SELECT authors.au_id AS Author_id, au_lname AS Last_name, au_fname AS First_name, title, pub_name AS Publisher
FROM authors
	JOIN titleauthor
		ON authors.au_id = titleauthor.au_id
	JOIN titles
		ON titleauthor.title_id = titles.title_id
	JOIN publishers
		ON publishers.pub_id = titles.pub_id;
-- Challenge 2 - Who Have Published How Many At Where?
-- Elevating from your solution in Challenge 1, query how many titles each author has published at each publisher. Your output should look something like below:
-- To check if your output is correct, sum up the TITLE COUNT column. The sum number should be the same as the total number of records in Table titleauthor.

SELECT authors.au_id AS Author_id, au_lname AS Last_name, au_fname AS First_name, pub_name AS Publisher, COUNT(titles.title_id) AS Title_count
FROM authors
	JOIN titleauthor
		ON authors.au_id = titleauthor.au_id
	JOIN titles
		ON titleauthor.title_id = titles.title_id
	JOIN publishers
		ON publishers.pub_id = titles.pub_id
GROUP BY Author_id, Last_name, First_name, Publisher
ORDER BY Author_id;
-- Challenge 3 - Best Selling Authors
-- Who are the top 3 authors who have sold the highest number of titles? Write a query to find out.
-- Requirements:
-- Your output should have the following columns:
-- AUTHOR ID - the ID of the author
-- LAST NAME - author last name
-- FIRST NAME - author first name
-- TOTAL - total number of titles sold from this author
-- Your output should be ordered based on TOTAL from high to low.
-- Only output the top 3 best selling authors.
SELECT authors.au_id AS Author_id, au_lname AS Last_name, au_fname AS First_name, sum(sales.qty) AS Total
FROM authors
	 JOIN titleauthor
		ON authors.au_id = titleauthor.au_id
	 JOIN titles
		ON titleauthor.title_id = titles.title_id
	 JOIN sales
		ON sales.title_id = titles.title_id
GROUP BY Author_id, Last_name, First_name
ORDER BY Total DESC
LIMIT 3;

-- Challenge 4 - Best Selling Authors Ranking
-- Now modify your solution in Challenge 3 so that the output will display all 23 authors instead of the top 3. Note that the authors 
-- who have sold 0 titles should also appear in your output (ideally display 0 instead of NULL as the TOTAL). 
-- Also order your results based on TOTAL from high to low.

SELECT authors.au_id AS Author_id, au_lname AS Last_name, au_fname AS First_name, IFNULL(COUNT(titles.title_id), 0) AS Total
FROM authors
	LEFT JOIN titleauthor
		ON authors.au_id = titleauthor.au_id
	LEFT JOIN titles
		ON titleauthor.title_id = titles.title_id
	LEFT JOIN sales
		ON sales.title_id = titles.title_id
GROUP BY Author_id, Last_name, First_name
ORDER BY Total DESC;
