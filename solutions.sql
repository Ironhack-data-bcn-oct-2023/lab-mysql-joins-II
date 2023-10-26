USE publications;

/*'Challenge 1 - Who Have Published What At Where?

In this challenge you will write a MySQL SELECT query that joins various tables 
to figure out what titles each author has published at which publishers. 
Your output should have at least the following columns:

AUTHOR ID - the ID of the author
LAST NAME - author last name
FIRST NAME - author first name
TITLE - name of the published title
PUBLISHER - name of the publisher where the title was published'*/

select  authors.au_id,authors.au_lname, authors.au_fname, titles.title,publishers.pub_name from titles
	join titleauthor
			on titleauthor.title_id = titles.title_id
	join  authors
		on authors.au_id = titleauthor.au_id
	join publishers
		on publishers.pub_id = titles.pub_id;
        
/*
Challenge 2 - Who Have Published How Many At Where?
Elevating from your solution in Challenge 1, query how many titles each author 
has published at each publisher. Your output should look something like below:
*/

select  authors.au_id, authors.au_lname, authors.au_fname,publishers.pub_name,count(titles.title) from titles
	join titleauthor
			on titleauthor.title_id = titles.title_id
	join  authors
		on authors.au_id = titleauthor.au_id
	join publishers
		on publishers.pub_id = titles.pub_id
group by authors.au_id, authors.au_lname, authors.au_fname, publishers.pub_name
order by authors.au_id desc;


/*

Challenge 3 - Best Selling Authors
Who are the top 3 authors who have sold the highest number of titles? Write a query to find out.

Requirements:

Your output should have the following columns:
AUTHOR ID - the ID of the author
LAST NAME - author last name
FIRST NAME - author first name
TOTAL - total number of titles sold from this author
Your output should be ordered based on TOTAL from high to low.
Only output the top 3 best selling authors.
*/

select  authors.au_id,authors.au_lname, authors.au_fname,sum(sales.qty) as total_sales from titles
	join titleauthor
			on titleauthor.title_id = titles.title_id
	join  authors
		on authors.au_id = titleauthor.au_id
	join sales
		on sales.title_id = titles.title_id
group by authors.au_id,authors.au_lname, authors.au_fname
order by total_sales desc
limit 3;

/*Challenge 4 - Best Selling Authors Ranking
Now modify your solution in Challenge 3 so that the output will display all 23 authors instead of the top 3. 
Note that the authors who have sold 0 titles should also appear in your 
output (ideally display 0 instead of NULL as the TOTAL). 
Also order your results based on TOTAL from high to low.*/

select  authors.au_id,authors.au_lname, authors.au_fname,COALESCE(SUM(sales.qty),0) as total_sales from authors
	  left join titleauthor
		on titleauthor.au_id = authors.au_id
	 left join sales
		on sales.title_id = titleauthor.title_id
group by authors.au_id,authors.au_lname, authors.au_fname
order by total_sales desc;


