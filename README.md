# 🐘 Online kurz PostgreSQL
Materiály k online kurzu PostgreSQL

## Zoznam základných PostgreSQL príkazov s vysvetleniami

Tu je zoznam základných PostgreSQL príkazov s konkrétnymi vysvetleniami:

**1. 🌟 CREATE DATABASE** – Vytvorenie novej databázy.

```sql
CREATE DATABASE moja_databaza;
```

Tento príkaz vytvorí novú databázu s názvom `moja_databaza`.

---

**2. 🗑️ DROP DATABASE** – Odstránenie existujúcej databázy.

```sql
DROP DATABASE moja_databaza;
```

Tento príkaz odstráni databázu s názvom `moja_databaza`.

---

**3. 🏗️ CREATE TABLE** – Vytvorenie novej tabuľky.

```sql
CREATE TABLE studenti (
    id SERIAL PRIMARY KEY,
    meno VARCHAR(50),
    vek INT
);
```

Tento príkaz vytvorí tabuľku `studenti` so stĺpcami `id`, `meno` a `vek`.

---

**4. 🧹 DROP TABLE** – Odstránenie tabuľky.

```sql
DROP TABLE studenti;
```

Tento príkaz odstráni tabuľku `studenti` spolu so všetkými jej údajmi.

---

**5. 🛠️ ALTER TABLE** – Úprava štruktúry tabuľky.

```sql
ALTER TABLE studenti ADD COLUMN email VARCHAR(100);
```

Tento príkaz pridá nový stĺpec `email` do tabuľky `studenti`.

---

**6. ✉️ INSERT INTO** – Vloženie údajov do tabuľky.

```sql
INSERT INTO studenti (meno, vek) VALUES ('Ján', 22);
```

Tento príkaz pridá nový riadok s údajmi `meno = Ján` a `vek = 22` do tabuľky `studenti`.

---

**7. 🔍 SELECT** – Výber údajov z tabuľky.

```sql
SELECT * FROM studenti;
```

Tento príkaz vyberie všetky údaje z tabuľky `studenti`.

---

**8. ✏️ UPDATE** – Aktualizácia údajov v tabuľke.

```sql
UPDATE studenti SET vek = 23 WHERE meno = 'Ján';
```

Tento príkaz aktualizuje vek na `23` pre študenta s menom `Ján`.

---

**9. ❌ DELETE FROM** – Odstránenie údajov z tabuľky.

```sql
DELETE FROM studenti WHERE meno = 'Ján';
```

Tento príkaz odstráni všetky riadky, kde je `meno = Ján`.

---

**10. 📈 CREATE INDEX** – Vytvorenie indexu pre zrýchlenie vyhľadávania.

```sql
CREATE INDEX idx_meno ON studenti(meno);
```

Tento príkaz vytvorí index pre stĺpec `meno` v tabuľke `studenti`.

---

**11. 🗑️ DROP INDEX** – Odstránenie indexu.

```sql
DROP INDEX idx_meno;
```

Tento príkaz odstráni index `idx_meno`.

---

**12. 🔑 GRANT** – Pridelenie prístupových práv.

```sql
GRANT SELECT ON studenti TO pouzivatel;
```

Tento príkaz pridelí práva na čítanie tabuľky `studenti` používateľovi `pouzivatel`.

---

**13. 🔒 REVOKE** – Odobratie prístupových práv.

```sql
REVOKE SELECT ON studenti FROM pouzivatel;
```

Tento príkaz odoberie práva na čítanie tabuľky `studenti` používateľovi `pouzivatel`.

---

**14. 🕒 BEGIN** – Začiatok transakcie.

```sql
BEGIN;
```

Tento príkaz začne transakciu.

---

**15. ✅ COMMIT** – Potvrdenie transakcie.

```sql
COMMIT;
```

Tento príkaz uloží zmeny vykonané v transakcii.

---

**16. 🔄 ROLLBACK** – Zrušenie transakcie.

```sql
ROLLBACK;
```

Tento príkaz zruší všetky zmeny vykonané v aktuálnej transakcii.

---

**17. 👤 CREATE USER** – Vytvorenie nového používateľa.

```sql
CREATE USER novy_pouzivatel WITH PASSWORD 'heslo';
```

Tento príkaz vytvorí nového používateľa `novy_pouzivatel` s heslom `heslo`.

---

**18. 🗑️ DROP USER** – Odstránenie používateľa.

```sql
DROP USER novy_pouzivatel;
```

Tento príkaz odstráni používateľa `novy_pouzivatel`.

---

**19. 🛠️ EXPLAIN** – Zobrazenie vykonávacieho plánu dopytu.

```sql
EXPLAIN SELECT * FROM studenti WHERE vek > 20;
```

Tento príkaz zobrazí plán vykonávania dopytu.

---

**20. 🧹 VACUUM** – Vyčistenie databázy.

```sql
VACUUM;
```

Tento príkaz vyčistí a optimalizuje databázu.

---

**21. 📜 LISTEN** – Čakanie na notifikácie.

```sql
LISTEN novinky;
```

Tento príkaz nastaví príkaz na čakanie notifikácií s názvom `novinky`.

---

**22. 📢 NOTIFY** – Odoslanie notifikácie.

```sql
NOTIFY novinky, 'Nový študent bol pridaný!';
```

Tento príkaz odošle notifikáciu s názvom `novinky` a správou `'Nový študent bol pridaný!'`.
