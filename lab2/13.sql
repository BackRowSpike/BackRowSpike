CREATE VIEW CompanyRemainingDebt AS
SELECT Company.name, [loan balance], [bank id], [remaining payments] FROM CreditContract INNER JOIN Company ON
CreditContract.[company id] = Company.[company id]
WHERE [loan value]<200000;