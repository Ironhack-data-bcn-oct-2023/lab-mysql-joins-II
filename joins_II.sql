-- Challenge 1 - Who Have Published What At Where?

select a.au_id AUTHOR_ID, a.au_lname LAST_NAME, a.au_fname FIRST_NAME, t.TITLE, p.pub_name PUBLISHER

from publishers p

join titles t on p.pub_id = t.pub_id
join titleauthor ta on t.title_id = ta.title_id
join authors a on ta.au_id = a.au_id
order by a.au_id;



-- Challenge 2 - Who Have Published How Many At Where?
select a.au_id AUTHOR_ID, a.au_lname LAST_NAME, a.au_fname FIRST_NAME, p.pub_name PUBLISHER, count(t.title) as TITLE_COUNT

from publishers p

join titles t on p.pub_id = t.pub_id
join titleauthor ta on t.title_id = ta.title_id
join authors a on ta.au_id = a.au_id
group by AUTHOR_ID, LAST_NAME, FIRST_NAME, PUBLISHER
order by a.au_id desc;

-- Challenge 3 - Best Selling Authors

SELECT 
    a.au_id AUTHOR_ID,
    a.au_lname LAST_NAME,
    a.au_fname FIRST_NAME,
    MAX(s.qty) TOTAL
FROM
    titles t
        JOIN
    sales s ON s.title_id = t.title_id
        JOIN
    titleauthor ta ON t.title_id = ta.title_id
        JOIN
    authors a ON ta.au_id = a.au_id
GROUP BY AUTHOR_ID , LAST_NAME , FIRST_NAME
ORDER BY TOTAL DESC
LIMIT 3;



-- Challenge 4 - Best Selling Authors Ranking

SELECT 
    a.au_id AUTHOR_ID,
    a.au_lname LAST_NAME,
    a.au_fname FIRST_NAME,
    COALESCE(MAX(s.qty), 0) TOTAL
FROM
    titles t
        JOIN
    sales s ON s.title_id = t.title_id
        JOIN
    titleauthor ta ON t.title_id = ta.title_id
        RIGHT JOIN
    authors a ON ta.au_id = a.au_id
GROUP BY AUTHOR_ID , LAST_NAME , FIRST_NAME
ORDER BY total DESC;