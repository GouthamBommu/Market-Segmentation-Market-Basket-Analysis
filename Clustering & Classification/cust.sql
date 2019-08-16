SELECT
CustomerID,
sum(Quantity*UnitPrice) as TotalPurchase,
count(distinct StockCode) as NoDistProductsBought,
count(StockCode) as NoProductsBought,
count(distinct Invoiceno) as NoDistTransactions,
DATEDIFF(max(InvoiceDateTime), min(InvoiceDateTime))/count(distinct Invoiceno)as gapbetweentransactions
FROM tran
GROUP BY CustomerID ;
