# 📘 PostgreSQL: Dáta pre Cvičenia Materializované Pohľady (Materialized Views)

Tento dokument obsahuje SQL skripty pre vytvorenie a naplnenie databázových tabuliek `objednavky` a `produkty`, vrátane doplnenia cudzieho kľúča. Slúži ako základ pre analytické a reportovacie úlohy.

---

📌 **Úloha: Vytvoriť tabuľku `objednavky`**  
Základná tabuľka s objednávkami produktov. Obsahuje ID, produkt, zákazníka, dátum, množstvo a cenu za jednotku.

```sql
CREATE TABLE objednavky (
    objednavka_id SERIAL PRIMARY KEY,
    produkt_id INT NOT NULL,
    zakaznik_id INT NOT NULL,
    datum DATE NOT NULL,
    mnozstvo INT NOT NULL,
    cena_za_jednotku NUMERIC(10,2) NOT NULL
);
```

---

📌 **Úloha: Naplniť tabuľku `objednavky` reálnymi údajmi**  
Vloženie vzorových dát pre testovanie. Obsahuje viac ako 80 rôznych objednávok.

```sql
-- Skrátený výpis: len úvodná časť
INSERT INTO objednavky (produkt_id, zakaznik_id, datum, mnozstvo, cena_za_jednotku)
VALUES
(16, 6, '2025-01-08', 4, 10.0),
(18, 22, '2025-03-27', 4, 20.0),
(6, 27, '2025-04-16', 5, 50.0),
(9, 5, '2025-03-28', 1, 20.0),
(16, 5, '2025-02-09', 5, 50.0);
-- ... ďalšie záznamy pokračujú ...
```

