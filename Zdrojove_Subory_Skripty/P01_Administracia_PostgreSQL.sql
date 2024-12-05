-- Zoznam všetkých databáz (\l)
SELECT
	DATNAME AS "Databáza"
FROM
	PG_DATABASE
WHERE
	DATISTEMPLATE = FALSE
	
-- Zoznam všetkých tabuliek (\dt + \dn)
SELECT

SCHEMANAME AS "Schéma",
	TABLENAME AS "Tabuľka"
FROM
	PG_TABLES;

-- Zoznam všetkých používateľov (\du)
SELECT
	ROLNAME AS "Používateľ",
	ROLSUPER AS "Superuser",
	ROLCANLOGIN AS "Môže sa prihlásiť"
FROM
	PG_ROLES;
	
	
--------------------------------------------------
	
-- Zoznam všetkých databáz (metapríkaz \l)
SELECT datname AS "Databáza"
FROM pg_database
WHERE datistemplate = false;

-- Zoznam všetkých používateľov (metapríkaz \du)
SELECT rolname AS "Používateľ", rolsuper AS "Superuser", rolcanlogin AS "Môže sa prihlásiť"
FROM pg_roles;

-- Zoznam všetkých tabuliek (metapríkaz \dt + \dn)
SELECT schemaname AS "Schéma", tablename AS "Tabuľka"
FROM pg_tables;
