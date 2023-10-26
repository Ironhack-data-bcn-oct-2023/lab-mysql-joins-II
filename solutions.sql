use publications;

-- Challenge 1 - Who Have Published What At Where?
-- In this challenge you will write a MySQL SELECT query that joins various tables to figure out what 
-- titles each author has published at which publishers. Your output should have at least the following columns:
-- AUTHOR ID - the ID of the author
-- LAST NAME - author last name
-- FIRST NAME - author first name
-- TITLE - name of the published title
-- PUBLISHER - name of the publisher where the title was published
-- Your output will look something like below:

SELECT 
    authors.au_id AUTHOR_ID,
    authors.au_lname LAST_NAME,
    authors.au_fname FIRST_NAME,
    titles.title TITLE,
    publishers.pub_name PUBLISHER
FROM
    publishers
        JOIN
    titles ON titles.pub_id = publishers.pub_id
        JOIN
    titleauthor ON titleauthor.title_id = titles.title_id
        JOIN
    authors ON authors.au_id = titleauthor.au_id
ORDER BY authors.au_id;

-- Challenge 2 - Who Have Published How Many At Where?
-- Elevating from your solution in Challenge 1, query how many titles each 
-- author has published at each publisher. Your output should look something like below:
-- To check if your output is correct, sum up the TITLE COUNT column. The sum number should be the same as 
-- the total number of records in Table titleauthor.
-- Hint: In order to count the number of titles published by an author, you need to use MySQL COUNT. 
-- Also check out MySQL Group By because you will count the rows of different groups of data. Refer to the references and learn by yourself. These features will be formally discussed in the Temp Tables and Subqueries lesson.

SELECT 
    authors.au_id AUTHOR_ID,
    authors.au_lname LAST_NAME,
    authors.au_fname FIRST_NAME,
    publishers.pub_name PUBLISHER,
    COUNT(titles.title) TITLE
FROM
    publishers
        JOIN
    titles ON titles.pub_id = publishers.pub_id
        JOIN
    titleauthor ON titleauthor.title_id = titles.title_id
        JOIN
    authors ON authors.au_id = titleauthor.au_id
GROUP BY AUTHOR_ID , LAST_NAME , FIRST_NAME , PUBLISHER
ORDER BY authors.au_id DESC;

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

SELECT 
    authors.au_id AUTHOR_ID,
    authors.au_lname LAST_NAME,
    authors.au_fname FIRST_NAME,
    MAX(sales.qty) TOTAL
FROM
    sales
        JOIN
    titles ON titles.title_id = sales.title_id
        JOIN
    titleauthor ON titleauthor.title_id = titles.title_id
        JOIN
    authors ON authors.au_id = titleauthor.au_id
GROUP BY AUTHOR_ID , LAST_NAME , FIRST_NAME
ORDER BY authors.au_id DESC
LIMIT 3;

-- Challenge 4 - Best Selling Authors Ranking
-- Now modify your solution in Challenge 3 so that the output will display all 23 authors instead of the top 3.
-- Note that the authors who have sold 0 titles should also appear in your output (ideally display 0 instead of NULL as the TOTAL).
-- Also order your results based on TOTAL from high to low.

SELECT 
    authors.au_id AUTHOR_ID,
    authors.au_lname LAST_NAME,
    authors.au_fname FIRST_NAME,
    COALESCE(MAX(sales.qty), 0) TOTAL
FROM
    sales
        JOIN
    titles ON titles.title_id = sales.title_id
        JOIN
    titleauthor ON titleauthor.title_id = titles.title_id
        RIGHT JOIN
    authors ON authors.au_id = titleauthor.au_id
GROUP BY AUTHOR_ID , LAST_NAME , FIRST_NAME
ORDER BY TOTAL DESC;






