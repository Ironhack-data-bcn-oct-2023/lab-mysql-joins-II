-- challenge 1: Who Have Published What At Where?

select authors.au_id as 'Author ID',
       authors.au_lname as 'Author last name',
       authors.au_fname as 'Author first name',
       titles.title as 'Book title',
       publishers.pub_name as 'Publisher name'
	from authors
	   join titleauthor on authors.au_id = titleauthor.au_id
       join titles on titleauthor.title_id = titles.title_id
       join publishers on titles.pub_id = publishers.pub_id;
       
-- challenge 2 Who Have Published How Many At Where?

select authors.au_id as 'Author ID',
       authors.au_lname as 'last name',
       authors.au_fname as 'first name',
       publishers.pub_name as 'Publisher',
       count(titles.title) as 'total'
	from authors
	   join titleauthor on authors.au_id = titleauthor.au_id
       join titles on titleauthor.title_id = titles.title_id
       join publishers on titles.pub_id = publishers.pub_id
group by
		authors.au_id, authors.au_lname, authors.au_fname, publishers.pub_name;
        
-- challenge 3 Best Selling Authors

select authors.au_id as 'Author ID',
       authors.au_lname as 'last name',
       authors.au_fname as 'first name',
       sum(sales.qty) as 'sales quantity'
	from authors
	   join titleauthor on authors.au_id = titleauthor.au_id
       join titles on titleauthor.title_id = titles.title_id
       join sales on  titles.title_id = sales.title_id
group by
		authors.au_id, authors.au_lname, authors.au_fname
order by
    'TOTAL' desc
limit 3; 

-- challenge 4 Best Selling Authors Ranking

select authors.au_id as 'Author ID',
       authors.au_lname as 'last name',
       authors.au_fname as 'first name',
       sum(sales.qty) as 'sales quantity'
	from authors
	   left join titleauthor on authors.au_id = titleauthor.au_id
       left join titles on titleauthor.title_id = titles.title_id
       left join sales on  titles.title_id = sales.title_id
group by
		authors.au_id, authors.au_lname, authors.au_fname
order by
    'TOTAL' desc
