use publications;
-- Challenge 1 

select authors.au_id, authors.au_lname as last_name,
authors.au_fname as first_name, titles.title as TITLE, publishers.pub_name as PUBLISHERS
	from  authors
    JOIN  titleauthor ON authors.au_id = titleauthor.au_id
    JOIN titles ON titleauthor.title_id = titles.title_id
    JOIN publishers ON titles.pub_id = publishers.pub_id
;

-- Challenge 2
select authors.au_id as author_id, authors.au_lname as last_name,
authors.au_fname as first_name, publishers.pub_name as PUBLISHERS, COUNT(titles.title_id) as TITLE_COUNT
	from  authors
    JOIN  titleauthor ON authors.au_id = titleauthor.au_id
    JOIN titles ON titleauthor.title_id = titles.title_id
    JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY author_id, last_name, first_name, PUBLISHERS
;

-- Challenge 3
SELECT authors.au_id as author_id, authors.au_lname as last_name,
authors.au_fname as first_name, sum(sales.qty) as sales
	from  authors
    JOIN  titleauthor ON authors.au_id = titleauthor.au_id
    JOIN titles ON titleauthor.title_id = titles.title_id
    JOIN sales ON titles.title_id = sales.title_id
Group BY author_id, last_name, first_name
order by sales desc
limit 3
;

-- Challenge 4
SELECT authors.au_id as author_id, sum(sales.qty) as sales
	from  authors
    JOIN  titleauthor ON authors.au_id = titleauthor.au_id
    JOIN titles ON titleauthor.title_id = titles.title_id
    JOIN sales ON titles.title_id = sales.title_id
Group BY author_id
order by sales desc
;
