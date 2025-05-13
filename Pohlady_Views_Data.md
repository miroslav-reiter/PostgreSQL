# 📘 PostgreSQL Dáta pre Cvičenia Pohľady (Views)

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
- oddelenie_id – pre cudzí kľúč do tabuľky oddelenia
- oddelenia – pre redundantný textový názov oddelenia (napr. pre reporting, pohodlný SELECT)
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

📌 **Úloha: Vytvoriť a naplniť tabuľku `zamestnanci` reálnymi údajmi o 100 zamestnancoch pre účely testovania, cvičení a analýz.**
```sql
-- Ukážka pre prvých 5 zamestnancov
-- INSERT INTO zamestnanci (id, meno, priezvisko, email, oddelenie_id, aktivny, mzda, datum_nastupu) VALUES
-- (1, 'Lucia', 'Tóth', 'lucia.toth@firma.sk', 3, TRUE, 2899, '2024-06-24'),
-- (2, 'Andrej', 'Kučera', 'andrej.kucera@firma.sk', 4, TRUE, 2132, '2018-01-03'),
-- (3, 'Tomáš', 'Kučera', 'tomas.kucera@firma.sk', 1, TRUE, 2043, '2019-06-04'),
-- (4, 'Mária', 'Kučera', 'maria.kucera@firma.sk', 5, TRUE, 1421, '2019-06-21'),
-- (5, 'Peter', 'Polák', 'peter.polak@firma.sk', 3, FALSE, 2673, '2018-10-13');
```

