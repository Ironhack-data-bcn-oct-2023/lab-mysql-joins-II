USE publications;

--  Challenge 1 - Who Have Published What At Where?
	# In this challenge you will write a MySQL `SELECT` query that joins various tables to figure out what titles each author has published at which publishers. Your output should have at least the following columns:
		## `AUTHOR ID` - the ID of the author
        ## `LAST NAME` - author last name
        ## `FIRST NAME` - author first name
        ## `TITLE` - name of the published title
        ##`PUBLISHER` - name of the publisher where the title was published
	# If your query is correct, the total rows in your output should be the same as the total number of records in Table `titleauthor`.

SELECT authors.au_id AS `AUTHOR ID`, authors.au_lname AS `LAST NAME`, authors.au_fname AS `FIRST NAME`, titles.title AS `TITLE`, publishers.pub_name AS `PUBLISHER`
	FROM authors
		JOIN titleauthor ON authors.au_id = titleauthor.au_id
		JOIN titles ON titleauthor.title_id = titles.title_id
        JOIN publishers ON titles.pub_id = publishers.pub_id;
        
SELECT COUNT(*) FROM titleauthor;
SELECT COUNT(*) AS `TOTAL ROWS`
FROM (SELECT authors.au_id AS `AUTHOR ID`, authors.au_lname AS `LAST NAME`, authors.au_fname AS `FIRST NAME`, titles.title AS `TITLE`, publishers.pub_name AS `PUBLISHER`
	FROM authors
		JOIN titleauthor ON authors.au_id = titleauthor.au_id
		JOIN titles ON titleauthor.title_id = titles.title_id
        JOIN publishers ON titles.pub_id = publishers.pub_id)
AS subquery;

	-- it's correct, we have 25 rows in titleauthor and in the JOIN of challenge 1


-- Challenge 2 - Who Have Published How Many At Where?
	# Elevating from your solution in Challenge 1, query how many titles each author has published at each publisher. 
	# To check if your output is correct, sum up the `TITLE COUNT` column. The sum number should be the same as the total number of records in Table `titleauthor`.
    
SELECT authors.au_id AS `AUTHOR ID`, authors.au_lname AS `LAST NAME`, authors.au_fname AS `FIRST NAME`, titles.title AS `TITLE`, publishers.pub_name AS `PUBLISHER`, COUNT(authors.au_id) AS 'TITLE COUNT'
	FROM authors
		JOIN titleauthor ON authors.au_id = titleauthor.au_id
		JOIN titles ON titleauthor.title_id = titles.title_id
        JOIN publishers ON titles.pub_id = publishers.pub_id
	GROUP BY `AUTHOR ID`, `LAST NAME`, `FIRST NAME`, `TITLE`, `PUBLISHER`;
    -- Answer: All of them have published one title per publisher

-- Challenge 3 - Best Selling Authors
	# Who are the top 3 authors who have sold the highest number of titles? Write a query to find out.
		-- Your output should have the following columns:
				# `AUTHOR ID` - the ID of the author
                # `LAST NAME` - author last name
                # `FIRST NAME` - author first name
                # `TOTAL` - total number of titles sold from this author
		-- Your output should be ordered based on `TOTAL` from high to low.
		-- Only output the top 3 best selling authors.
	
SELECT * FROM authors;
SELECT * FROM titles;

SELECT authors.au_id AS `AUTHOR ID`, authors.au_lname AS `LAST NAME`, authors.au_fname AS `FIRST NAME`, SUM(titles.ytd_sales) AS `TOTAL`
	FROM authors
		JOIN titleauthor ON authors.au_id = titleauthor.au_id
		JOIN titles ON titleauthor.title_id = titles.title_id
	GROUP BY `AUTHOR ID`, `LAST NAME`, `FIRST NAME`
    ORDER BY 'TOTAL' DESC
    LIMIT 3;
    -- Answer: Marjorie Green, Abraham Bennet, Michael O'leary
    
    
--  Challenge 4 - Best Selling Authors Ranking
	# Now modify your solution in Challenge 3 so that the output will display all 23 authors instead of the top 3. Note that the authors who have sold 0 titles should also appear in your output (ideally display `0` instead of `NULL` as the `TOTAL`). Also order your results based on `TOTAL` from high to low.
    
SELECT authors.au_id AS `AUTHOR ID`, authors.au_lname AS `LAST NAME`, authors.au_fname AS `FIRST NAME`, IFNULL(SUM(titles.ytd_sales), 0) AS `TOTAL`
	FROM authors
		LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
		LEFT JOIN titles ON titleauthor.title_id = titles.title_id
	GROUP BY `AUTHOR ID`, `LAST NAME`, `FIRST NAME`
    ORDER BY `TOTAL` DESC;