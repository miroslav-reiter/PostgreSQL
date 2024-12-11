
# PostgreSQL: Zálohovanie a Obnova pre administrátora (DBA)

## 1. 🗄️ SQL Dump celej databázy – Vytvorenie zálohy databázy.

```sql
pg_dump -U používateľ -d názov_databázy -F c -f záloha.sql
```

Tento príkaz vytvorí zálohu celej databázy s názvom `názov_databázy` do súboru `záloha.sql`. Použije sa vlastný formát zálohy.

---

## 2. 📂 SQL Dump špecifických tabuliek – Vytvorenie zálohy vybranej tabuľky.

```sql
pg_dump -U používateľ -d názov_databázy -t názov_tabulky -f tabulka_záloha.sql
```

Tento príkaz vytvorí zálohu konkrétnej tabuľky s názvom `názov_tabulky` do súboru `tabulka_záloha.sql`.

---

## 3. 🔄 Obnova databázy zo SQL Dumpu – Načítanie zálohovanej databázy.

```sql
psql -U používateľ -d názov_databázy -f záloha.sql
```

Tento príkaz obnoví databázu s názvom `názov_databázy` zo súboru `záloha.sql`.

---

## 4. 📦 Fyzická záloha pomocou pg_basebackup – Kompletná záloha súborov.

```bash
pg_basebackup -D /cesta/záloha -F tar -z -P -U replikačný_používateľ
```

Tento príkaz vytvorí fyzickú zálohu celej databázy do adresára `/cesta/záloha` vo formáte TAR a s komprimáciou.

---

## 5. 🕒 Kontinuálne zálohovanie (WAL) – Nastavenie archivácie logov.

### Konfigurácia v `postgresql.conf`:
```text
wal_level = replica
archive_mode = on
archive_command = 'cp %p /cesta/na/archív/%f'
```

Toto nastavenie zabezpečuje kontinuálnu archiváciu WAL logov do adresára `/cesta/na/archív`.

---

## 6. 💾 Obnova do bodu v čase (Point-in-Time Recovery) – Načítanie databázy z WAL logov.

```bash
restore_command = 'cp /cesta/na/archív/%f %p'
```

Tento príkaz použije archivované logy na obnovu databázy do konkrétneho bodu v čase.

---
