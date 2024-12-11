
# Príklady na spájanie tabuliek s použitím subselectov

### 1. INNER JOIN (Subselect): Zákazníci a objednávky
```sql
SELECT zakaznici.meno, objednavky.cena, objednavky.datum
FROM testovacie_data_zakaznici zakaznici,
     (SELECT id, zakaznik_id, cena, datum FROM testovacie_data_objednavky) objednavky
WHERE zakaznici.id = objednavky.zakaznik_id;
```

### 2. LEFT JOIN (Subselect): Všetci zákazníci s ich objednávkami
```sql
SELECT zakaznici.meno, objednavky.cena, objednavky.datum
FROM testovacie_data_zakaznici zakaznici
LEFT JOIN (SELECT id, zakaznik_id, cena, datum FROM testovacie_data_objednavky) objednavky
ON zakaznici.id = objednavky.zakaznik_id;
```

### 3. RIGHT JOIN (Subselect): Všetky objednávky, aj bez zákazníkov
```sql
SELECT zakaznici.meno, objednavky.cena, objednavky.datum
FROM (SELECT id, meno FROM testovacie_data_zakaznici) zakaznici
RIGHT JOIN (SELECT id, zakaznik_id, cena, datum FROM testovacie_data_objednavky) objednavky
ON zakaznici.id = objednavky.zakaznik_id;
```

### 4. FULL OUTER JOIN (Subselect): Všetci zákazníci a všetky objednávky
```sql
SELECT zakaznici.meno, objednavky.cena, objednavky.datum
FROM (SELECT id, meno FROM testovacie_data_zakaznici) zakaznici
FULL OUTER JOIN (SELECT id, zakaznik_id, cena, datum FROM testovacie_data_objednavky) objednavky
ON zakaznici.id = objednavky.zakaznik_id;
```

### 5. CROSS JOIN (Subselect): Kombinácie zákazníkov a produktov
```sql
SELECT zakaznici.meno, produkty.nazov AS produkt
FROM (SELECT id, meno FROM testovacie_data_zakaznici) zakaznici,
     (SELECT id, nazov FROM testovacie_data_produkty) produkty;
```

### 6. SELF JOIN (Subselect): Hierarchia zamestnancov (podriadený-šéf)
```sql
SELECT podriadeny.meno AS zamestnanec, sef.meno AS sef
FROM (SELECT id, meno, sef_id FROM testovacie_data_zamestnanci) podriadeny
LEFT JOIN (SELECT id, meno FROM testovacie_data_zamestnanci) sef
ON podriadeny.sef_id = sef.id;
```

### 7. USING Clause (Subselect): Jednoduchšie spojenie zákazníkov a objednávok
```sql
SELECT zakaznici.meno, objednavky.cena
FROM (SELECT id, meno FROM testovacie_data_zakaznici) zakaznici
INNER JOIN (SELECT id AS objednavka_id, zakaznik_id, cena FROM testovacie_data_objednavky) objednavky
ON zakaznici.id = objednavky.zakaznik_id;
```

### 8. JOIN s aliasmi (Subselect): Zákazníci a ich lokality
```sql
SELECT z.meno, z.lokalita, o.cena
FROM (SELECT id, meno, lokalita FROM testovacie_data_zakaznici) z
LEFT JOIN (SELECT id, zakaznik_id, cena FROM testovacie_data_objednavky) o
ON z.id = o.zakaznik_id;
```

### 9. JOIN s agregáciou (Subselect): Priemerná cena objednávok zákazníkov
```sql
SELECT zakaznici.meno, AVG(objednavky.cena) AS priemerna_cena
FROM (SELECT id, meno FROM testovacie_data_zakaznici) zakaznici
LEFT JOIN (SELECT zakaznik_id, cena FROM testovacie_data_objednavky) objednavky
ON zakaznici.id = objednavky.zakaznik_id
GROUP BY zakaznici.meno;
```

### 10. JOIN s podmienkami (Subselect): Zákazníci s objednávkami nad 100 EUR
```sql
SELECT zakaznici.meno, objednavky.cena
FROM (SELECT id, meno FROM testovacie_data_zakaznici) zakaznici
INNER JOIN (SELECT id, zakaznik_id, cena FROM testovacie_data_objednavky WHERE cena > 100) objednavky
ON zakaznici.id = objednavky.zakaznik_id;
```
