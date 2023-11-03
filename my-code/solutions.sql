USE PUBLICATIONS;

-- Challange 1. Who have published what at where.

select authors.au_id, au_lname, au_fname, title, pub_name as publisher, publishers.city
from authors
join titleauthor on authors.au_id = titleauthor.au_id
join titles on titleauthor.title_id = titles.title_id
join publishers on titles.pub_id = publishers.pub_id;

-- Challange 2. Who have published how many where

select authors.au_id, au_fname, au_lname, pub_name, count(title)
from authors
join titleauthor on authors.au_id = titleauthor.au_id
join titles on titleauthor.title_id = titles.title_id
join publishers on titles.pub_id = publishers.pub_id
group by au_id, pub_name
order by au_id;

-- Challange 3. Best selling authors. 
	-- Who are the top 3 authors who have sold the highest number of titles? Write a query to find out.
    
select authors.au_id, au_fname, au_lname, title, sum(qty) as copies_sold
from authors
join titleauthor on authors.au_id = titleauthor.au_id
join titles on titleauthor.title_id = titles.title_id
join sales on titles.title_id = sales.title_id
group by au_id , title
order by copies_sold desc
limit 3;

-- Challange 4. Best selling authors ranking.
    
select authors.au_id, au_fname, au_lname, title, COALESCE(SUM(qty), 0) as total
from authors
left join titleauthor on authors.au_id = titleauthor.au_id
left join titles on titleauthor.title_id = titles.title_id
left join sales on titles.title_id = sales.title_id
group by au_id , title
order by total desc; -- No hay ninguno que tenga 0. 


    
    