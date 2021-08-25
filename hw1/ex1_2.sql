CREATE TABLE "Accounts" (
	"id"	INTEGER,
	"name"	TEXT,
	"credit"	REAL,
	"BankName" Text,
	PRIMARY KEY("id")
);

INSERT INTO "main"."Accounts"("id","name","credit") VALUES (1,"Sas",1200.0, "SpearBank");
INSERT INTO "main"."Accounts"("id","name","credit") VALUES (2,"Sos",200.0, "Tinkoff");
INSERT INTO "main"."Accounts"("id","name","credit") VALUES (3,"Sus",1600.0, "SpearBank");
INSERT INTO "main"."Accounts"("id","name","credit") VALUES (4,"Fees",60.0, NULL);

select id, name, credit, BankName from Accounts;