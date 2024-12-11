
# Príklady na spájanie tabuliek pomocou rôznych typov JOIN v PostgreSQL

### 1. INNER JOIN: Zákazníci a objednávky
```sql
SELECT z.meno, o.datum, o.cena
FROM testovacie_data_zakaznici z
INNER JOIN testovacie_data_objednavky o
ON z.id = o.zakaznik_id;
```

### 2. LEFT JOIN: Všetci zákazníci s ich objednávkami
```sql
SELECT z.meno, o.datum, o.cena
FROM testovacie_data_zakaznici z
LEFT JOIN testovacie_data_objednavky o
ON z.id = o.zakaznik_id;
```

### 3. RIGHT JOIN: Všetky objednávky, aj bez zákazníkov
```sql
SELECT z.meno, o.datum, o.cena
FROM testovacie_data_zakaznici z
RIGHT JOIN testovacie_data_objednavky o
ON z.id = o.zakaznik_id;
```

### 4. FULL OUTER JOIN: Všetci zákazníci a všetky objednávky
```sql
SELECT z.meno, o.datum, o.cena
FROM testovacie_data_zakaznici z
FULL OUTER JOIN testovacie_data_objednavky o
ON z.id = o.zakaznik_id;
```

### 5. CROSS JOIN: Kombinácie zákazníkov a produktov
```sql
SELECT z.meno, p.nazov AS produkt
FROM testovacie_data_zakaznici z
CROSS JOIN testovacie_data_produkty p;
```

### 6. SELF JOIN: Hierarchia zamestnancov (podriadený-šéf)
```sql
SELECT podriadeny.meno AS zamestnanec, sef.meno AS sef
FROM testovacie_data_zamestnanci podriadeny
LEFT JOIN testovacie_data_zamestnanci sef
ON podriadeny.sef_id = sef.id;
```

### 7. USING Clause: Jednoduchšie spojenie zákazníkov a objednávok
```sql
SELECT z.meno, o.cena
FROM testovacie_data_zakaznici z
INNER JOIN testovacie_data_objednavky o
USING (id);
```

### 8. JOIN s aliasmi: Zákazníci a ich lokality
```sql
SELECT z.meno, z.lokalita, o.cena
FROM testovacie_data_zakaznici z
LEFT JOIN testovacie_data_objednavky o
ON z.id = o.zakaznik_id;
```

### 9. JOIN s agregáciou: Priemerná cena objednávok zákazníkov
```sql
SELECT z.meno, AVG(o.cena) AS priemerna_cena
FROM testovacie_data_zakaznici z
INNER JOIN testovacie_data_objednavky o
ON z.id = o.zakaznik_id
GROUP BY z.meno;
```

### 10. JOIN s podmienkami: Zákazníci s objednávkami nad 100 EUR
```sql
SELECT z.meno, o.cena
FROM testovacie_data_zakaznici z
INNER JOIN testovacie_data_objednavky o
ON z.id = o.zakaznik_id
WHERE o.cena > 100;
```
