SELECT [company id] FROM CreditContract 
GROUP BY [company id] 
HAVING COUNT(*) > 1;