```sql
INSERT INTO zamestnanci (id, meno, priezvisko, email, oddelenie_id, oddelenie, aktivny, mzda, datum_nastupu)
VALUES
(1, 'Lucia', 'Tóth', 'lucia.toth@firma.sk', 3, 'HR', TRUE, 2899, '2024-06-24'),
(2, 'Andrej', 'Kučera', 'andrej.kucera@firma.sk', 4, 'Obchod', TRUE, 2132, '2018-01-03'),
(3, 'Tomáš', 'Kučera', 'tomas.kucera@firma.sk', 1, 'IT', TRUE, 2043, '2019-06-04'),
(4, 'Mária', 'Kučera', 'maria.kucera@firma.sk', 5, 'Výskum', TRUE, 1421, '2019-06-21'),
(5, 'Peter', 'Polák', 'peter.polak@firma.sk', 3, 'HR', FALSE, 2673, '2018-10-13'),
(6, 'Anna', 'Šimek', 'anna.simek@firma.sk', 3, 'HR', TRUE, 1547, '2023-12-19'),
(7, 'Andrej', 'Horváthová', 'andrej.horvathova@firma.sk', 3, 'HR', TRUE, 1908, '2018-06-20'),
(8, 'Mária', 'Varga', 'maria.varga@firma.sk', 2, 'Marketing', TRUE, 2632, '2017-12-26'),
(9, 'Anna', 'Varga', 'anna.varga@firma.sk', 1, 'IT', TRUE, 1929, '2021-02-05'),
(10, 'Mária', 'Kováč', 'maria.kovac@firma.sk', 3, 'HR', TRUE, 2576, '2015-09-12'),
(11, 'Tomáš', 'Bartošová', 'tomas.bartosova@firma.sk', 5, 'Výskum', TRUE, 2937, '2021-04-16'),
(12, 'Anna', 'Horváthová', 'anna.horvathova@firma.sk', 5, 'Výskum', FALSE, 2528, '2017-07-15'),
(13, 'Mária', 'Kováč', 'maria.kovac@firma.sk', 3, 'HR', TRUE, 2804, '2021-01-18'),
(14, 'Martin', 'Polák', 'martin.polak@firma.sk', 2, 'Marketing', TRUE, 1654, '2023-09-20'),
(15, 'Eva', 'Polák', 'eva.polak@firma.sk', 1, 'IT', TRUE, 2719, '2018-09-05'),
(16, 'Lucia', 'Kováč', 'lucia.kovac@firma.sk', 4, 'Obchod', TRUE, 2570, '2025-01-20'),
(17, 'Andrej', 'Szabó', 'andrej.szabo@firma.sk', 1, 'IT', TRUE, 1632, '2017-06-05'),
(18, 'Tomáš', 'Bartošová', 'tomas.bartosova@firma.sk', 4, 'Obchod', TRUE, 2391, '2019-05-20'),
(19, 'Mária', 'Varga', 'maria.varga@firma.sk', 4, 'Obchod', TRUE, 1682, '2017-06-30'),
(20, 'Ján', 'Kováč', 'jan.kovac@firma.sk', 5, 'Výskum', TRUE, 1610, '2016-03-21'),
(21, 'Zuzana', 'Šimek', 'zuzana.simek@firma.sk', 2, 'Marketing', TRUE, 2986, '2016-09-20'),
(22, 'Zuzana', 'Kováč', 'zuzana.kovac@firma.sk', 2, 'Marketing', TRUE, 1106, '2017-09-05'),
(23, 'Tomáš', 'Kováč', 'tomas.kovac@firma.sk', 4, 'Obchod', TRUE, 1426, '2024-11-08'),
(24, 'Ján', 'Kučera', 'jan.kucera@firma.sk', 3, 'HR', TRUE, 1989, '2015-06-28'),
(25, 'Andrej', 'Bartošová', 'andrej.bartosova@firma.sk', 2, 'Marketing', TRUE, 2612, '2024-04-27'),
(26, 'Tomáš', 'Novák', 'tomas.novak@firma.sk', 3, 'HR', TRUE, 1749, '2016-08-10'),
(27, 'Tomáš', 'Szabó', 'tomas.szabo@firma.sk', 2, 'Marketing', TRUE, 1966, '2017-11-11'),
(28, 'Anna', 'Szabó', 'anna.szabo@firma.sk', 4, 'Obchod', TRUE, 1587, '2020-05-27'),
(29, 'Ján', 'Kučera', 'jan.kucera@firma.sk', 2, 'Marketing', TRUE, 2507, '2022-10-07'),
(30, 'Lucia', 'Tóth', 'lucia.toth@firma.sk', 2, 'Marketing', FALSE, 1451, '2021-06-24'),
(31, 'Mária', 'Kučera', 'maria.kucera@firma.sk', 5, 'Výskum', TRUE, 936, '2015-09-10'),
(32, 'Mária', 'Kováč', 'maria.kovac@firma.sk', 5, 'Výskum', TRUE, 2530, '2020-11-20'),
(33, 'Lucia', 'Bartošová', 'lucia.bartosova@firma.sk', 5, 'Výskum', TRUE, 2607, '2015-09-04'),
(34, 'Tomáš', 'Varga', 'tomas.varga@firma.sk', 5, 'Výskum', TRUE, 1426, '2020-06-25'),
(35, 'Eva', 'Szabó', 'eva.szabo@firma.sk', 4, 'Obchod', TRUE, 2894, '2017-09-26'),
(36, 'Zuzana', 'Novák', 'zuzana.novak@firma.sk', 3, 'HR', TRUE, 2150, '2017-10-04'),
(37, 'Ján', 'Varga', 'jan.varga@firma.sk', 5, 'Výskum', TRUE, 2348, '2020-01-31'),
(38, 'Tomáš', 'Tóth', 'tomas.toth@firma.sk', 4, 'Obchod', TRUE, 2176, '2020-12-04'),
(39, 'Andrej', 'Šimek', 'andrej.simek@firma.sk', 4, 'Obchod', TRUE, 1807, '2024-01-20'),
(40, 'Andrej', 'Szabó', 'andrej.szabo@firma.sk', 2, 'Marketing', TRUE, 1843, '2025-02-20'),
(41, 'Zuzana', 'Tóth', 'zuzana.toth@firma.sk', 4, 'Obchod', TRUE, 2662, '2020-08-16'),
(42, 'Peter', 'Varga', 'peter.varga@firma.sk', 5, 'Výskum', TRUE, 2116, '2019-04-11'),
(43, 'Anna', 'Kováč', 'anna.kovac@firma.sk', 5, 'Výskum', TRUE, 1250, '2015-12-30'),
(44, 'Anna', 'Kučera', 'anna.kucera@firma.sk', 5, 'Výskum', TRUE, 1215, '2024-01-20'),
(45, 'Eva', 'Kováč', 'eva.kovac@firma.sk', 4, 'Obchod', TRUE, 1604, '2018-12-25'),
(46, 'Zuzana', 'Kučera', 'zuzana.kucera@firma.sk', 1, 'IT', TRUE, 1455, '2025-03-16'),
(47, 'Andrej', 'Tóth', 'andrej.toth@firma.sk', 5, 'Výskum', TRUE, 2315, '2024-09-05'),
(48, 'Eva', 'Novák', 'eva.novak@firma.sk', 1, 'IT', FALSE, 2080, '2016-12-18'),
(49, 'Mária', 'Kučera', 'maria.kucera@firma.sk', 5, 'Výskum', FALSE, 2778, '2025-04-04'),
(50, 'Ján', 'Horváthová', 'jan.horvathova@firma.sk', 1, 'IT', TRUE, 2187, '2019-08-16'),
(51, 'Zuzana', 'Kučera', 'zuzana.kucera@firma.sk', 2, 'Marketing', TRUE, 2031, '2020-02-01'),
(52, 'Ján', 'Varga', 'jan.varga@firma.sk', 4, 'Obchod', TRUE, 1498, '2019-04-12'),
(53, 'Ján', 'Bartošová', 'jan.bartosova@firma.sk', 3, 'HR', FALSE, 1825, '2016-08-02'),
(54, 'Zuzana', 'Novák', 'zuzana.novak@firma.sk', 4, 'Obchod', TRUE, 1786, '2015-07-23'),
(55, 'Lucia', 'Horváthová', 'lucia.horvathova@firma.sk', 1, 'IT', TRUE, 2765, '2024-04-23'),
(56, 'Andrej', 'Szabó', 'andrej.szabo@firma.sk', 1, 'IT', TRUE, 2107, '2017-05-25'),
(57, 'Ján', 'Šimek', 'jan.simek@firma.sk', 1, 'IT', TRUE, 2066, '2020-06-02'),
(58, 'Mária', 'Bartošová', 'maria.bartosova@firma.sk', 5, 'Výskum', TRUE, 1974, '2020-01-06'),
(59, 'Eva', 'Kučera', 'eva.kucera@firma.sk', 3, 'HR', TRUE, 1831, '2022-06-07'),
(60, 'Andrej', 'Kučera', 'andrej.kucera@firma.sk', 1, 'IT', TRUE, 2213, '2015-10-18'),
(61, 'Mária', 'Novák', 'maria.novak@firma.sk', 5, 'Výskum', TRUE, 1536, '2020-01-01'),
(62, 'Tomáš', 'Šimek', 'tomas.simek@firma.sk', 2, 'Marketing', FALSE, 1782, '2020-09-10'),
(63, 'Ján', 'Kučera', 'jan.kucera@firma.sk', 4, 'Obchod', TRUE, 2006, '2024-07-20'),
(64, 'Ján', 'Kováč', 'jan.kovac@firma.sk', 1, 'IT', TRUE, 1212, '2023-08-10'),
(65, 'Martin', 'Novák', 'martin.novak@firma.sk', 5, 'Výskum', TRUE, 1713, '2024-01-04'),
(66, 'Eva', 'Novák', 'eva.novak@firma.sk', 2, 'Marketing', FALSE, 2041, '2016-04-29'),
(67, 'Martin', 'Tóth', 'martin.toth@firma.sk', 1, 'IT', TRUE, 2633, '2020-01-31'),
(68, 'Mária', 'Polák', 'maria.polak@firma.sk', 2, 'Marketing', TRUE, 1103, '2021-05-04'),
(69, 'Mária', 'Horváthová', 'maria.horvathova@firma.sk', 1, 'IT', TRUE, 2535, '2015-06-30'),
(70, 'Zuzana', 'Polák', 'zuzana.polak@firma.sk', 1, 'IT', TRUE, 2612, '2015-09-15'),
(71, 'Ján', 'Szabó', 'jan.szabo@firma.sk', 4, 'Obchod', TRUE, 2060, '2020-02-13'),
(72, 'Andrej', 'Polák', 'andrej.polak@firma.sk', 5, 'Výskum', TRUE, 1011, '2020-06-02'),
(73, 'Zuzana', 'Tóth', 'zuzana.toth@firma.sk', 1, 'IT', TRUE, 2222, '2021-03-16'),
(74, 'Lucia', 'Polák', 'lucia.polak@firma.sk', 1, 'IT', FALSE, 1188, '2015-08-11'),
(75, 'Eva', 'Polák', 'eva.polak@firma.sk', 5, 'Výskum', FALSE, 2990, '2023-04-19'),
(76, 'Anna', 'Tóth', 'anna.toth@firma.sk', 1, 'IT', TRUE, 1206, '2022-05-23'),
(77, 'Andrej', 'Kučera', 'andrej.kucera@firma.sk', 2, 'Marketing', TRUE, 2047, '2015-05-28'),
(78, 'Zuzana', 'Šimek', 'zuzana.simek@firma.sk', 1, 'IT', TRUE, 2569, '2018-08-12'),
(79, 'Tomáš', 'Horváthová', 'tomas.horvathova@firma.sk', 2, 'Marketing', TRUE, 2407, '2017-10-10'),
(80, 'Lucia', 'Šimek', 'lucia.simek@firma.sk', 2, 'Marketing', TRUE, 2772, '2022-03-31'),
(81, 'Tomáš', 'Bartošová', 'tomas.bartosova@firma.sk', 4, 'Obchod', TRUE, 2386, '2023-07-21'),
(82, 'Ján', 'Kováč', 'jan.kovac@firma.sk', 2, 'Marketing', FALSE, 936, '2015-07-01'),
(83, 'Martin', 'Kučera', 'martin.kucera@firma.sk', 4, 'Obchod', TRUE, 2408, '2024-06-20'),
(84, 'Mária', 'Tóth', 'maria.toth@firma.sk', 1, 'IT', TRUE, 1617, '2016-10-27'),
(85, 'Anna', 'Bartošová', 'anna.bartosova@firma.sk', 3, 'HR', TRUE, 2382, '2020-05-06'),
(86, 'Zuzana', 'Horváthová', 'zuzana.horvathova@firma.sk', 2, 'Marketing', TRUE, 2578, '2019-10-20'),
(87, 'Lucia', 'Tóth', 'lucia.toth@firma.sk', 5, 'Výskum', FALSE, 2453, '2019-09-27'),
(88, 'Anna', 'Šimek', 'anna.simek@firma.sk', 4, 'Obchod', FALSE, 1475, '2023-02-19'),
(89, 'Eva', 'Polák', 'eva.polak@firma.sk', 3, 'HR', TRUE, 1191, '2019-09-04'),
(90, 'Ján', 'Tóth', 'jan.toth@firma.sk', 2, 'Marketing', FALSE, 2496, '2023-11-21'),
(91, 'Anna', 'Novák', 'anna.novak@firma.sk', 3, 'HR', TRUE, 2898, '2015-05-21'),
(92, 'Peter', 'Bartošová', 'peter.bartosova@firma.sk', 1, 'IT', TRUE, 1867, '2023-09-01'),
(93, 'Anna', 'Kováč', 'anna.kovac@firma.sk', 5, 'Výskum', TRUE, 1468, '2020-11-25'),
(94, 'Peter', 'Kučera', 'peter.kucera@firma.sk', 2, 'Marketing', TRUE, 2991, '2019-04-08'),
(95, 'Anna', 'Novák', 'anna.novak@firma.sk', 1, 'IT', TRUE, 1574, '2015-10-08'),
(96, 'Eva', 'Varga', 'eva.varga@firma.sk', 5, 'Výskum', TRUE, 2301, '2023-06-06'),
(97, 'Martin', 'Šimek', 'martin.simek@firma.sk', 2, 'Marketing', TRUE, 1254, '2016-04-21'),
(98, 'Ján', 'Szabó', 'jan.szabo@firma.sk', 5, 'Výskum', TRUE, 1117, '2016-05-16'),
(99, 'Andrej', 'Horváthová', 'andrej.horvathova@firma.sk', 3, 'HR', TRUE, 2781, '2018-10-23'),
(100, 'Andrej', 'Šimek', 'andrej.simek@firma.sk', 2, 'Marketing', FALSE, 1372, '2020-08-06');
```

