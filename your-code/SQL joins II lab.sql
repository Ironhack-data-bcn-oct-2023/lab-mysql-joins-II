use publications;
-- 1

SELECT authors.au_id, au_fname, au_lname, titleauthor.title_id, titles.title, publishers.pub_id, publishers.pub_name from authors
JOIN titleauthor ON titleauthor.au_id = authors.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN publishers on titles.pub_id = publishers.pub_id;

-- 2
SELECT authors.au_id, au_lname, au_fname, publishers.pub_name, count(titles.title) as Book_Count
FROM authors
JOIN titleauthor ON titleauthor.au_id = authors.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN publishers on titles.pub_id = publishers.pub_id
GROUP BY authors.au_id, au_lname, au_fname, publishers.pub_name
ORDER BY authors.au_id DESC;



select sum(Book_Count) as Total_Books
FROM (
SELECT authors.au_id, au_lname, au_fname, publishers.pub_name, count(titles.title) as Book_Count
FROM authors
JOIN titleauthor ON titleauthor.au_id = authors.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN publishers on titles.pub_id = publishers.pub_id
GROUP BY authors.au_id, au_lname, au_fname, publishers.pub_name
ORDER BY authors.au_id DESC) AS Subquery;

-- 25 total Book Count

-- 3

SELECT authors.au_id, au_lname, au_fname, sum(sales.qty) as Total_Titles_Sold from authors
JOIN titleauthor ON titleauthor.au_id = authors.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN sales ON titles.title_id = sales.title_id
GROUP BY authors.au_id, au_lname, au_fname
ORDER BY Total_Titles_Sold  DESC
limit 3;

-- 4

SELECT authors.au_id, au_lname, au_fname, COALESCE(SUM(sales.qty), 0) as Total_Titles_Sold from authors
	left join titleauthor on titleauthor.au_id = authors.au_id
    left join sales on sales.title_id = titleauthor.title_id
GROUP BY authors.au_id, au_lname, au_fname
ORDER BY Total_Titles_Sold  DESC;





