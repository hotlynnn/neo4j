MATCH (a :Course)-->(b)
WITH  a.title AS title, MAX(a.price) AS max_price, SUM(a.price) AS price_sum, COLLECT(a.price) AS price_list
RETURN price_sum, price_list, REDUCE(totalprice=0, price in price_list | totalprice + price) AS reduce_price