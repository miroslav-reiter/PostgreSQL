
# Príklady na využitie agregácie

### 1. E-commerce: Sumarizácia predaja
Výpočet celkového predaja za deň, mesiac alebo rok.
```sql
SELECT DATE(datum), SUM(cena) AS celkovy_predaj
FROM objednavky
GROUP BY DATE(datum);
```

### 2. Financie: Priemerný zostatok na účtoch
Výpočet priemerného zostatku na účtoch zákazníkov v rôznych bankových produktoch.
```sql
SELECT produkt, AVG(zostatok) AS priemerny_zostatok
FROM bankove_ucty
GROUP BY produkt;
```

### 3. Školstvo: Výsledky študentov
Výpočet priemerných známok pre jednotlivé triedy.
```sql
SELECT trieda, AVG(znamka) AS priemerna_znamka
FROM vysledky
GROUP BY trieda;
```

### 4. Marketing: Analýza kampaní
Počet kliknutí na reklamy podľa regiónu alebo typu kampane.
```sql
SELECT region, COUNT(*) AS pocet_kliknuti
FROM reklamy
GROUP BY region;
```

### 5. Logistika: Sledovanie dopravy
Počet dodaných zásielok podľa dopravcu.
```sql
SELECT dopravca, COUNT(*) AS pocet_zasielok
FROM doprava
GROUP BY dopravca;
```

### 6. Energetika: Spotreba energie
Maximálna a minimálna spotreba elektriny pre každý deň.
```sql
SELECT datum, MAX(spotreba) AS max_spotreba, MIN(spotreba) AS min_spotreba
FROM spotreba_energie
GROUP BY datum;
```

### 7. Zdravotníctvo: Štatistiky pacientov
Počet pacientov prijatých do nemocníc podľa oddelenia.
```sql
SELECT oddelenie, COUNT(*) AS pocet_pacientov
FROM hospitalizacie
GROUP BY oddelenie;
```

### 8. Výroba: Analýza chýb
Počet chybných výrobkov podľa výrobnej linky.
```sql
SELECT vyrobna_linka, COUNT(*) AS pocet_chyb
FROM chyby
GROUP BY vyrobna_linka;
```

### 9. Turizmus: Návštevnosť lokalít
Počet návštevníkov v turistických lokalitách podľa mesiaca.
```sql
SELECT mesiac, lokalita, SUM(navstevnici) AS celkova_navstevnost
FROM turisticke_statistiky
GROUP BY mesiac, lokalita;
```

### 10. IT: Monitorovanie výkonu serverov
Priemerná doba odozvy servera za hodinu.
```sql
SELECT HOUR(cas), AVG(doba_odozvy) AS priemerna_odozva
FROM server_logy
GROUP BY HOUR(cas);
```
