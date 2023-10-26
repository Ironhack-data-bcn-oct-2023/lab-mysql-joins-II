use publications;

-- Challenge 1 - Who Have Published What At Where?
	-- In this challenge you will write a MySQL SELECT query that joins various tables to figure out what titles each author 
	-- has published at which publishers. Your output should have at least the following columns:
		-- AUTHOR ID - the ID of the author
		-- LAST NAME - author last name
		-- FIRST NAME - author first name
		-- TITLE - name of the published title
		-- PUBLISHER - name of the publisher where the title was published
		
	-- authors, titleauthor, titles, publishers
    select a.au_id as AUTHOR_ID, a.au_lname as LAST_NAME, a.au_fname as FIRST_NAME, t.title as TITLE, pub_name as PUBLISHER
    from authors as a
		join titleauthor as ta on a.au_id = ta.au_id
        join titles as t on ta.title_id = t.title_id
        join publishers as p on t.pub_id = p.pub_id;
        
-- Challenge 2 - Who Have Published How Many At Where?
	-- Elevating from your solution in Challenge 1, query how many titles each author has published at each publisher.

	-- authors, titleauthor, titles, publishers
    select a.au_id as `AUTHOR ID`, a.au_lname as `LAST NAME`, a.au_fname as `FIRST NAME`, pub_name as PUBLISHER, count(t.title) as `TITLE COUNT`
    from authors as a
		join titleauthor as ta on a.au_id = ta.au_id
        join titles as t on ta.title_id = t.title_id
        join publishers as p on t.pub_id = p.pub_id
	group by a.au_id, p.pub_name
    order by `TITLE COUNT` desc;
    
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

	-- authors, titleauthor, titles
	select a.au_id as `AUTHOR ID`, a.au_lname as `LAST NAME`, a.au_fname as `FIRST NAME`, sum(s.qty) as TOTAL
	from authors as a
		join titleauthor as ta on a.au_id = ta.au_id
		join titles as t on ta.title_id = t.title_id
        join sales as s on t.title_id = s.title_id
	group by a.au_id
	order by TOTAL desc limit 3;

-- Challenge 4 - Best Selling Authors Ranking
	-- Now modify your solution in Challenge 3 so that the output will display all 23 authors instead of the top 3.
	-- Note that the authors who have sold 0 titles should also appear in your output (ideally display 0 instead of NULL as
	-- the TOTAL). Also order your results based on TOTAL from high to low.
    
    select a.au_id as `AUTHOR ID`, a.au_lname as `LAST NAME`, a.au_fname as `FIRST NAME`, coalesce(sum(s.qty), 0) AS TOTAL
	from authors as a
		left join titleauthor as ta on a.au_id = ta.au_id
		left join titles as t on ta.title_id = t.title_id
        left join sales as s on t.title_id = s.title_id
	group by a.au_id
	order by TOTAL desc;
    
    select * from sales;