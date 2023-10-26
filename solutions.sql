use publications;

-- Challenge 1 - Who Have Published What At Where?
select authors.au_ID as AUTHOR_ID, authors.au_lname as AUTHOR_LAST_NAME, authors.au_fname as AUTHOR_FIRST_NAME, titles.title as TITLE, publishers.pub_name as PUBLISHER
from authors
join titleauthor
on authors.au_id = titleauthor.au_id
join titles
on titleauthor.title_id = titles.title_id
join publishers
on titles.pub_id = publishers.pub_id
GROUP BY AUTHOR_ID, AUTHOR_LAST_NAME, AUTHOR_FIRST_NAME, TITLE, PUBLISHER

-- Challenge 2 - Who Have Published How Many At Where?
select authors.au_ID as AUTHOR_ID, authors.au_lname as AUTHOR_LAST_NAME, authors.au_fname as AUTHOR_FIRST_NAME, count(titles.title)as COUNT, publishers.pub_name as PUBLISHERS
from authors
join titleauthor
on authors.au_id = titleauthor.au_id
join titles
on titleauthor.title_id = titles.title_id
join publishers
on titles.pub_id = publishers.pub_id
GROUP BY AUTHOR_ID, AUTHOR_LAST_NAME, AUTHOR_FIRST_NAME, PUBLISHERS;

-- Challenge 3 - Best Selling Authors
select authors.au_ID as AUTHOR_ID, authors.au_lname as AUTHOR_LAST_NAME, authors.au_fname as AUTHOR_FIRST_NAME, sum(sales.QTY) as TOTAL
from authors
join titleauthor
on authors.au_id = titleauthor.au_id
join titles
on titleauthor.title_id = titles.title_id
join sales
on titles.title_ID = sales.title_ID
GROUP BY AUTHOR_ID, AUTHOR_LAST_NAME, AUTHOR_FIRST_NAME
order by TOTAL desc
limit 3;

-- Challenge 4 - Best Selling Authors Ranking
select authors.au_ID as AUTHOR_ID, authors.au_lname as AUTHOR_LAST_NAME, authors.au_fname as AUTHOR_FIRST_NAME, coalesce(sum(qty), 0) as TOTAL
from authors
left join (
select titleauthor.au_id, sum(qty) as qty
from titleauthor
join titles
on titleauthor.title_id = titles.title_id 
join sales
on titles.title_ID = sales.title_ID
group by titleauthor.au_id)
as sales_by_author on authors.au_id = sales_by_author.au_id
group by authors.au_id
order by TOTAL desc
limit 23; 







