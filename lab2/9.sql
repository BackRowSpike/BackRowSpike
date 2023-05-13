SELECT name FROM Company WHERE Company.[company id]
IN (SELECT DISTINCT CreditContract.[company id] FROM CreditContract WHERE [loan value] > 300000
INTERSECT
SELECT DISTINCT CreditContract.[company id] FROM CreditContract WHERE [percent] > 13);