```sql
-- Bez stĺpca oddelenie
-- INSERT INTO zamestnanci (id, meno, priezvisko, email, oddelenie_id, aktivny, mzda, datum_nastupu)
-- VALUES
-- (1, 'Lucia', 'Tóth', 'lucia.toth@firma.sk', 3, TRUE, 2899, '2024-06-24'),
-- (2, 'Andrej', 'Kučera', 'andrej.kucera@firma.sk', 4, TRUE, 2132, '2018-01-03'),
-- (3, 'Tomáš', 'Kučera', 'tomas.kucera@firma.sk', 1, TRUE, 2043, '2019-06-04'),
-- (4, 'Mária', 'Kučera', 'maria.kucera@firma.sk', 5, TRUE, 1421, '2019-06-21'),
-- (5, 'Peter', 'Polák', 'peter.polak@firma.sk', 3, FALSE, 2673, '2018-10-13'),
-- (6, 'Anna', 'Šimek', 'anna.simek@firma.sk', 3, TRUE, 1547, '2023-12-19'),
-- (7, 'Andrej', 'Horváthová', 'andrej.horvathova@firma.sk', 3, TRUE, 1908, '2018-06-20'),
-- (8, 'Mária', 'Varga', 'maria.varga@firma.sk', 2, TRUE, 2632, '2017-12-26'),
-- (9, 'Anna', 'Varga', 'anna.varga@firma.sk', 1, TRUE, 1929, '2021-02-05'),
-- (10, 'Mária', 'Kováč', 'maria.kovac@firma.sk', 3, TRUE, 2576, '2015-09-12'),
-- (11, 'Tomáš', 'Bartošová', 'tomas.bartosova@firma.sk', 5, TRUE, 2937, '2021-04-16'),
-- (12, 'Anna', 'Horváthová', 'anna.horvathova@firma.sk', 5, FALSE, 2528, '2017-07-15'),
-- (13, 'Mária', 'Kováč', 'maria.kovac@firma.sk', 3, TRUE, 2804, '2021-01-18'),
-- (14, 'Martin', 'Polák', 'martin.polak@firma.sk', 2, TRUE, 1654, '2023-09-20'),
-- (15, 'Eva', 'Polák', 'eva.polak@firma.sk', 1, TRUE, 2719, '2018-09-05'),
-- (16, 'Lucia', 'Kováč', 'lucia.kovac@firma.sk', 4, TRUE, 2570, '2025-01-20'),
-- (17, 'Andrej', 'Szabó', 'andrej.szabo@firma.sk', 1, TRUE, 1632, '2017-06-05'),
-- (18, 'Tomáš', 'Bartošová', 'tomas.bartosova@firma.sk', 4, TRUE, 2391, '2019-05-20'),
-- (19, 'Mária', 'Varga', 'maria.varga@firma.sk', 4, TRUE, 1682, '2017-06-30'),
-- (20, 'Ján', 'Kováč', 'jan.kovac@firma.sk', 5, TRUE, 1610, '2016-03-21'),
-- (21, 'Zuzana', 'Šimek', 'zuzana.simek@firma.sk', 2, TRUE, 2986, '2016-09-20'),
-- (22, 'Zuzana', 'Kováč', 'zuzana.kovac@firma.sk', 2, TRUE, 1106, '2017-09-05'),
-- (23, 'Tomáš', 'Kováč', 'tomas.kovac@firma.sk', 4, TRUE, 1426, '2024-11-08'),
-- (24, 'Ján', 'Kučera', 'jan.kucera@firma.sk', 3, TRUE, 1989, '2015-06-28'),
-- (25, 'Andrej', 'Bartošová', 'andrej.bartosova@firma.sk', 2, TRUE, 2612, '2024-04-27'),
-- (26, 'Tomáš', 'Novák', 'tomas.novak@firma.sk', 3, TRUE, 1749, '2016-08-10'),
-- (27, 'Tomáš', 'Szabó', 'tomas.szabo@firma.sk', 2, TRUE, 1966, '2017-11-11'),
-- (28, 'Anna', 'Szabó', 'anna.szabo@firma.sk', 4, TRUE, 1587, '2020-05-27'),
-- (29, 'Ján', 'Kučera', 'jan.kucera@firma.sk', 2, TRUE, 2507, '2022-10-07'),
-- (30, 'Lucia', 'Tóth', 'lucia.toth@firma.sk', 2, FALSE, 1451, '2021-06-24'),
-- (31, 'Mária', 'Kučera', 'maria.kucera@firma.sk', 5, TRUE, 936, '2015-09-10'),
-- (32, 'Mária', 'Kováč', 'maria.kovac@firma.sk', 5, TRUE, 2530, '2020-11-20'),
-- (33, 'Lucia', 'Bartošová', 'lucia.bartosova@firma.sk', 5, TRUE, 2607, '2015-09-04'),
-- (34, 'Tomáš', 'Varga', 'tomas.varga@firma.sk', 5, TRUE, 1426, '2020-06-25'),
-- (35, 'Eva', 'Szabó', 'eva.szabo@firma.sk', 4, TRUE, 2894, '2017-09-26'),
-- (36, 'Zuzana', 'Novák', 'zuzana.novak@firma.sk', 3, TRUE, 2150, '2017-10-04'),
-- (37, 'Ján', 'Varga', 'jan.varga@firma.sk', 5, TRUE, 2348, '2020-01-31'),
-- (38, 'Tomáš', 'Tóth', 'tomas.toth@firma.sk', 4, TRUE, 2176, '2020-12-04'),
-- (39, 'Andrej', 'Šimek', 'andrej.simek@firma.sk', 4, TRUE, 1807, '2024-01-20'),
-- (40, 'Andrej', 'Szabó', 'andrej.szabo@firma.sk', 2, TRUE, 1843, '2025-02-20'),
-- (41, 'Zuzana', 'Tóth', 'zuzana.toth@firma.sk', 4, TRUE, 2662, '2020-08-16'),
-- (42, 'Peter', 'Varga', 'peter.varga@firma.sk', 5, TRUE, 2116, '2019-04-11'),
-- (43, 'Anna', 'Kováč', 'anna.kovac@firma.sk', 5, TRUE, 1250, '2015-12-30'),
-- (44, 'Anna', 'Kučera', 'anna.kucera@firma.sk', 5, TRUE, 1215, '2024-01-20'),
-- (45, 'Eva', 'Kováč', 'eva.kovac@firma.sk', 4, TRUE, 1604, '2018-12-25'),
-- (46, 'Zuzana', 'Kučera', 'zuzana.kucera@firma.sk', 1, TRUE, 1455, '2025-03-16'),
-- (47, 'Andrej', 'Tóth', 'andrej.toth@firma.sk', 5, TRUE, 2315, '2024-09-05'),
-- (48, 'Eva', 'Novák', 'eva.novak@firma.sk', 1, FALSE, 2080, '2016-12-18'),
-- (49, 'Mária', 'Kučera', 'maria.kucera@firma.sk', 5, FALSE, 2778, '2025-04-04'),
-- (50, 'Ján', 'Horváthová', 'jan.horvathova@firma.sk', 1, TRUE, 2187, '2019-08-16'),
-- (51, 'Zuzana', 'Kučera', 'zuzana.kucera@firma.sk', 2, TRUE, 2031, '2020-02-01'),
-- (52, 'Ján', 'Varga', 'jan.varga@firma.sk', 4, TRUE, 1498, '2019-04-12'),
-- (53, 'Ján', 'Bartošová', 'jan.bartosova@firma.sk', 3, FALSE, 1825, '2016-08-02'),
-- (54, 'Zuzana', 'Novák', 'zuzana.novak@firma.sk', 4, TRUE, 1786, '2015-07-23'),
-- (55, 'Lucia', 'Horváthová', 'lucia.horvathova@firma.sk', 1, TRUE, 2765, '2024-04-23'),
-- (56, 'Andrej', 'Szabó', 'andrej.szabo@firma.sk', 1, TRUE, 2107, '2017-05-25'),
-- (57, 'Ján', 'Šimek', 'jan.simek@firma.sk', 1, TRUE, 2066, '2020-06-02'),
-- (58, 'Mária', 'Bartošová', 'maria.bartosova@firma.sk', 5, TRUE, 1974, '2020-01-06'),
-- (59, 'Eva', 'Kučera', 'eva.kucera@firma.sk', 3, TRUE, 1831, '2022-06-07'),
-- (60, 'Andrej', 'Kučera', 'andrej.kucera@firma.sk', 1, TRUE, 2213, '2015-10-18'),
-- (61, 'Mária', 'Novák', 'maria.novak@firma.sk', 5, TRUE, 1536, '2020-01-01'),
-- (62, 'Tomáš', 'Šimek', 'tomas.simek@firma.sk', 2, FALSE, 1782, '2020-09-10'),
-- (63, 'Ján', 'Kučera', 'jan.kucera@firma.sk', 4, TRUE, 2006, '2024-07-20'),
-- (64, 'Ján', 'Kováč', 'jan.kovac@firma.sk', 1, TRUE, 1212, '2023-08-10'),
-- (65, 'Martin', 'Novák', 'martin.novak@firma.sk', 5, TRUE, 1713, '2024-01-04'),
-- (66, 'Eva', 'Novák', 'eva.novak@firma.sk', 2, FALSE, 2041, '2016-04-29'),
-- (67, 'Martin', 'Tóth', 'martin.toth@firma.sk', 1, TRUE, 2633, '2020-01-31'),
-- (68, 'Mária', 'Polák', 'maria.polak@firma.sk', 2, TRUE, 1103, '2021-05-04'),
-- (69, 'Mária', 'Horváthová', 'maria.horvathova@firma.sk', 1, TRUE, 2535, '2015-06-30'),
-- (70, 'Zuzana', 'Polák', 'zuzana.polak@firma.sk', 1, TRUE, 2612, '2015-09-15'),
-- (71, 'Ján', 'Szabó', 'jan.szabo@firma.sk', 4, TRUE, 2060, '2020-02-13'),
-- (72, 'Andrej', 'Polák', 'andrej.polak@firma.sk', 5, TRUE, 1011, '2020-06-02'),
-- (73, 'Zuzana', 'Tóth', 'zuzana.toth@firma.sk', 1, TRUE, 2222, '2021-03-16'),
-- (74, 'Lucia', 'Polák', 'lucia.polak@firma.sk', 1, FALSE, 1188, '2015-08-11'),
-- (75, 'Eva', 'Polák', 'eva.polak@firma.sk', 5, FALSE, 2990, '2023-04-19'),
-- (76, 'Anna', 'Tóth', 'anna.toth@firma.sk', 1, TRUE, 1206, '2022-05-23'),
-- (77, 'Andrej', 'Kučera', 'andrej.kucera@firma.sk', 2, TRUE, 2047, '2015-05-28'),
-- (78, 'Zuzana', 'Šimek', 'zuzana.simek@firma.sk', 1, TRUE, 2569, '2018-08-12'),
-- (79, 'Tomáš', 'Horváthová', 'tomas.horvathova@firma.sk', 2, TRUE, 2407, '2017-10-10'),
-- (80, 'Lucia', 'Šimek', 'lucia.simek@firma.sk', 2, TRUE, 2772, '2022-03-31'),
-- (81, 'Tomáš', 'Bartošová', 'tomas.bartosova@firma.sk', 4, TRUE, 2386, '2023-07-21'),
-- (82, 'Ján', 'Kováč', 'jan.kovac@firma.sk', 2, FALSE, 936, '2015-07-01'),
-- (83, 'Martin', 'Kučera', 'martin.kucera@firma.sk', 4, TRUE, 2408, '2024-06-20'),
-- (84, 'Mária', 'Tóth', 'maria.toth@firma.sk', 1, TRUE, 1617, '2016-10-27'),
-- (85, 'Anna', 'Bartošová', 'anna.bartosova@firma.sk', 3, TRUE, 2382, '2020-05-06'),
-- (86, 'Zuzana', 'Horváthová', 'zuzana.horvathova@firma.sk', 2, TRUE, 2578, '2019-10-20'),
-- (87, 'Lucia', 'Tóth', 'lucia.toth@firma.sk', 5, FALSE, 2453, '2019-09-27'),
-- (88, 'Anna', 'Šimek', 'anna.simek@firma.sk', 4, FALSE, 1475, '2023-02-19'),
-- (89, 'Eva', 'Polák', 'eva.polak@firma.sk', 3, TRUE, 1191, '2019-09-04'),
-- (90, 'Ján', 'Tóth', 'jan.toth@firma.sk', 2, FALSE, 2496, '2023-11-21'),
-- (91, 'Anna', 'Novák', 'anna.novak@firma.sk', 3, TRUE, 2898, '2015-05-21'),
-- (92, 'Peter', 'Bartošová', 'peter.bartosova@firma.sk', 1, TRUE, 1867, '2023-09-01'),
-- (93, 'Anna', 'Kováč', 'anna.kovac@firma.sk', 5, TRUE, 1468, '2020-11-25'),
-- (94, 'Peter', 'Kučera', 'peter.kucera@firma.sk', 2, TRUE, 2991, '2019-04-08'),
-- (95, 'Anna', 'Novák', 'anna.novak@firma.sk', 1, TRUE, 1574, '2015-10-08'),
-- (96, 'Eva', 'Varga', 'eva.varga@firma.sk', 5, TRUE, 2301, '2023-06-06'),
-- (97, 'Martin', 'Šimek', 'martin.simek@firma.sk', 2, TRUE, 1254, '2016-04-21'),
-- (98, 'Ján', 'Szabó', 'jan.szabo@firma.sk', 5, TRUE, 1117, '2016-05-16'),
-- (99, 'Andrej', 'Horváthová', 'andrej.horvathova@firma.sk', 3, TRUE, 2781, '2018-10-23'),
-- (100, 'Andrej', 'Šimek', 'andrej.simek@firma.sk', 2, FALSE, 1372, '2020-08-06');

```

