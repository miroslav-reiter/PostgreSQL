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

