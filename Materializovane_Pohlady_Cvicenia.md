# 🐘📘 Práca s materializovanými pohľadmi v PostgreSQL

## 📌 Úloha: Vytvorenie základného materializovaného pohľadu  
Zoskupenie predajov podľa produktu.

```sql
CREATE MATERIALIZED VIEW statistika_predaja AS
SELECT produkt_id, COUNT(*) AS pocet_predajov
FROM objednavky
GROUP BY produkt_id;
```

🧠 **Vysvetlenie:**  
Tento materializovaný pohľad ukladá počet predajov jednotlivých produktov. Výsledok sa neaktualizuje automaticky – vyžaduje sa `REFRESH`.

---

## 📌 Úloha: Obnovenie materializovaného pohľadu

```sql
REFRESH MATERIALIZED VIEW statistika_predaja;
```

🧠 **Vysvetlenie:**  
Aktualizuje uložené dáta v pohľade. Spustí sa znova pôvodný SELECT a uloží výsledok.

---

## 📌 Úloha: Obnovenie s dátami (predvolená voľba)

```sql
REFRESH MATERIALIZED VIEW statistika_predaja WITH DATA;
```

🧠 **Vysvetlenie:**  
Načíta aktuálne dáta zo základných tabuliek. Rovnaké ako predvolený `REFRESH`.

---

## 📌 Úloha: Vyprázdniť pohľad bez obnovenia

```sql
REFRESH MATERIALIZED VIEW statistika_predaja WITH NO DATA;
```

🧠 **Vysvetlenie:**  
Pohľad zostane prázdny. Vhodné pre plánovanie hromadného plnenia dát alebo testovanie.

---

## 📌 Úloha: Pohľad s podrobnosťami o predaji

```sql
CREATE MATERIALIZED VIEW statistika_predaja_s_detailmi AS
SELECT 
    p.produkt_id,
    p.nazov,
    p.kategoria,
    COUNT(o.objednavka_id) AS pocet_predajov,
    SUM(o.mnozstvo) AS celkove_mnozstvo,
    SUM(o.mnozstvo * o.cena_za_jednotku) AS celkovy_vynos
FROM produkty p
JOIN objednavky o ON p.produkt_id = o.produkt_id
GROUP BY p.produkt_id, p.nazov, p.kategoria;
```

🧠 **Vysvetlenie:**  
Tento pohľad zobrazuje štatistiku predaja vrátane výnosu, množstva a počtu objednávok pre každý produkt.

---

## 📌 Úloha: Obnovenie podrobného pohľadu

```sql
REFRESH MATERIALIZED VIEW statistika_predaja_s_detailmi;
```

🧠 **Vysvetlenie:**  
Zabezpečí aktualizáciu údajov v pohľade na základe aktuálneho stavu tabuliek `produkty` a `objednavky`.

---

## 📌 Úloha: Rozšírený pohľad s priemernou cenou

```sql
CREATE MATERIALIZED VIEW statistika_predaja_rozsirena AS
SELECT 
    p.produkt_id,
    p.nazov,
    p.kategoria,
    COUNT(o.objednavka_id) AS pocet_predajov,
    SUM(o.mnozstvo) AS celkove_mnozstvo,
    SUM(o.mnozstvo * o.cena_za_jednotku) AS celkovy_vynos,
    ROUND(AVG(o.cena_za_jednotku), 2) AS priemerna_cena_predaja
FROM produkty p
JOIN objednavky o ON p.produkt_id = o.produkt_id
GROUP BY p.produkt_id, p.nazov, p.kategoria;
```

🧠 **Vysvetlenie:**  
Zobrazuje aj priemernú predajnú cenu pre každý produkt, okrem základných agregácií.

---

## 📌 Úloha: Indexy pre materializovaný pohľad

```sql
CREATE INDEX idx_statistika_predaja_produkt_id
ON statistika_predaja_rozsirena (produkt_id);

CREATE INDEX idx_statistika_predaja_nazov
ON statistika_predaja_rozsirena (nazov);

CREATE INDEX idx_statistika_predaja_nazov_text
ON statistika_predaja_rozsirena
USING GIN (to_tsvector('simple', nazov));
```

🧠 **Vysvetlenie:**  
- Indexy zrýchľujú dopyty nad pohľadom, napr. pri filtrovaní podľa `produkt_id` alebo `nazov`.
- GIN index je vhodný pre fulltextové vyhľadávanie podľa mena produktu.

