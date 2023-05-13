SELECT name FROM Bank WHERE Bank.[bank id] NOT
IN (SELECT DISTINCT CreditContract.[bank id] FROM CreditContract);