SELECT StockCode,
COUNT(DISTINCT CustomerID) as "number of customers", SUM(Quantity*UnitPrice)"revenue",
COUNT(distinct Invoiceno) "no of visits/Transactions", avg(UnitPrice) as 'avg product price'
FROM tran GROUP by stockcode