```sql
INSERT INTO objednavky (produkt_id, zakaznik_id, datum, mnozstvo, cena_za_jednotku)
VALUES
(16, 6, '2025-01-08', 4, 10.0),
(18, 22, '2025-03-27', 4, 20.0),
(6, 27, '2025-04-16', 5, 50.0),
(9, 5, '2025-03-28', 1, 20.0),
(16, 5, '2025-02-09', 5, 50.0),
(4, 5, '2025-02-04', 3, 30.0),
(19, 13, '2025-01-12', 5, 20.0),
(12, 22, '2025-01-15', 2, 30.0),
(12, 28, '2025-01-18', 1, 10.0),
(18, 5, '2025-03-16', 3, 10.0),
(13, 8, '2025-01-12', 3, 30.0),
(8, 28, '2025-03-10', 1, 100.0),
(12, 7, '2025-03-09', 2, 50.0),
(9, 11, '2025-01-02', 5, 30.0),
(15, 12, '2025-04-02', 2, 10.0),
(4, 16, '2025-01-03', 4, 30.0),
(1, 30, '2025-04-25', 4, 20.0),
(9, 18, '2025-03-09', 4, 30.0),
(18, 14, '2025-03-25', 1, 50.0),
(16, 25, '2025-04-19', 4, 20.0),
(17, 23, '2025-01-30', 5, 100.0),
(18, 6, '2025-01-27', 2, 20.0),
(8, 15, '2025-02-10', 5, 10.0),
(14, 30, '2025-01-10', 2, 50.0),
(18, 1, '2025-02-07', 3, 100.0),
(16, 17, '2025-01-07', 1, 30.0),
(18, 2, '2025-04-04', 5, 30.0),
(13, 5, '2025-03-19', 1, 20.0),
(2, 12, '2025-03-02', 1, 50.0),
(15, 20, '2025-03-12', 4, 100.0),
(15, 30, '2025-04-12', 1, 100.0),
(20, 14, '2025-04-03', 2, 20.0),
(12, 15, '2025-02-09', 5, 10.0),
(8, 20, '2025-03-30', 3, 10.0),
(13, 12, '2025-01-03', 4, 20.0),
(3, 16, '2025-01-04', 2, 20.0),
(8, 1, '2025-01-30', 2, 50.0),
(18, 19, '2025-03-07', 1, 20.0),
(5, 10, '2025-02-02', 4, 20.0),
(16, 29, '2025-04-12', 5, 50.0),
(1, 11, '2025-04-01', 1, 20.0),
(5, 29, '2025-03-19', 1, 50.0),
(4, 3, '2025-04-01', 4, 100.0),
(17, 21, '2025-01-13', 5, 100.0),
(7, 4, '2025-04-30', 5, 10.0),
(1, 12, '2025-03-10', 1, 30.0),
(4, 1, '2025-03-09', 3, 10.0),
(16, 12, '2025-04-05', 4, 50.0),
(4, 29, '2025-03-27', 1, 50.0),
(5, 8, '2025-04-05', 5, 10.0),
(3, 16, '2025-01-24', 3, 10.0),
(19, 4, '2025-04-23', 2, 50.0),
(4, 10, '2025-01-29', 1, 30.0),
(7, 11, '2025-03-03', 5, 30.0),
(14, 9, '2025-03-19', 1, 20.0),
(18, 16, '2025-04-09', 2, 50.0),
(18, 18, '2025-02-04', 4, 10.0),
(6, 26, '2025-03-29', 2, 30.0),
(19, 1, '2025-03-31', 4, 50.0),
(4, 17, '2025-03-10', 4, 100.0),
(7, 21, '2025-03-18', 3, 50.0),
(8, 12, '2025-05-01', 5, 50.0),
(4, 25, '2025-04-04', 2, 20.0),
(12, 22, '2025-03-19', 3, 20.0),
(5, 28, '2025-02-02', 2, 20.0),
(2, 30, '2025-05-01', 5, 50.0),
(16, 8, '2025-01-04', 1, 100.0),
(1, 21, '2025-04-15', 1, 30.0),
(16, 19, '2025-04-10', 4, 100.0),
(12, 4, '2025-03-21', 2, 100.0),
(14, 1, '2025-02-13', 2, 20.0),
(5, 24, '2025-02-17', 5, 100.0),
(2, 10, '2025-01-05', 4, 10.0),
(11, 25, '2025-03-14', 1, 50.0),
(13, 30, '2025-02-07', 2, 30.0),
(19, 3, '2025-03-18', 5, 30.0),
(12, 11, '2025-01-30', 4, 20.0),
(1, 9, '2025-03-21', 1, 10.0),
(6, 23, '2025-04-28', 1, 50.0),
(11, 11, '2025-04-28', 4, 100.0),
(9, 26, '2025-04-25', 3, 20.0),
(13, 12, '2025-01-21', 3, 50.0),
(13, 10, '2025-04-21', 5, 30.0),
(4, 23, '2025-03-19', 5, 30.0),
(17, 23, '2025-03-29', 1, 20.0),
(14, 2, '2025-01-16', 1, 10.0),
(12, 19, '2025-01-04', 1, 20.0),
(14, 30, '2025-01-15', 5, 10.0),
(5, 5, '2025-03-24', 4, 10.0),
(10, 23, '2025-01-17', 5, 50.0),
(19, 5, '2025-03-10', 2, 50.0),
(6, 19, '2025-02-15', 3, 100.0),
(1, 14, '2025-04-19', 5, 30.0),
(20, 30, '2025-04-02', 2, 50.0),
(4, 13, '2025-02-05', 2, 30.0),
(3, 30, '2025-01-25', 5, 50.0),
(7, 21, '2025-03-17', 2, 30.0),
(4, 13, '2025-02-24', 5, 10.0),
(18, 17, '2025-03-01', 5, 20.0),
(9, 11, '2025-04-19', 1, 100.0);
```
---

📌 **Úloha: Vytvoriť tabuľku `produkty`**  
Tabuľka s informáciami o dostupných kurzoch a produktoch. Každý produkt má ID, názov, kategóriu a cenu.

```sql
CREATE TABLE produkty (
    produkt_id INT PRIMARY KEY,
    nazov TEXT NOT NULL,
    kategoria TEXT NOT NULL,
    cena NUMERIC(10,2) NOT NULL
);
```


