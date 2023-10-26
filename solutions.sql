use publications;

-- Challenge 1 - Who Have Published What At Where?
SELECT authors.au_id AS AUTHOR_ID, au_lname AS LAST_NAME, au_fname AS FIRST_NAME, title AS TITLE, pub_name AS PUBLISHER
	FROM authors
		join titleauthor
			on authors.au_id = titleauthor.au_id
				join titles
					on titleauthor.title_id = titles.title_id
						join publishers
							on
								titles.pub_id = publishers.pub_id;
                                
-- Challenge 2 - Who Have Published How Many At Where?
SELECT authors.au_id AS AUTHOR_ID, au_lname AS LAST_NAME, au_fname AS FIRST_NAME, pub_name AS PUBLISHER, count(title) AS TITLE_COUNT
	FROM authors
		join titleauthor
			on authors.au_id = titleauthor.au_id
				join titles
					on titleauthor.title_id = titles.title_id
						join publishers
							on
								titles.pub_id = publishers.pub_id
GROUP BY authors.au_id;

-- check if correct (should be = 25)
select sum(TITLE_COUNT) as CHECK_SUM_TITLE_COUNT from (
SELECT authors.au_id AS AUTHOR_ID, au_lname AS LAST_NAME, au_fname AS FIRST_NAME, pub_name AS PUBLISHER, count(title) AS TITLE_COUNT
	FROM authors
		join titleauthor
			on authors.au_id = titleauthor.au_id
				join titles
					on titleauthor.title_id = titles.title_id
						join publishers
							on
								titles.pub_id = publishers.pub_id
GROUP BY authors.au_id) as subquery;  -- 25 it's correct! Maybe there's a quicker way to just pull the sum of TITLE_COUNT without having to repeat the whole code?

-- Challenge 3 - Best Selling Authors
SELECT authors.au_id AS AUTHOR_ID, au_lname AS LAST_NAME, au_fname AS FIRST_NAME, sum(qty) as TOTAL_SALES_BY_AUTHOR
FROM authors
		join titleauthor
			on authors.au_id = titleauthor.au_id
				join titles
					on titleauthor.title_id = titles.title_id
						join sales
							on titles.title_id = sales.title_id
GROUP BY authors.au_id
ORDER BY TOTAL_SALES_BY_AUTHOR DESC limit 3;

--  AUTHOR_IF   LAST_NAME  FIRST   TOTAL SALES
-- '899-46-2035', 'Ringer', 'Anne', '148'
-- '998-72-3567', 'Ringer', 'Albert', '133'
-- '213-46-8915', 'Green', 'Marjorie', '50'


-- Challenge 4 - Best Selling Authors Ranking

-- IGNORE THIS ONE, even with COALESCE I was not getting the authors with 0 sales
SELECT authors.au_id AS AUTHOR_ID, au_lname AS LAST_NAME, au_fname AS FIRST_NAME, COALESCE(SUM(qty), 0) as TOTAL_SALES_BY_AUTHOR
	FROM authors
    JOIN titleauthor 
		ON authors.au_id = titleauthor.au_id
			JOIN titles 
				ON titleauthor.title_id = titles.title_id
					JOIN sales 
						ON titles.title_id = sales.title_id
GROUP BY authors.au_id, au_lname, au_fname
ORDER BY TOTAL_SALES_BY_AUTHOR DESC
LIMIT 23;

SELECT count(DISTINCT(au_id)) from authors; -- indeed gives me 23 authors


SELECT authors.au_id AS AUTHOR_ID, au_lname AS LAST_NAME, au_fname AS FIRST_NAME, COALESCE(SUM(qty), 0) as TOTAL_SALES_BY_AUTHOR
FROM authors -- by doing the left joing I will tell MYSql that I want everything from that table regardless of the match with whatever on the right
LEFT JOIN (
		SELECT titleauthor.au_id, SUM(sales.qty) as qty -- so I want to select everything else from the remaining tables that's not in the authors, and I start the Join caroussel
			FROM titleauthor
				JOIN titles 
					ON titleauthor.title_id = titles.title_id
						JOIN sales 
							ON titles.title_id = sales.title_id
GROUP BY titleauthor.au_id
) AS sales_by_author ON authors.au_id = sales_by_author.au_id -- and all of this between () subquery (I named sales_by_author) will be matched with the first selection "authors" where the au_id match
GROUP BY authors.au_id
ORDER BY TOTAL_SALES_BY_AUTHOR DESC limit 23;



