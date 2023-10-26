#Challenge 1 - Who Have Published What At Where?
use publications;
select authors.au_id, au_lname, au_fname, title, pub_name
	from authors
		join titleauthor
			on authors.au_id = titleauthor.au_id
		join titles
			on titleauthor.title_id = titles.title_id
		join publishers
			on titles.pub_id = publishers.pub_id;

#Challenge 2 - Who Have Published How Many At Where?
select authors.au_id, au_lname, au_fname, pub_name, count(title) as title_count
	from authors
		join titleauthor
			on authors.au_id = titleauthor.au_id
		join titles
			on titleauthor.title_id = titles.title_id
		join publishers
			on titles.pub_id = publishers.pub_id
		group by authors.au_id, au_lname, au_fname, pub_name
        order by count(title) desc;
        
#3 Challenge 3 - Best Selling Authors
select authors.au_id, au_lname, au_fname, sum(qty) as sales
	from authors
		join titleauthor
			on authors.au_id = titleauthor.au_id
		join titles
			on titleauthor.title_id = titles.title_id
		join sales 
			on titles.title_id = sales.title_id
		group by authors.au_id, au_lname, au_fname
        order by sum(qty) desc
        limit 3;
        
#4 Challenge 4 - Best Selling Authors Ranking
select authors.au_id, au_lname, au_fname, coalesce(sum(qty), 0) as total
	from authors
		left join titleauthor
			on authors.au_id = titleauthor.au_id
		left join titles
			on titleauthor.title_id = titles.title_id
		left join sales 
			on titles.title_id = sales.title_id
		group by authors.au_id, au_lname, au_fname
        order by total desc
        limit 23;

select distinct(au_id) from authors;