```sql
(1, 'Kurz Python Začiatočník', 'Programovanie', 150.0),
(2, 'Kurz Java Mierne Pokročilý', 'Programovanie', 180.0),
(3, 'Excel pre účtovníkov', 'Office a Financie', 120.0),
(4, 'Marketing na sociálnych sieťach', 'Marketing', 140.0),
(5, 'Kurz SQL a databázy', 'Dáta', 130.0),
(6, 'Adobe Photoshop Základy', 'Grafika', 160.0),
(7, 'Kurz Projektového Riadenia', 'Manažment', 200.0),
(8, 'Finančná gramotnosť', 'Financie', 110.0),
(9, 'WordPress Tvorba Webu', 'Webdizajn', 170.0),
(10, 'Kurz Power BI', 'Dáta', 190.0),
(11, 'UI/UX Dizajn pre začiatočníkov', 'Dizajn', 175.0),
(12, 'Kurz Git a GitHub', 'DevOps', 125.0),
(13, 'Štatistika v R', 'Dáta', 160.0),
(14, 'Kurz Canva pre začiatočníkov', 'Grafika', 100.0),
(15, 'Agile a Scrum základy', 'Manažment', 135.0),
(16, 'Kurz Linux základy', 'Systémová administrácia', 145.0),
(17, 'Copywriting pre web', 'Marketing', 115.0),
(18, 'Kurz PowerPoint', 'Office', 95.0),
(19, 'Python pre Data Science', 'Dáta', 220.0),
(20, 'Kurz Etického Hacking', 'Bezpečnosť', 250.0);
```

---

📌 **Úloha: Naplniť tabuľku `produkty` reálnymi kurzami**  
Záznamy zahŕňajú programovanie, marketing, dizajn, manažment a iné oblasti.

```sql
INSERT INTO produkty (produkt_id, nazov, kategoria, cena)
VALUES
(1, 'Kurz Python Začiatočník', 'Programovanie', 150.0),
(2, 'Kurz Java Mierne Pokročilý', 'Programovanie', 180.0),
(3, 'Excel pre účtovníkov', 'Office a Financie', 120.0),
(4, 'Marketing na sociálnych sieťach', 'Marketing', 140.0),
(5, 'Kurz SQL a databázy', 'Dáta', 130.0);
-- ... ďalšie produkty pokračujú ...
```

---

📌 **Úloha: Pridať cudzí kľúč na prepojenie objednávok s produktmi**  
Zabezpečí referenčnú integritu medzi tabuľkami.

```sql
ALTER TABLE objednavky
ADD CONSTRAINT fk_produkt
FOREIGN KEY (produkt_id)
REFERENCES produkty(produkt_id);
```

---

## 📌 Úloha: Vytvoriť tabuľku `produkty_digitalne`

```sql
CREATE TABLE produkty_digitalne (
    produkt_id INT PRIMARY KEY,
    nazov TEXT NOT NULL,
    kategoria_id INT NOT NULL,
    cena NUMERIC(10,2) NOT NULL
);
```

## 📌 Úloha: Naplniť tabuľku `produkty_digitalne` (100 záznamov)

