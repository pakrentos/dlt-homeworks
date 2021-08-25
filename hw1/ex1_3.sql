CREATE TABLE "Accounts" (
	"id"	INTEGER,
	"name"	TEXT,
	"credit"	REAL,
	"BankName" Text,
	PRIMARY KEY("id")
);


CREATE TABLE "Ledger" (
	"id"	INTEGER,
	"from_id"	INTEGER,
	"to_id"	INTEGER,
	"fee"	REAL,
	"amount"	REAL,
	"TransactionDateTime"	TEXT,
	PRIMARY KEY("id")
);

INSERT INTO "main"."Ledger"("id","from_id", "to_id", "fee", "amount", "TransactionDateTime") VALUES (1, 1, 3, 0.0, 500.0, NULL);
INSERT INTO "main"."Ledger"("id","from_id", "to_id", "fee", "amount", "TransactionDateTime") VALUES (1, 2, 1, 30.0, 700.0, NULL);
INSERT INTO "main"."Ledger"("id","from_id", "to_id", "fee", "amount", "TransactionDateTime") VALUES (1, 2, 3, 30.0, 100.0, NULL);

select * from Ledger;