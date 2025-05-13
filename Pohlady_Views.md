
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

| Kritérium                | TABLE                            | VIEW                                | MATERIALIZED VIEW                           |
|--------------------------|----------------------------------|-------------------------------------|---------------------------------------------|
| Ukladanie dát           | ✅ fyzicky uložené              | ❌ nie, len dopyt                | ✅ áno, uložený výsledok dopytu                   |
| Aktualizácia             | ✅ plná CRUD podpora            | ⚠️ len jednoduché dopyty       | ❌ nie, iba `REFRESH`                    |
| Aktuálnosť dát         | ✅ reálna                       | ✅ reálna pri SELECTe             | ❌ nie, závislá od `REFRESH`                  |
| Podpora indexov         | ✅ áno                         | ❌ nie                           | ✅ áno, na uložených dátach                     |
| Použitie               | Produkčné dáta, referencie     | Reporting, zjednodušenie dopytov      | Prepočítavané analýzy, dashboardy              |
| RLS podpora             | ✅ plná                         | ⚠️ cez podkladovú tabuľku     | ❌ nie priamo podporované                 |

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
