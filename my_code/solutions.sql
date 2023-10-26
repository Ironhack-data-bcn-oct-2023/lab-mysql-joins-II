USE publications;

-- ## Challenge 1 - Who Have Published What At Where?

SELECT authors.au_id, 
authors.au_lname AS last_name, 
authors.au_fname as first_name, 
title, 
pub_name as PUBLISHER 
from authors
join titleauthor
on authors.au_id = titleauthor.au_id
join titles
on titleauthor.title_id = titles.title_id
join publishers
on titles.pub_id = publishers.pub_id;

--  ## Challenge 2 - Who Have Published How Many At Where?

SELECT authors.au_id, 
authors.au_lname AS last_name, 
authors.au_fname as first_name, 
count(title), 
pub_name as PUBLISHER
from authors
join titleauthor
on authors.au_id = titleauthor.au_id
join titles
on titleauthor.title_id = titles.title_id
join publishers
on titles.pub_id = publishers.pub_id
GROUP BY au_id, pub_name;


-- Challenge 3 - Best Selling Authors

select authors.au_id AS AUTHOR_ID, au_fname AS FIRST_NAME, au_lname AS LAST_NAME, sum(ytd_sales) AS TOTAL
from authors
join titleauthor
on authors.au_id = titleauthor.au_id
join titles
on titleauthor.title_id = titles.title_id
group by authors.au_id, ytd_sales
order by ytd_sales desc
limit 3;


-- 	Challenge 4 - Best Selling Authors Ranking
-- Now modify your solution in Challenge 3 so that the output will display all 23 authors 
-- instead of the top 3. Note that the authors who have sold 0 titles should also appear in 
-- your output (ideally display `0` instead of `NULL` as the `TOTAL`). Also order your results 
-- based on `TOTAL` from high to low.

select authors.au_id AS AUTHOR_ID, au_fname AS FIRST_NAME, au_lname AS LAST_NAME, 
COALESCE(SUM(ytd_sales), 0) AS TOTAL
from authors
join titleauthor
on authors.au_id = titleauthor.au_id
join titles
on titleauthor.title_id = titles.title_id
group by authors.au_id, ytd_sales
order by ytd_sales desc











