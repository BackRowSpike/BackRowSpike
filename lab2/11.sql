CREATE TABLE BankAccount ([account number] nvarchar(50) NOT NULL PRIMARY KEY, [loan balance] float NOT NULL);
ALTER TABLE BankAccount ADD CONSTRAINT FK_BankAccount_Loan_Balance CHECK([loan balance] between 0
and 1000000);