CREATE TABLE "Accounts" (
	"id"	INTEGER,
	"name"	TEXT,
	"credit"	REAL,
	PRIMARY KEY("id")
);

INSERT INTO "main"."Accounts"("id","name","credit") VALUES (1,"Sas",1200.0);
INSERT INTO "main"."Accounts"("id","name","credit") VALUES (2,"Sos",200.0);
INSERT INTO "main"."Accounts"("id","name","credit") VALUES (3,"Sus",1600.0);

select id, name, credit from Accounts;