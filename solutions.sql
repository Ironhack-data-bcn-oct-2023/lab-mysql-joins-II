USE publications;

-- CHALLENGE 1 - Who Have Published What At Where?

select authors.au_id as author_id, au_lname as last_name, au_fname as first_name, title, pub_name
 from authors
	join titleauthor
		on titleauthor.au_id = authors.au_id
	join titles
		on titleauthor.title_id = titles.title_id
	join publishers
		on publishers.pub_id = titles.pub_id;
        
-- CHALLENGE 2- Who Have Published How Many At Where?

select authors.au_id as author_id, au_lname as last_name, au_fname as first_name, pub_name, count(titleauthor.title_id) as title_count
 from authors
	join titleauthor
		on titleauthor.au_id = authors.au_id
	join titles
		on titleauthor.title_id = titles.title_id
	join publishers
		on publishers.pub_id = titles.pub_id
	group by author_id, publishers.pub_name
    order by title_count desc;
    

-- CHALLENGE 3: Best Selling Authors

select authors.au_id as author_id, au_lname as last_name, au_fname as first_name, sum(qty) as total
 from authors
	join titleauthor
		on titleauthor.au_id = authors.au_id
	join titles
		on titleauthor.title_id = titles.title_id
	join sales
		on sales.title_id = titles.title_id
	group by author_id
    order by total desc
    limit 3;
    
-- CHALLENGE 4: Best Selling Authors Ranking

select authors.au_id as author_id, au_lname as last_name, au_fname as first_name, coalesce(sum(qty),0) as total
 from authors
	left join titleauthor
		on titleauthor.au_id = authors.au_id
	left join titles
		on titleauthor.title_id = titles.title_id
	left join sales
		on sales.title_id = titles.title_id
	group by author_id
    order by total desc;