📌 **Úloha: Vytvoriť tabuľku `platy`**
```sql
DROP TABLE IF EXISTS platy;
CREATE TABLE IF NOT EXISTS platy (
    id SERIAL PRIMARY KEY,
    zamestnanec_id INT REFERENCES zamestnanci(id),
    suma NUMERIC(8,2) NOT NULL,
    platnost_od DATE NOT NULL DEFAULT CURRENT_DATE
);
```

```sql
-- Príklad 5 vloženi údajov do tabulky platy
-- platnost_od = dátum, od ktorého daný plat (suma) začína platiť pre konkrétneho zamestnanca.
-- INSERT INTO platy (zamestnanec_id, suma, platnost_od) VALUES
-- (1, 2899, '2024-06-24'),
-- (2, 2132, '2018-01-03'),
-- (3, 2043, '2019-06-04'),
-- (4, 1421, '2019-06-21'),
-- (5, 2673, '2018-10-13');
```

📌 **Úloha: Naplniť tabuľku `platy` údajmi**
```sql
INSERT INTO platy (zamestnanec_id, suma, platnost_od)
VALUES
(1, 2899, '2024-06-24'),
(2, 2132, '2018-01-03'),
(3, 2043, '2019-06-04'),
(4, 1421, '2019-06-21'),
(5, 2673, '2018-10-13'),
(6, 1547, '2023-12-19'),
(7, 1908, '2018-06-20'),
(8, 2632, '2017-12-26'),
(9, 1929, '2021-02-05'),
(10, 2576, '2015-09-12'),
(11, 2937, '2021-04-16'),
(12, 2528, '2017-07-15'),
(13, 2804, '2021-01-18'),
(14, 1654, '2023-09-20'),
(15, 2719, '2018-09-05'),
(16, 2570, '2025-01-20'),
(17, 1632, '2017-06-05'),
(18, 2391, '2019-05-20'),
(19, 1682, '2017-06-30'),
(20, 1610, '2016-03-21'),
(21, 2986, '2016-09-20'),
(22, 1106, '2017-09-05'),
(23, 1426, '2024-11-08'),
(24, 1989, '2015-06-28'),
(25, 2612, '2024-04-27'),
(26, 1749, '2016-08-10'),
(27, 1966, '2017-11-11'),
(28, 1587, '2020-05-27'),
(29, 2507, '2022-10-07'),
(30, 1451, '2021-06-24'),
(31, 936, '2015-09-10'),
(32, 2530, '2020-11-20'),
(33, 2607, '2015-09-04'),
(34, 1426, '2020-06-25'),
(35, 2894, '2017-09-26'),
(36, 2150, '2017-10-04'),
(37, 2348, '2020-01-31'),
(38, 2176, '2020-12-04'),
(39, 1807, '2024-01-20'),
(40, 1843, '2025-02-20'),
(41, 2662, '2020-08-16'),
(42, 2116, '2019-04-11'),
(43, 1250, '2015-12-30'),
(44, 1215, '2024-01-20'),
(45, 1604, '2018-12-25'),
(46, 1455, '2025-03-16'),
(47, 2315, '2024-09-05'),
(48, 2080, '2016-12-18'),
(49, 2778, '2025-04-04'),
(50, 2187, '2019-08-16'),
(51, 2031, '2020-02-01'),
(52, 1498, '2019-04-12'),
(53, 1825, '2016-08-02'),
(54, 1786, '2015-07-23'),
(55, 2765, '2024-04-23'),
(56, 2107, '2017-05-25'),
(57, 2066, '2020-06-02'),
(58, 1974, '2020-01-06'),
(59, 1831, '2022-06-07'),
(60, 2213, '2015-10-18'),
(61, 1536, '2020-01-01'),
(62, 1782, '2020-09-10'),
(63, 2006, '2024-07-20'),
(64, 1212, '2023-08-10'),
(65, 1713, '2024-01-04'),
(66, 2041, '2016-04-29'),
(67, 2633, '2020-01-31'),
(68, 1103, '2021-05-04'),
(69, 2535, '2015-06-30'),
(70, 2612, '2015-09-15'),
(71, 2060, '2020-02-13'),
(72, 1011, '2020-06-02'),
(73, 2222, '2021-03-16'),
(74, 1188, '2015-08-11'),
(75, 2990, '2023-04-19'),
(76, 1206, '2022-05-23'),
(77, 2047, '2015-05-28'),
(78, 2569, '2018-08-12'),
(79, 2407, '2017-10-10'),
(80, 2772, '2022-03-31'),
(81, 2386, '2023-07-21'),
(82, 936, '2015-07-01'),
(83, 2408, '2024-06-20'),
(84, 1617, '2016-10-27'),
(85, 2382, '2020-05-06'),
(86, 2578, '2019-10-20'),
(87, 2453, '2019-09-27'),
(88, 1475, '2023-02-19'),
(89, 1191, '2019-09-04'),
(90, 2496, '2023-11-21'),
(91, 2898, '2015-05-21'),
(92, 1867, '2023-09-01'),
(93, 1468, '2020-11-25'),
(94, 2991, '2019-04-08'),
(95, 1574, '2015-10-08'),
(96, 2301, '2023-06-06'),
(97, 1254, '2016-04-21'),
(98, 1117, '2016-05-16'),
(99, 2781, '2018-10-23'),
(100, 1372, '2020-08-06');
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
