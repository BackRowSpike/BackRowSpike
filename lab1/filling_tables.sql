CREATE DATABASE ShortTermLoans;

USE ShortTermLoans;

CREATE TABLE Bank ([bank id] int NOT NULL PRIMARY KEY IDENTITY(1,1),
             name nvarchar(50) NOT NULL);

CREATE TABLE Company ([company id] int NOT NULL PRIMARY KEY IDENTITY(1,1),
             name nvarchar(50) NOT NULL);

CREATE TABLE CreditContract ([contract number] int NOT NULL PRIMARY KEY IDENTITY(10001,1),
			[bank id] int NOT NULL,
			[company id] int NOT NULL,
			[contract code] nvarchar(6) NOT NULL,
			[loan value] money NOT NULL,
			[loan balance] money  NOT NULL,
			[percent] float  NOT NULL,
			[repayment period] tinyint  NOT NULL,
			[remaining payments] tinyint  NOT NULL);

ALTER TABLE CreditContract ADD CONSTRAINT [FK_CreditContract_Bank] FOREIGN KEY([bank id])
REFERENCES Bank([bank id]);

ALTER TABLE CreditContract ADD CONSTRAINT [FK_CreditContract_Company] FOREIGN KEY([company id])
REFERENCES Company([company id]);

ALTER TABLE CreditContract ADD CONSTRAINT [CK_CreditContract_Contract_Code] 
CHECK([contract code] like '[A-Z][A-Z][A-Z][0-9][0-9][0-9]');

ALTER TABLE CreditContract ADD CONSTRAINT [CK_CreditContract_Loan_Balance] 
CHECK([loan balance]>=0 AND [loan balance]<=[loan value]*(1+([repayment period]*[percent])/1200));

ALTER TABLE CreditContract ADD CONSTRAINT [CK_CreditContract_Loan_Value] 
CHECK([loan value]>=1000 AND [loan value]<=1000000);

ALTER TABLE CreditContract ADD CONSTRAINT [CK_CreditContract_Percent] 
CHECK([percent]>=10.5 AND [percent]<=100);

ALTER TABLE CreditContract ADD CONSTRAINT [CK_CreditContract_Repayment_Period] 
CHECK([repayment period]>=1 AND [repayment period]<=12);

ALTER TABLE CreditContract ADD CONSTRAINT [CK_CreditContract_Remaining_Payments] 
CHECK([remaining payments]>=0 AND [remaining payments]<=[repayment period]);

INSERT INTO Company(name) VALUES ('Apple Inc.');
INSERT INTO Company(name) VALUES ('Amazon.com Inc.');
INSERT INTO Company(name) VALUES ('Microsoft Corp.');
INSERT INTO Company(name) VALUES ('Tesla Inc.');
INSERT INTO Company(name) VALUES ('Alphabet Inc.');
INSERT INTO Company(name) VALUES ('Saudi Aramco Oil Group');
INSERT INTO Company(name) VALUES ('Berkshire Hathaway Inc.');
INSERT INTO Company(name) VALUES ('UnitedHealth Group');
INSERT INTO Company(name) VALUES ('Johnson & Johnson');
INSERT INTO Company(name) VALUES ('Visa');

INSERT INTO Bank(name) VALUES ('Bank of America');
INSERT INTO Bank(name) VALUES ('JPMorgan Chase');
INSERT INTO Bank(name) VALUES ('HSBC');
INSERT INTO Bank(name) VALUES ('Bank of China');
INSERT INTO Bank(name) VALUES ('BNP Paribas');
INSERT INTO Bank(name) VALUES ('Industrial and Commercial Bank of China Limited');
INSERT INTO Bank(name) VALUES ('China Construction Bank');
INSERT INTO Bank(name) VALUES ('Agricultural Bank of China');
INSERT INTO Bank(name) VALUES ('Mitsubishi UFJ Financial Group');
INSERT INTO Bank(name) VALUES ('Credit Agricole');

DECLARE @i INTEGER;
DECLARE @loanvalue FLOAT;
DECLARE @repaymentperiod TINYINT;
SET @i = 0;
WHILE @i < 10
BEGIN
	SET @loanvalue = 1000*(FLOOR(1+999*RAND()));
	SET @repaymentperiod = 1 + FLOOR(RAND()*11);
	INSERT INTO CreditContract([bank id], [company id], [contract code], [loan value], [loan balance], [percent], [repayment period], [remaining payments])
	VALUES (1+FLOOR(RAND()*10),
	1+FLOOR(RAND()*10), 
	CHAR(65+FLOOR(RAND()*26)) + CHAR(65+FLOOR(RAND()*26)) + CHAR(65+FLOOR(RAND()*26)) + CHAR(48+FLOOR(RAND()*10)) + CHAR(48+FLOOR(RAND()*10)) + CHAR(48+FLOOR(RAND()*10)),
	@loanvalue,
	@loanvalue*(1.1 - (FLOOR(RAND()*20))/20),
	(FLOOR(210 + RAND()*90))/20,
	@repaymentperiod,
	@repaymentperiod - FLOOR(RAND()*@repaymentperiod));
	SET @i = @i + 1;
END;
