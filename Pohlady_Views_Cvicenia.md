
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

🧠 **Vysvetlenie:**  
- `information_schema.views` je systémový pohľad obsahujúci zoznam všetkých definovaných SQL pohľadov.  
- `table_schema` označuje názov schémy, napr. `public`.  
- `table_name` obsahuje názov konkrétneho pohľadu.  
- Podmienka `NOT IN (...)` filtruje systémové schémy, ktoré nechceme zobrazovať.  
- Možno pridať `WHERE table_schema = 'public'` pre výpis len vlastných pohľadov.

---

📌 **Úloha 2: Výpis všetkých pohľadov pomocou metapríkazu v `psql`**  
Zobrazí všetky pohľady v aktuálnej schéme.

```psql
\dv
```
🧠 **Vysvetlenie:**  
- `\dv` je metapríkaz nástroja `psql`, ktorý zobrazí zoznam všetkých pohľadov v aktuálne zvolenej databáze a schéme.  
- Rýchly spôsob kontroly, aké pohľady existujú, bez potreby SQL.

---

📌 **Úloha 3: Vytvoriť pohľad `zamestnanci_info`**  
Zobrazí len aktívnych zamestnancov so základnými údajmi.

```sql
CREATE VIEW zamestnanci_info AS
SELECT meno, priezvisko, oddelenie
FROM zamestnanci
WHERE aktivny = TRUE;
```

🧠 **Vysvetlenie:**  
- `CREATE VIEW` definuje nový pohľad v databáze, ktorý sa správa ako "virtuálna tabuľka".  
- Tento pohľad vracia len stĺpce `meno`, `priezvisko`, `oddelenie`.  
- `WHERE aktivny = TRUE` zabezpečí, že vo výsledku budú len zamestnanci, ktorí sú aktuálne aktívni.

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

🧠 **Vysvetlenie:**  
- V tomto prípade používame `JOIN` medzi tabuľkami `zamestnanci` a `oddelenia`.  
- Spojenie je cez cudzie kľúče: `z.oddelenie_id = o.id`.  
- Podmienka `WHERE o.nazov = 'IT'` zabezpečí, že sa zobrazia len zamestnanci pracujúci v oddelení "IT".  
- Výsledkom je pohľad s menom, priezviskom a e-mailom zamestnancov IT oddelenia.

---

📌 **Úloha 5: Zobraziť údaje z pohľadu `zamestnanci_it`**  
Zobrazí všetkých IT zamestnancov s firemnými emailmi.

```sql
SELECT * FROM zamestnanci_it
WHERE email LIKE '%@firma.sk';
```
🧠 **Vysvetlenie:**
- Tento SQL dopyt vyberá všetky stĺpce z pohľadu zamestnanci_it, ktorý obsahuje len zamestnancov z IT oddelenia.
- Príkaz LIKE '%@firma.sk' zabezpečí, že sa vyfiltrujú len tí zamestnanci, ktorých e-mailová adresa končí na @firma.sk.


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

🧠 **Vysvetlenie:**
- Tento pohľad spája 3 tabuľky: zamestnanci, oddelenia a platy.
- Pomocou JOIN sa pripoja údaje o zamestnancoch, ich oddeleniach a výške platu.
- Použitie aliasov (z, o, p) zjednodušuje zápis. Stĺpec o.nazov AS oddelenie priraďuje alias názvu oddelenia.

---

📌 **Úloha 7: Reštriktívny pohľad**  
Zobrazí len zamestnancov so stĺpcami meno a priezvisko, ak `zobrazit = TRUE`.

```sql
CREATE VIEW viditelni_zamestnanci AS
SELECT meno, priezvisko
FROM zamestnanci 
WHERE zobrazit = TRUE;
```

🧠 **Vysvetlenie:**
- Tento pohľad obmedzuje výstup len na stĺpce meno a priezvisko.
- Podmienka WHERE zobrazit = TRUE zabezpečí, že sa zobrazia len zamestnanci, ktorí majú povolené byť zobrazení (napr. na webe alebo v reportoch).

---

📌 **Úloha 8: Aktualizácia pohľadu**  
Pridanie ďalších stĺpcov do existujúceho pohľadu.

```sql
CREATE OR REPLACE VIEW zamestnanci_info AS
SELECT meno, priezvisko, oddelenie, email
FROM zamestnanci
WHERE aktivny = TRUE;
```

🧠 **Vysvetlenie:**
- CREATE OR REPLACE VIEW aktualizuje existujúci pohľad bez nutnosti ho najprv zrušiť.
- Pridávame nový stĺpec email do výstupu a zároveň zachovávame filtrovanie len na aktívnych zamestnancov pomocou WHERE aktivny = TRUE.

---

📌 **Úloha 9: Zrušenie pohľadu**  
Odstránenie pohľadu s kontrolou existencie.

```sql
DROP VIEW IF EXISTS zamestnanci_info;
```

**🧠 Vysvetlenie:**
- Príkaz DROP VIEW odstráni pohľad z databázy.
- Pridaním IF EXISTS zabezpečíme, že nevznikne chyba, ak pohľad neexistuje – v takom prípade sa príkaz jednoducho neuskutoční.

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
🧠 **Vysvetlenie**:
- Tento rekurzívny pohľad vytvára hierarchiu zamestnancov podľa nadriadeného.
- Prvá časť SELECT ... WHERE nadriadeny_id IS NULL vyberie všetkých vrcholových zamestnancov.
- UNION ALL rekurzívne pridáva podriadených zamestnancov k ich nadriadeným.
- Stĺpec uroven označuje úroveň v hierarchii (1 = najvyššia).

RECURSIVE VIEW vyžaduje PostgreSQL verziu 14+.
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

🧠 **Vysvetlenie:**
- Tento pohľad obsahuje len aktívnych zamestnancov.
- Keďže výber je jednoduchý (žiadne JOIN, funkcie ani agregácie), PostgreSQL umožňuje pohľad aktualizovať.
- Príkaz UPDATE mení hodnotu stĺpca email pre zamestnanca s id = 123.
- Pohľad smeruje zmenu priamo do podkladovej tabuľky zamestnanci.

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
🧠 **Vysvetlenie:**
- Pohľad bezpecne_udaje zobrazuje iba vybrané stĺpce zo zamestnancov (bez e-mailu, mzdy atď.).
- REVOKE ALL odoberie všetky práva zo základnej tabuľky pre verejnosť (neautorizovaní používatelia).
- GRANT SELECT pridelí prístup len na pohľad, čím sa zabezpečí kontrolovaný prístup.
- Toto je bežný spôsob, ako pomocou pohľadu vytvoriť „bezpečnostnú vrstvu“ v databáze.
---