```sql
INSERT INTO produkty_digitalne (produkt_id, nazov, kategoria_id, cena)
VALUES
(1, 'Kurz Python Začiatočník', 1, 150.0),
(2, 'Kurz Java Pokročilý', 1, 180.0),
(3, 'Git a GitHub pre vývojárov', 1, 130.0),
(4, 'Power BI pre začiatočníkov', 2, 160.0),
(5, 'Štatistika v Pythone', 2, 170.0),
(6, 'Excel pre pokročilých', 2, 140.0),
(7, 'Marketing na Instagrame', 3, 120.0),
(8, 'Google Ads a PPC kampane', 3, 180.0),
(9, 'E-mail marketing stratégie', 3, 110.0),
(10, 'Canva pre tvorbu vizuálov', 4, 100.0),
(11, 'Adobe Photoshop základy', 4, 190.0),
(12, 'Figma pre UI dizajn', 4, 170.0),
(13, 'MS Word profesionálne', 5, 90.0),
(14, 'PowerPoint pre prezentácie', 5, 95.0),
(15, 'MS Outlook efektívne', 5, 85.0),
(16, 'PowerPoint pre prezentácie #16', 5, 100.75),
(17, 'Štatistika v Pythone #17', 2, 188.62),
(18, 'Figma pre UI dizajn #18', 4, 165.25),
(19, 'Marketing na Instagrame #19', 3, 119.42),
(20, 'PowerPoint pre prezentácie #20', 5, 106.38),
(21, 'E-mail marketing stratégie #21', 3, 110.59),
(22, 'Canva pre tvorbu vizuálov #22', 4, 107.46),
(23, 'Figma pre UI dizajn #23', 4, 173.2),
(24, 'E-mail marketing stratégie #24', 3, 98.5),
(25, 'PowerPoint pre prezentácie #25', 5, 83.42),
(26, 'Excel pre pokročilých #26', 2, 125.81),
(27, 'Kurz Java Pokročilý #27', 1, 170.41),
(28, 'Git a GitHub pre vývojárov #28', 1, 131.01),
(29, 'Kurz Python Začiatočník #29', 1, 159.07),
(30, 'MS Outlook efektívne #30', 5, 77.52),
(31, 'Marketing na Instagrame #31', 3, 125.87),
(32, 'Figma pre UI dizajn #32', 4, 181.18),
(33, 'Kurz Java Pokročilý #33', 1, 163.39),
(34, 'PowerPoint pre prezentácie #34', 5, 109.23),
(35, 'Power BI pre začiatočníkov #35', 2, 176.83),
(36, 'MS Outlook efektívne #36', 5, 90.03),
(37, 'MS Word profesionálne #37', 5, 84.99),
(38, 'Štatistika v Pythone #38', 2, 172.41),
(39, 'Git a GitHub pre vývojárov #39', 1, 138.48),
(40, 'Git a GitHub pre vývojárov #40', 1, 142.05),
(41, 'Adobe Photoshop základy #41', 4, 191.98),
(42, 'Adobe Photoshop základy #42', 4, 192.82),
(43, 'Marketing na Instagrame #43', 3, 100.73),
(44, 'MS Outlook efektívne #44', 5, 87.61),
(45, 'E-mail marketing stratégie #45', 3, 122.8),
(46, 'Kurz Java Pokročilý #46', 1, 181.45),
(47, 'Adobe Photoshop základy #47', 4, 170.51),
(48, 'Adobe Photoshop základy #48', 4, 201.94),
(49, 'Marketing na Instagrame #49', 3, 125.88),
(50, 'Marketing na Instagrame #50', 3, 109.14),
(51, 'Marketing na Instagrame #51', 3, 111.25),
(52, 'MS Word profesionálne #52', 5, 89.92),
(53, 'Štatistika v Pythone #53', 2, 187.75),
(54, 'Figma pre UI dizajn #54', 4, 173.15),
(55, 'Kurz Python Začiatočník #55', 1, 135.95),
(56, 'Adobe Photoshop základy #56', 4, 174.75),
(57, 'Adobe Photoshop základy #57', 4, 206.18),
(58, 'MS Outlook efektívne #58', 5, 103.85),
(59, 'Adobe Photoshop základy #59', 4, 207.61),
(60, 'Figma pre UI dizajn #60', 4, 172.25),
(61, 'Canva pre tvorbu vizuálov #61', 4, 110.06),
(62, 'Kurz Python Začiatočník #62', 1, 147.61),
(63, 'Git a GitHub pre vývojárov #63', 1, 135.38),
(64, 'Excel pre pokročilých #64', 2, 155.12),
(65, 'Kurz Java Pokročilý #65', 1, 179.3),
(66, 'PowerPoint pre prezentácie #66', 5, 86.67),
(67, 'Adobe Photoshop základy #67', 4, 195.9),
(68, 'Excel pre pokročilých #68', 2, 127.77),
(69, 'Kurz Python Začiatočník #69', 1, 137.08),
(70, 'Canva pre tvorbu vizuálov #70', 4, 109.89),
(71, 'Google Ads a PPC kampane #71', 3, 167.56),
(72, 'Štatistika v Pythone #72', 2, 158.37),
(73, 'Power BI pre začiatočníkov #73', 2, 145.38),
(74, 'Power BI pre začiatočníkov #74', 2, 176.91),
(75, 'Kurz Python Začiatočník #75', 1, 160.65),
(76, 'PowerPoint pre prezentácie #76', 5, 91.99),
(77, 'Marketing na Instagrame #77', 3, 133.23),
(78, 'Figma pre UI dizajn #78', 4, 160.91),
(79, 'Git a GitHub pre vývojárov #79', 1, 138.5),
(80, 'PowerPoint pre prezentácie #80', 5, 75.3),
(81, 'MS Outlook efektívne #81', 5, 76.92),
(82, 'MS Word profesionálne #82', 5, 94.57),
(83, 'Canva pre tvorbu vizuálov #83', 4, 95.11),
(84, 'Git a GitHub pre vývojárov #84', 1, 111.08),
(85, 'Git a GitHub pre vývojárov #85', 1, 130.79),
(86, 'Marketing na Instagrame #86', 3, 136.24),
(87, 'MS Word profesionálne #87', 5, 93.7),
(88, 'Adobe Photoshop základy #88', 4, 176.5),
(89, 'Adobe Photoshop základy #89', 4, 180.03),
(90, 'Marketing na Instagrame #90', 3, 112.67),
(91, 'Kurz Python Začiatočník #91', 1, 130.94),
(92, 'Štatistika v Pythone #92', 2, 177.01),
(93, 'Git a GitHub pre vývojárov #93', 1, 116.93),
(94, 'E-mail marketing stratégie #94', 3, 105.69),
(95, 'Štatistika v Pythone #95', 2, 174.17),
(96, 'Power BI pre začiatočníkov #96', 2, 170.47),
(97, 'Excel pre pokročilých #97', 2, 139.52),
(98, 'Google Ads a PPC kampane #98', 3, 166.43),
(99, 'Štatistika v Pythone #99', 2, 152.05),
(100, 'E-mail marketing stratégie #100', 3, 115.14);
```

