SELECT *FROM Bank LEFT JOIN CreditContract
ON Bank.[bank id] = CreditContract.[bank id];