
# 📘 PostgreSQL: Pohľady a Materiálové pohľady

Materiály k online kurzom PostgreSQL so zameraním na VIEW a MATERIALIZED VIEW.

### B1 [👁️ Zoznam VIEW príkazov a odporúčaní](#zoznam-view-prikazov)
### B2 [🗃️ Porovnanie TABLE vs VIEW vs MATERIALIZED VIEW](#porovnanie-view-materialized)
### B3 [🔐 RLS a pohľady: bezpečnostné modely](#rls-a-pohlady)

---

<a name="zoznam-view-prikazov"></a>
## 👁️ Zoznam VIEW príkazov a odporúčaní

```sql
CREATE [ OR REPLACE ] [ TEMP | TEMPORARY ] [ RECURSIVE ] VIEW nazov_view [ ( stlpec1, stlpec2, ... ) ]
[ WITH ( security_barrier = true ) ]
AS SELECT ...
[ WITH [ CASCADED | LOCAL ] CHECK OPTION ];
```

**Vysvetlenie volieb:**

| Parameter                  | Popis                                                                 |
|---------------------------|------------------------------------------------------------------------|
| `OR REPLACE`              | Prepíše existujúci pohľad bez potreby DROP                          |
| `TEMP` / `TEMPORARY`      | Vytvorí dočasný pohľad pre reláciu                                |
| `RECURSIVE`               | Povolenie rekurzívnych pohľadov (od v14+)                                |
| `WITH (security_barrier)` | Zvýšená bezpečnosť proti SQL injection                          |
| `CHECK OPTION`            | Obmedzenie INSERT/UPDATE len na riadky, ktoré vyhovujú podmienke pohľadu   |

---

<a name="porovnanie-view-materialized"></a>
## 🗃️ Porovnanie: `TABLE` vs `VIEW` vs `MATERIALIZED VIEW`

| Kritérium                   | TABLE (`CREATE TABLE`)                         | VIEW (`CREATE VIEW`)                                      | MATERIALIZED VIEW (`CREATE MATERIALIZED VIEW`)               |
|-----------------------------|------------------------------------------------|------------------------------------------------------------|---------------------------------------------------------------|
| **Ukladanie dát**           | ✅ Áno – fyzicky uložené                        | ❌ Nie – dynamický dotaz                                   | ✅ Áno – výsledky dotazu sa ukladajú                          |
| **Aktualizácia dát**        | ✅ INSERT/UPDATE/DELETE                         | ⚠️ Len pre jednoduché pohľady                              | ❌ Nie – len `REFRESH MATERIALIZED VIEW`                      |
| **Aktuálnosť dát**          | ✅ Reálne časové                               | ✅ Pri každom dotaze                                       | ❌ Závislé od času posledného refreshu                        |
| **Výkon (performance)**     | ✅ Vysoký, optimalizované                       | ⚠️ Závisí od zložitosti dotazu                             | ✅ Vysoký pre SELECT, pomalý pre REFRESH                      |
| **Indexy**                  | ✅ Áno                                          | ❌ Nie                                                     | ✅ Áno – len na uložené dáta                                  |
| **Primárne/kľúče**          | ✅ Áno                                          | ❌ Nie                                                     | ❌ Nie, len cez indexy                                        |
| **CRUD operácie**           | ✅ Plne podporované                            | ⚠️ Často len SELECT                                        | ❌ Len SELECT                                                 |
| **Podpora RLS**             | ✅ Áno                                          | ⚠️ Nie priamo – cez podkladové tabuľky                     | ❌ Nie                                                        |
| **Vhodné použitie**         | Trvalé údaje, riadenie referenčnej integrity   | Zjednodušenie dotazov, pohľad na podmnožinu dát            | Predpočítané reporty, analýzy, dashboardy                    |
| **Automatická aktualizácia**| ✅ Áno                                          | ✅ Áno – vždy pri SELECT                                   | ❌ Nie – treba `REFRESH` ručne alebo cez cron/job             |

---

<a name="rls-a-pohlady"></a>
## 🔐 RLS a pohľady: bezpečnostné modely

**1. RLS (Row-Level Security)** funguje len nad TABUĽKOU, ale je možné ho nepriamo použiť cez VIEW:

- Vytvorenie pohľadu s podmienkou:
```sql
CREATE VIEW moje_dokumenty AS
SELECT * FROM dokumenty WHERE vlastnik = current_user;
```

- Priradenie práv len k pohľadu:
```sql
GRANT SELECT ON moje_dokumenty TO analyzator;
```

- Vlastník pohľadu by mal použiť `WITH (security_barrier = true)` pre zamedzenie injekcie.

---
**2. Materializovaný pohľad + obmedzenie prístupu:**
- Vhodný pre ťažké analytické dopyty
- Neobsahuje dynamické RLS
- Vhodné kombinovať s `REFRESH MATERIALIZED VIEW CONCURRENTLY` a prístupovými rolami

---
**Praktické odporúčanie:**

- Použiť **VIEW** na zjednodušenie SELECT dopytov, maskovanie alebo filtráciu
- Použiť **MATERIALIZED VIEW**, ak je SELECT drahý a dáta sa menia zriedka
- Na **RLS použite radšej priamo TABUĽKY**, pohľady len ako prezentačné vrstvy
