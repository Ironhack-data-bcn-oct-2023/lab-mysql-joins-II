-- Challenge 1.  Who Have Published What At Where?
use publications;
SELECT * FROM authors;

SELECT authors.au_id, authors.au_lname, authors.au_fname, titleauthor.title_id, publishers.pub_name  
	FROM publishers   
		RIGHT JOIN titles 
			ON publishers.pub_id = titles.pub_id   
		RIGHT JOIN titleauthor 
			ON titleauthor.title_id = titles.title_id    
		RIGHT JOIN authors 
			ON authors.au_id = titleauthor.au_id   
	GROUP BY authors.au_id, authors.au_lname, authors.au_fname, titleauthor.title_id, publishers.pub_name;

	
-- Challenge 2. Who Have Published How Many At Where?
SELECT authors.au_id, authors.au_fname, authors.au_lname, publishers.pub_name, COUNT(titles.title) AS title_count
	FROM publishers   
		RIGHT JOIN titles 
			ON publishers.pub_id = titles.pub_id   
		RIGHT JOIN titleauthor 
			ON titleauthor.title_id = titles.title_id    
		RIGHT JOIN authors 
			ON authors.au_id = titleauthor.au_id   
	GROUP BY authors.au_id, authors.au_lname, authors.au_fname, publishers.pub_name
    ORDER BY title_count DESC;
    
-- Challenge 3. Best Selling Authors
SELECT authors.au_id, authors.au_lname, authors.au_fname, MAX(sales.qty) AS title
	FROM sales 
		RIGHT JOIN titles 
			ON sales.title_id = titles.title_id
		RIGHT JOIN titleauthor 
			ON titleauthor.title_id = titles.title_id    
		RIGHT JOIN authors 
			ON authors.au_id = titleauthor.au_id   
	GROUP BY authors.au_id, authors.au_lname, authors.au_fname
    ORDER BY title DESC
	LIMIT 3;
    
-- Challenge 4. Best Selling Authors Ranking
SELECT authors.au_id, authors.au_lname, authors.au_fname, MAX(sales.qty) AS title
	FROM sales 
		RIGHT JOIN titles 
			ON sales.title_id = titles.title_id
		RIGHT JOIN titleauthor 
			ON titleauthor.title_id = titles.title_id    
		RIGHT JOIN authors 
			ON authors.au_id = titleauthor.au_id   
	GROUP BY authors.au_id, authors.au_lname, authors.au_fname
    ORDER BY title ASC
	LIMIT 25;