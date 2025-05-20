# 🐘 Online kurzy PostgreSQL
Materiály k online kurzom PostgreSQL

01. [**🤖 Zoznam Metapríkazov PostgreSQL**](https://github.com/miroslav-reiter/PostgreSQL/blob/main/README.md#zoznam-meta-prikazov)
02. [**🛠️ Zoznam základných PostgreSQL príkazov**](https://github.com/miroslav-reiter/PostgreSQL/blob/main/README.md#zoznam-zakladnych-prikazov-postgresql)
03. [**👮 Zoznam PostgreSQL DBA príkazov - Používatelia a Práva**](https://github.com/miroslav-reiter/PostgreSQL/blob/main/README.md#zoznam-prikazov-dba-pouzivatelia)
04. [**⭐ Prehľad PostgreSQL privilégia používateľov**](https://github.com/miroslav-reiter/PostgreSQL/blob/main/README.md#privilegia-postgresql)
05. [**🐧 Inštalácia Linux pgAdmin**](https://github.com/miroslav-reiter/PostgreSQL/blob/main/README.md#instalacia-linux-pgadmin)

<a name="zoznam-meta-prikazov"></a>  
## 🤖 Zoznam Metapríkazov PostgreSQL s vysvetleniami
| N  |   Metapríkaz  |                                    Popis                                   |
|----|:-------------:|:--------------------------------------------------------------------------:|
| 1  | **\l**            | Zobrazenie zoznamu všetkých databáz.                                       |
| 2  | **\c [databáza]** | Prepnutie na inú databázu.                                                 |
| 3  | **\dt**          | Zobrazenie zoznamu všetkých tabuliek v aktuálnej schéme.                   |
| 4  | **\d [tabuľka]** | Zobrazenie štruktúry konkrétnej tabuľky (stĺpce, typy, indexy).            |
| 5  |**\dn**          | Zobrazenie zoznamu schém v aktuálnej databáze.                             |
| 6  | **\di**          | Zobrazenie zoznamu indexov v aktuálnej schéme.                             |
| 7  |**\dv**          | Zobrazenie zoznamu pohľadov (views) v aktuálnej schéme.                    |
| 8  | **\du**          | Zobrazenie zoznamu používateľov a ich rolí.                                  |
| 9  | **\df**          | Zobrazenie zoznamu funkcií definovaných v databáze.                        |
| 10 | **\pset**        | Nastavenie formátovania výstupu (napr. \pset border 2 pridá orámovanie).   |
| 11 | **\q**            | Ukončenie relácie psql (vystúpenie z PostgreSQL interaktívneho terminálu). |
| 12 | **\timing**       | Zapnutie alebo vypnutie zobrazovania času vykonávania SQL príkazov.        |

Detailnejšie vysvetlenie:
1. **\l** – Tento príkaz vypíše všetky dostupné databázy v rámci inštancie PostgreSQL.  
1. **\c [databáza]** – Umožňuje prepnúť sa do inej databázy, ktorú chcete spravovať.    
1. **\dt** – Zobrazí všetky tabuľky v aktuálnej schéme (public schéma, ak nie je špecifikované inak).    
1. **\d [tabuľka]** – Poskytne detailné informácie o štruktúre tabuľky, ako sú stĺpce, dátové typy, indexy, a ďalšie.    
1. **\dn** – Umožňuje získať prehľad o všetkých schémach dostupných v databáze.    
1. **\di** – Zobrazuje existujúce indexy, čo je užitočné pri optimalizácii výkonu databázy.  
1. **\dv** – Pomocou tohto príkazu získate zoznam definovaných pohľadov (views).  
1. **\du** – Tento príkaz zobrazuje všetkých používateľov a ich priradené role.  
1. **\df** – Slúži na zoznam všetkých funkcií uložených v databáze, či už systémových alebo používateľských.  
1. **\pset** – Upravuje, ako sa údaje zobrazujú, napr. pridanie orámovania tabuliek.  
1. **\q** – Rýchle ukončenie relácie psql.  
1. **\timing** – Aktivuje zobrazovanie času, ktorý PostgreSQL potrebuje na vykonanie príkazov.  

Tieto metapríkazy sú ideálne na navigáciu a rýchle vykonávanie často potrebných akcií v PostgreSQL!  

<a name="zoznam-zakladnych-prikazov-postgresql"></a>
## 🛠️ Zoznam základných PostgreSQL príkazov s vysvetleniami

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

<a name="zoznam-prikazov-dba-pouzivatelia></a>
## 👮 Zoznam PostgreSQL DBA príkazov - Používatelia a Práva s vysvetleniami
**1. ✨ CREATE USER** – Vytvorenie nového používateľa.

```sql
CREATE USER novy_pouzivatel WITH PASSWORD 'silneheslo';
```

Tento príkaz vytvorí nového používateľa s menom `novy_pouzivatel` a heslom `silneheslo`.

---

**2. 🔓 GRANT CONNECT ON DATABASE** – Priradenie prístupu na databázu.

```sql
GRANT CONNECT ON DATABASE mojadb TO novy_pouzivatel;
```

Tento príkaz umožní používateľovi `novy_pouzivatel` pripojenie k databáze `mojadb`.

---

**3. 🛡️ CREATE ROLE** – Vytvorenie roly s právami.

```sql
CREATE ROLE junior;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO junior;
```

Tento príkaz vytvorí rolu `junior`, ktorá má právo čítať všetky tabuľky v schéme `public`.

---

**4. 🛡️ GRANT ROLE** – Priradenie roly používateľovi.

```sql
GRANT junior TO novy_pouzivatel;
```

Tento príkaz priradí rolu `junior` používateľovi `novy_pouzivatel`.

---

**5. 🚫 REVOKE PRIVILEGES** – Obmedzenie prístupových práv.

```sql
REVOKE INSERT ON TABLE zamestnanci FROM novy_pouzivatel;
```

Tento príkaz zruší právo vkladať údaje do tabuľky `zamestnanci` pre používateľa `novy_pouzivatel`.

---

**6. 🔑 ALTER OWNER** – Nastavenie vlastníctva tabuľky.

```sql
ALTER TABLE zamestnanci OWNER TO novy_pouzivatel;
```

Tento príkaz prenesie vlastníctvo tabuľky `zamestnanci` na používateľa `novy_pouzivatel`.

---

**7. 🗑️ DROP USER** – Odstránenie používateľa.

```sql
DROP USER novy_pouzivatel;
```

Tento príkaz odstráni používateľa `novy_pouzivatel`. Predtým musia byť odstránené všetky jeho závislosti.

<a name="privilegia-postgresql"></a>
⭐ Prehľad PostgreSQL privilégia používateľov s vysvetleniami
Každé z týchto nastavení má svoje špecifické použitie v rôznych scenároch správy PostgreSQL databáz.

**1. Can login?:** Povolenie na prihlásenie používateľa. Ak je toto začiarknuté, účet sa môže použiť na prihlásenie do databázy. Ak nie je začiarknuté, používateľ môže byť len rola na delegovanie práv.  
**2. Superuser?:** Superužívateľ má neobmedzené privilégiá v databáze PostgreSQL, čo znamená, že môže robiť akékoľvek operácie vrátane vytvárania databáz, manipulácie so všetkými tabuľkami a vykonávania akcií bez obmedzenia práv.  
**3. Create roles?:** Toto oprávnenie umožňuje danému používateľovi vytvárať nové role alebo upravovať existujúce role. Ak to nie je začiarknuté, používateľ nemá možnosť meniť roly.  
**4. Create databases?:** Umožňuje používateľovi vytvárať nové databázy. Toto je dôležité oprávnenie pre administrátorov alebo vývojárov, ktorí potrebujú vytvoriť nové prostredia na prácu.  
**5. Inherit rights from the parent roles?:** Ak je začiarknuté, táto rola alebo používateľ bude automaticky dediť všetky práva, ktoré má nadradená rola. Ak nie je začiarknuté, dedenie nie je možné a práva musia byť udelené explicitne.  
**6. Can initiate streaming replication and backups?:** Umožňuje používateľovi spustiť streaming replication (replikácia dát v reálnom čase medzi dvoma PostgreSQL servermi) alebo vykonávať zálohovacie procesy. Toto oprávnenie sa zvyčajne udeľuje správcom servera.  
**7. Bypass RLS? (Row-Level Security):** Ak je začiarknuté, používateľ môže obísť Row-Level Security pravidlá. Toto oprávnenie je citlivé, pretože RLS zabezpečuje, aby používatelia mali prístup len k určitým riadkom v tabuľkách, podľa definovaných politík. Toto oprávnenie umožňuje používateľovi ignorovať tieto pravidlá a vidieť všetky dáta.  

![postgresql-privilegia](https://github.com/user-attachments/assets/9827e4e8-59ca-45ac-81a2-32d45636c482)

<a name="instalacia-linux-pgadmin"></a>
## 🐧 Inštalácia Linux pgAdmin
**1. Importujte GPG kľúč pre úložisko:**  
```bash
curl -fsSL https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo tee /etc/apt/trusted.gpg.d/pgadmin.asc  
curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add -  
```

**2. Pridajte úložisko do vášho systému:**
```bash
echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" | sudo tee /etc/apt/sources.list.d/pgadmin4.list && sudo apt update  
```

**3. Nainštalujte pgAdmin**
```bash
sudo apt install pgadmin4-desktop  
sudo snap install pgadmin4  
pgadmin4
```
sudo apt install pgadmin4-web
http://127.0.0.1/pgadmin4


