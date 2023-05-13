SELECT DISTINCT Company.[company id], name FROM Company LEFT JOIN CreditContract
ON Company.[company id] = CreditContract.[company id]
WHERE CreditContract.[loan balance] > 300000
ORDER BY name;