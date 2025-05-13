
# 🐘👁️ PostgreSQL Pohľady (Views): Praktické Úlohy a Skripty

Praktický sprievodca pre prácu s pohľadmi v PostgreSQL. Vhodné na výučbu, testovanie a projekty.

---

📌 **Úloha 1: Výpis všetkých pohľadov pomocou SQL dopytu**  
Zobrazí názvy a schémy všetkých pohľadov okrem systémových.

```sql
SELECT table_schema, table_name
FROM information_schema.views
WHERE table_schema NOT IN ('pg_catalog', 'information_schema');
```

Môžete doplniť filter napr. `WHERE table_schema = 'public'`.

---

📌 **Úloha 2: Výpis všetkých pohľadov pomocou metapríkazu v `psql`**  
Zobrazí všetky pohľady v aktuálnej schéme.

```psql
\dv
```

---

📌 **Úloha 3: Vytvoriť pohľad `zamestnanci_info`**  
Zobrazí len aktívnych zamestnancov so základnými údajmi.

```sql
CREATE VIEW zamestnanci_info AS
SELECT meno, priezvisko, oddelenie
FROM zamestnanci
WHERE aktivny = TRUE;
```

---

📌 **Úloha 4: Zamestnanci z oddelenia IT**  
Vytvorenie pohľadu len pre IT oddelenie.

```sql
CREATE VIEW zamestnanci_it AS
SELECT z.meno, z.priezvisko, z.email
FROM zamestnanci z
JOIN oddelenia o ON z.oddelenie_id = o.id
WHERE o.nazov = 'IT';
```

---

📌 **Úloha 5: Zobraziť údaje z pohľadu `zamestnanci_it`**  
Zobrazí všetkých IT zamestnancov s firemnými emailmi.

```sql
SELECT * FROM zamestnanci_it
WHERE email LIKE '%@firma.sk';
```

---

📌 **Úloha 6: Zložitejší pohľad s JOIN**  
Získanie prehľadu platov vrátane oddelenia.

```sql
CREATE VIEW prehlad_platov AS
SELECT z.meno, z.priezvisko, o.nazov AS oddelenie, p.suma
FROM zamestnanci z
JOIN oddelenia o ON z.oddelenie_id = o.id
JOIN platy p ON z.id = p.zamestnanec_id;
```

---

📌 **Úloha 7: Reštriktívny pohľad**  
Zobrazí len zamestnancov so stĺpcami meno a priezvisko, ak `zobrazit = TRUE`.

```sql
CREATE VIEW viditelni_zamestnanci AS
SELECT meno, priezvisko
FROM zamestnanci 
WHERE zobrazit = TRUE;
```

---

📌 **Úloha 8: Aktualizácia pohľadu**  
Pridanie ďalších stĺpcov do existujúceho pohľadu.

```sql
CREATE OR REPLACE VIEW zamestnanci_info AS
SELECT meno, priezvisko, oddelenie, email
FROM zamestnanci
WHERE aktivny = TRUE;
```

---

📌 **Úloha 9: Zrušenie pohľadu**  
Odstránenie pohľadu s kontrolou existencie.

```sql
DROP VIEW IF EXISTS zamestnanci_info;
```

---

📌 **Úloha 10: Rekurzívny pohľad (hierarchia)**  
Zobrazí podriadených zamestnancov v hierarchii.

```sql
DROP VIEW IF EXISTS hierarchia_zamestnancov;

CREATE OR REPLACE RECURSIVE VIEW hierarchia_zamestnancov(id, meno, nadriadeny_id, uroven) AS (
  SELECT id, meno, nadriadeny_id, 1
  FROM zamestnanci
  WHERE nadriadeny_id IS NULL
  UNION ALL
  SELECT z.id, z.meno, z.nadriadeny_id, h.uroven + 1
  FROM zamestnanci z
  JOIN hierarchia_zamestnancov h ON z.nadriadeny_id = h.id
);
```

---

📌 **Úloha 11: Aktualizovateľné pohľady**  
Zmeny údajov cez pohľad.

```sql
CREATE VIEW aktivni_zamestnanci AS
SELECT id, meno, priezvisko, email
FROM zamestnanci
WHERE aktivny = TRUE;

UPDATE aktivni_zamestnanci
SET email = 'novy@email.sk'
WHERE id = 123;
```

---

📌 **Úloha 12: Pohľady s kontrolou prístupu**  
Obmedzenie prístupu na čítanie pomocou pohľadu.

```sql
CREATE VIEW bezpecne_udaje AS
SELECT id, meno, priezvisko, oddelenie
FROM zamestnanci;

REVOKE ALL ON zamestnanci FROM PUBLIC;
GRANT SELECT ON bezpecne_udaje TO reporting_users;
```

---