## 📌 Úloha: Vytvoriť tabuľku `kategorie` a naplniť ju

```sql
CREATE TABLE kategorie (
    kategoria_id INT PRIMARY KEY,
    nazov TEXT NOT NULL
);

INSERT INTO kategorie (kategoria_id, nazov) VALUES
(1, 'Programovanie'),
(2, 'Dáta'),
(3, 'Marketing'),
(4, 'Grafika'),
(5, 'Office');
```

## 📌 Úloha: Pridať cudzí kľúč medzi `produkty_digitalne` a `kategorie`

```sql
ALTER TABLE produkty_digitalne
ADD CONSTRAINT fk_kategoria
FOREIGN KEY (kategoria_id)
REFERENCES kategorie(kategoria_id);
```

## 📌 Úloha: Vytvoriť tabuľku `predaje`

```sql
CREATE TABLE predaje (
    predaj_id INT PRIMARY KEY,
    produkt_id INT NOT NULL,
    datum DATE NOT NULL,
    cena NUMERIC(10,2) NOT NULL
);
```

## 📌 Úloha: Naplniť tabuľku `predaje` (100 záznamov)

```sql
-- INSERT skripty pre 100 predajov...
INSERT INTO predaje (predaj_id, produkt_id, datum, cena)
VALUES
(1, 19, '2025-04-08', 82.48),
(2, 15, '2025-04-02', 114.35),
(3, 3, '2025-02-22', 196.43),
(4, 19, '2025-01-28', 55.72),
(5, 15, '2025-01-27', 183.13),
(6, 9, '2025-02-10', 187.14),
(7, 15, '2025-03-07', 194.31),
(8, 13, '2025-03-09', 240.49),
(9, 18, '2025-04-26', 50.63),
(10, 9, '2025-01-10', 109.75),
(11, 4, '2025-01-04', 66.69),
(12, 18, '2025-01-01', 145.15),
(13, 15, '2025-04-30', 164.43),
(14, 9, '2025-03-02', 104.71),
(15, 3, '2025-04-15', 146.97),
(16, 3, '2025-01-27', 228.84),
(17, 20, '2025-01-13', 51.17),
(18, 3, '2025-01-03', 77.86),
(19, 9, '2025-03-13', 70.79),
(20, 5, '2025-04-26', 55.88),
(21, 20, '2025-04-04', 182.58),
(22, 15, '2025-01-11', 143.7),
(23, 12, '2025-01-17', 210.9),
(24, 16, '2025-03-30', 74.33),
(25, 15, '2025-03-02', 95.52),
(26, 11, '2025-03-03', 125.57),
(27, 18, '2025-04-30', 93.19),
(28, 19, '2025-01-09', 133.64),
(29, 6, '2025-02-07', 232.48),
(30, 7, '2025-01-06', 72.17),
(31, 20, '2025-02-08', 183.57),
(32, 9, '2025-01-10', 201.04),
(33, 3, '2025-05-03', 171.79),
(34, 1, '2025-04-04', 185.97),
(35, 4, '2025-01-21', 217.44),
(36, 2, '2025-03-16', 118.92),
(37, 12, '2025-02-15', 222.9),
(38, 15, '2025-04-20', 119.62),
(39, 14, '2025-01-30', 158.66),
(40, 12, '2025-03-01', 158.37),
(41, 1, '2025-05-10', 210.33),
(42, 7, '2025-02-07', 217.44),
(43, 9, '2025-03-26', 173.8),
(44, 6, '2025-02-14', 193.62),
(45, 3, '2025-04-10', 198.82),
(46, 9, '2025-03-05', 204.28),
(47, 13, '2025-03-22', 215.88),
(48, 12, '2025-05-06', 199.93),
(49, 17, '2025-03-07', 235.93),
(50, 1, '2025-04-28', 150.22),
(51, 15, '2025-03-23', 131.24),
(52, 3, '2025-03-10', 64.31),
(53, 16, '2025-04-22', 248.61),
(54, 4, '2025-02-20', 174.39),
(55, 10, '2025-02-09', 233.04),
(56, 2, '2025-01-27', 183.53),
(57, 18, '2025-04-11', 137.35),
(58, 1, '2025-02-16', 202.18),
(59, 16, '2025-03-05', 77.85),
(60, 8, '2025-04-22', 214.22),
(61, 16, '2025-02-16', 210.06),
(62, 5, '2025-04-02', 65.77),
(63, 7, '2025-04-13', 52.61),
(64, 19, '2025-03-26', 191.48),
(65, 3, '2025-03-26', 182.54),
(66, 5, '2025-03-26', 186.13),
(67, 15, '2025-05-06', 236.26),
(68, 4, '2025-02-16', 57.38),
(69, 14, '2025-03-07', 217.84),
(70, 17, '2025-04-09', 90.65),
(71, 7, '2025-02-06', 152.83),
(72, 3, '2025-03-04', 82.1),
(73, 3, '2025-02-03', 216.06),
(74, 14, '2025-04-03', 212.53),
(75, 14, '2025-02-03', 235.76),
(76, 10, '2025-03-23', 143.48),
(77, 11, '2025-05-08', 70.64),
(78, 15, '2025-01-12', 125.32),
(79, 12, '2025-05-07', 211.43),
(80, 19, '2025-02-12', 91.99),
(81, 2, '2025-03-27', 240.4),
(82, 7, '2025-02-28', 223.44),
(83, 2, '2025-03-29', 92.55),
(84, 11, '2025-02-26', 167.71),
(85, 3, '2025-02-01', 188.46),
(86, 19, '2025-01-03', 90.8),
(87, 16, '2025-04-09', 145.63),
(88, 11, '2025-04-27', 168.47),
(89, 20, '2025-02-03', 69.42),
(90, 5, '2025-03-13', 181.63),
(91, 19, '2025-01-29', 136.19),
(92, 11, '2025-01-08', 85.81),
(93, 15, '2025-03-30', 196.94),
(94, 17, '2025-05-04', 163.54),
(95, 6, '2025-03-18', 116.1),
(96, 10, '2025-03-06', 139.99),
(97, 9, '2025-05-01', 127.72),
(98, 17, '2025-02-13', 88.11),
(99, 1, '2025-02-08', 77.12),
(100, 14, '2025-04-09', 160.73);
```

## 🧠 Poznámka:
- Hodnoty `kategoria_id` sú previazané s tabuľkou `kategorie`
- Hodnoty `produkt_id` musia zodpovedať hodnotám z tabuľky `produkty_digitalne`

---

