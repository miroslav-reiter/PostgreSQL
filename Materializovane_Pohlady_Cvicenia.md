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

## 📌 Úloha 1: Vytvoriť materializovaný pohľad `statistika_produktov_digi`

```sql
CREATE MATERIALIZED VIEW statistika_produktov_digi AS
SELECT kategoria_id, COUNT(*) AS pocet,
       AVG(cena) AS priemerna_cena
FROM produkty_digitalne
GROUP BY kategoria_id;
```

🧠 Vysvetlenie: Agreguje počet a priemernú cenu digitálnych produktov podľa kategórie.

---

## 📌 Úloha 2: Vytvoriť verziu pohľadu s formátovanou priemernou cenou

```sql
CREATE MATERIALIZED VIEW statistika_produktov_digi2 AS
SELECT 
    kategoria_id, 
    COUNT(*) AS pocet,
    ROUND(AVG(cena), 2) AS priemerna_cena
FROM produkty_digitalne
GROUP BY kategoria_id;
```

🧠 Vysvetlenie: Použitie `ROUND` na zaokrúhlenie priemernej ceny na 2 desatinné miesta.

---

## 📌 Úloha 3: Vytvoriť indexy pre rýchlejšie dotazy

```sql
CREATE INDEX idx_stat_kategoria 
  ON statistika_produktov_digi(kategoria_id);

CREATE INDEX idx_stat_pocet 
  ON statistika_produktov_digi(pocet DESC);
```

🧠 Vysvetlenie: Indexy urýchľujú filtrovanie a radenie podľa kategórie a počtu.

---

## 📌 Úloha 4: Vytvoriť pohľad s JOIN na kategórie

```sql
CREATE MATERIALIZED VIEW statistika_produktov_digi_join AS
SELECT 
    k.kategoria_id,
    k.nazov AS nazov_kategorie,
    COUNT(p.produkt_id) AS pocet_produktov,
    ROUND(AVG(p.cena), 2) AS priemerna_cena
FROM produkty_digitalne p
JOIN kategorie k ON p.kategoria_id = k.kategoria_id
GROUP BY k.kategoria_id, k.nazov;
```

🧠 Vysvetlenie: Spojenie tabuliek `produkty_digitalne` a `kategorie` pre zobrazenie názvu kategórie.

---

## 📌 Úloha 5: Obnovenie pohľadu `statistika_produktov_digi_join`

```sql
REFRESH MATERIALIZED VIEW statistika_produktov_digi_join;
```

🧠 Vysvetlenie: Načítanie najnovších údajov z tabuliek do materializovaného pohľadu.

---

## 📌 Úloha 6: Vytvoriť indexy pre pohľad s JOIN

```sql
CREATE INDEX idx_statistika_kategoria_id
ON statistika_produktov_digi_join (kategoria_id);

CREATE INDEX idx_statistika_nazov_kategorie
ON statistika_produktov_digi_join (nazov_kategorie);
```

🧠 Vysvetlenie: Pomáhajú zrýchliť dotazy s WHERE klauzulou na kategoria_id alebo názov.

---

## 📌 Úloha 7: Ukážky dotazov s použitím indexov

```sql
SELECT * FROM statistika_produktov_digi_join
WHERE kategoria_id = 2;

SELECT * FROM statistika_produktov_digi_join
WHERE nazov_kategorie ILIKE '%data%';
```

🧠 Vysvetlenie: Vyhľadávanie podľa kategórie alebo časti názvu pomocou `ILIKE`.

---

## 📌 Úloha 8: Vytvoriť pohľad `predaje_mesacne`

```sql
CREATE MATERIALIZED VIEW predaje_mesacne AS
SELECT produkt_id, COUNT(*) AS pocet_predajov, 
       SUM(cena) AS trzba
FROM predaje
WHERE datum >= date_trunc('month', CURRENT_DATE)
GROUP BY produkt_id;
```

🧠 Vysvetlenie: Získanie mesačných štatistík predaja podľa produktu.

---

## 📌 Úloha 9: Obnoviť pohľad `predaje_mesacne`

```sql
REFRESH MATERIALIZED VIEW predaje_mesacne;
```

🧠 Vysvetlenie: Aktualizácia pohľadu, aby obsahoval najnovšie predaje za aktuálny mesiac.

---

## 📌 Úloha 10: Vytvoriť pohľad `predaje_mesacne_join`

```sql
CREATE MATERIALIZED VIEW predaje_mesacne_join AS
SELECT 
    p.produkt_id,
    p.nazov AS nazov_produktu,
    k.kategoria_id,
    k.nazov AS nazov_kategorie,
    COUNT(pr.predaj_id) AS pocet_predajov,
    ROUND(SUM(pr.cena), 2) AS trzba
FROM predaje pr
JOIN produkty p ON pr.produkt_id = p.produkt_id
JOIN kategorie k ON p.kategoria = k.nazov
WHERE pr.datum >= date_trunc('month', CURRENT_DATE)
GROUP BY p.produkt_id, p.nazov, k.kategoria_id, k.nazov;
```

🧠 Vysvetlenie: Spojenie tabuliek `predaje`, `produkty` a `kategorie` pre mesačné štatistiky vrátane názvov.

---

