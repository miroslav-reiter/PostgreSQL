
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

# Použitie TAR súborov

## 1. 📦 Vytvorenie TAR súboru – Archivácia viacerých súborov.

```bash
tar -cvf archív.tar súbor1 súbor2 adresár/
```

Tento príkaz vytvorí TAR archív s názvom `archív.tar`, ktorý obsahuje `súbor1`, `súbor2` a celý obsah adresára `adresár`.

---

## 2. 📂 Rozbalenie TAR súboru – Extrakcia obsahu archívu.

```bash
tar -xvf archív.tar
```

Tento príkaz rozbalí všetky súbory a adresáre uložené v `archív.tar`.

---

## 3. 🗜️ Vytvorenie komprimovaného TAR súboru – Archivácia s kompresiou.

```bash
tar -czvf archív.tar.gz súbor1 adresár/
```

Tento príkaz vytvorí komprimovaný TAR archív s názvom `archív.tar.gz`, ktorý obsahuje `súbor1` a obsah adresára `adresár`.

---

## 4. 🔓 Rozbalenie komprimovaného TAR súboru – Extrakcia s dekompresiou.

```bash
tar -xzvf archív.tar.gz
```

Tento príkaz rozbalí komprimovaný TAR archív `archív.tar.gz` a obnoví všetky zahrnuté súbory a adresáre.

---

# Najčastejšie používané sekcie v postgresql.conf

## 1. 🔌 Connection and Authentication Settings – Pripojenie a autentifikácia.

### Nastavenie IP adries na pripojenie:
```text
listen_addresses = 'localhost'  # Len lokálne pripojenia
listen_addresses = '*'          # Pripojenia zo všetkých IP adries
```

### Nastavenie portu:
```text
port = 5432
```

---

## 2. 💾 Resource Usage – Pamäť, CPU a disk.

### Nastavenie pamäte pre zdieľané vyrovnávacie pamäte:
```text
shared_buffers = 128MB
```

### Pamäť pre operácie ako triedenie:
```text
work_mem = 4MB
```

### Pamäť pre údržbové úlohy:
```text
maintenance_work_mem = 64MB
```

---

## 3. 📝 Logging Settings – Logovanie.

### Miesto, kam sa logy zapisujú:
```text
log_destination = 'stderr'
```

### Ukladanie logov do súborov:
```text
logging_collector = on
```

### Adresár na uloženie logov:
```text
log_directory = 'pg_log'
```

### Názov logovacích súborov:
```text
log_filename = 'postgresql-%Y-%m-%d.log'
```

---

## 4. 🚀 Query Tuning – Optimalizácia dotazov.

### Odhad dostupnej pamäte pre cachovanie:
```text
effective_cache_size = 4GB
```

### Náklady na náhodný prístup na disk:
```text
random_page_cost = 4.0
```

---

## 5. 📜 WAL (Write-Ahead Logging) and Checkpoints – Logovanie a kontrolné body.

### Nastavenie úrovne logovania:
```text
wal_level = replica
```

### Povolenie archivácie WAL logov:
```text
archive_mode = on
```

### Príkaz na archiváciu logov:
```text
archive_command = 'cp %p /cesta/k/archívu/%f'
```

---

## 6. 🌐 Replication Settings – Replikácia.

### Maximálny počet procesov odosielajúcich WAL logy:
```text
max_wal_senders = 10
```

### Povolenie čítacích dotazov na replikovanom serveri:
```text
hot_standby = on
```

---



