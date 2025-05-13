# 📘 PostgreSQL: Kompletný SQL setup – Zamestnanci, Oddelenia, Platy, RLS

Tento dokument obsahuje všetky základné skripty na vytvorenie schémy zamestnaneckej databázy, jej naplnenie dátami, bezpečnostné pohľady a politiky RLS. Každý skript je pripravený na okamžité spustenie.

---

📌 **Úloha: Vytvoriť tabuľku `oddelenia` a naplniť ju dátami**
```sql
DROP TABLE IF EXISTS oddelenia;
CREATE TABLE IF NOT EXISTS oddelenia (
    id INT PRIMARY KEY,
    nazov VARCHAR(50),
    mesto VARCHAR(50)
);

INSERT INTO oddelenia (id, nazov, mesto) VALUES
(1, 'IT', 'Košice'),
(2, 'Marketing', 'Košice'),
(3, 'HR', 'Bratislava'),
(4, 'Obchod', 'Košice'),
(5, 'Výskum', 'Nitra');
```

📌 **Úloha: Vytvoriť tabuľku `zamestnanci` s referenciou na `oddelenia`**
```sql
DROP TABLE IF EXISTS zamestnanci;
CREATE TABLE IF NOT EXISTS zamestnanci (
    id INT PRIMARY KEY,
    meno VARCHAR(50),
    priezvisko VARCHAR(50),
    email VARCHAR(100),
    oddelenie_id INT REFERENCES oddelenia(id),
    oddelenie VARCHAR(50),
    aktivny BOOLEAN,
    mzda NUMERIC(8,2),
    datum_nastupu DATE
);
```

📌 **Úloha: Pridať stĺpec `zobrazit` a `nadriadeny_id` do `zamestnanci`**
```sql
ALTER TABLE zamestnanci ADD COLUMN zobrazit BOOLEAN DEFAULT TRUE;
ALTER TABLE zamestnanci ADD COLUMN nadriadeny_id INT REFERENCES zamestnanci(id);
```

📌 **Úloha: Náhodne nastaviť zobraziteľnosť (80 % TRUE, 20 % FALSE)**
```sql
UPDATE zamestnanci
SET zobrazit = CASE
  WHEN RANDOM() < 0.8 THEN TRUE
  ELSE FALSE
END;
```

📌 **Úloha: Naplniť `nadriadeny_id` vzťahy v tabuľke zamestnanci**
```sql
UPDATE zamestnanci SET nadriadeny_id = NULL WHERE id = 1;
UPDATE zamestnanci SET nadriadeny_id = 1 WHERE id IN (2, 3);
UPDATE zamestnanci SET nadriadeny_id = 2 WHERE id = 4;
```

📌 **Úloha: Vytvoriť tabuľku `platy` a naplniť údajmi**
```sql
DROP TABLE IF EXISTS platy;
CREATE TABLE IF NOT EXISTS platy (
    id SERIAL PRIMARY KEY,
    zamestnanec_id INT REFERENCES zamestnanci(id),
    suma NUMERIC(8,2) NOT NULL,
    platnost_od DATE NOT NULL DEFAULT CURRENT_DATE
);
-- INSERT INTO platy ... (vynechané kvôli rozsahu, viď samostatný súbor)
```

📌 **Úloha: Vytvoriť tabuľku `dokumenty` pre RLS**
```sql
CREATE TABLE dokumenty (
  id SERIAL PRIMARY KEY,
  nazov TEXT,
  obsah TEXT,
  vlastnik TEXT
);
```

📌 **Úloha: Aktivovať RLS na tabuľke `dokumenty`**
```sql
ALTER TABLE dokumenty ENABLE ROW LEVEL SECURITY;
CREATE POLICY vlastne_dokumenty ON dokumenty
  USING (vlastnik = current_user);
```

📌 **Úloha: Vytvoriť pohľad s aplikáciou RLS**
```sql
CREATE VIEW moje_dokumenty AS
SELECT id, nazov, obsah FROM dokumenty;
```

📌 **Úloha: Vytvoriť rolu reporting_users (a voliteľne NOLOGIN variant)**
```sql
CREATE ROLE reporting_users;
-- Ak má byť len skupinová rola:
DROP ROLE reporting_users;
CREATE ROLE reporting_users NOLOGIN;
```

📌 **Úloha: Zobraziť členov roly `reporting_users`**
```sql
SELECT rolname
FROM pg_roles
WHERE oid IN (
  SELECT member
  FROM pg_auth_members
  WHERE roleid = (SELECT oid FROM pg_roles WHERE rolname = 'reporting_users')
);
```