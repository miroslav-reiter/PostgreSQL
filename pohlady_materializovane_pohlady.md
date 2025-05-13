
# Porovnanie: TABLE vs VIEW vs MATERIALIZED VIEW

| Kritérium                   | TABLE (`CREATE TABLE`)                         | VIEW (`CREATE VIEW`)                                      | MATERIALIZED VIEW (`CREATE MATERIALIZED VIEW`)               |
|-----------------------------|------------------------------------------------|------------------------------------------------------------|---------------------------------------------------------------|
| **Ukladanie dát**           | ✅ Áno – fyzicky uložené                        | ❌ Nie – dynamický dotaz                                   | ✅ Áno – výsledky dotazu sa ukladajú                          |
| **Aktualizácia dát**        | ✅ INSERT/UPDATE/DELETE                         | ⚠️ Len pre jednoduché pohľady                              | ❌ Nie – len `REFRESH MATERIALIZED VIEW`                      |
| **Aktuálnosť dát**          | ✅ Reálne časové                               | ✅ Pri každom dotaze                                       | ❌ Závislé od času posledného refreshu                        |
| **Výkon (performance)**     | ✅ Vysoký, optimalizované                       | ⚠️ Závisí od zložitosti dotazu                             | ✅ Vysoký pre SELECT, pomalý pre REFRESH                      |
| **Indexy**                  | ✅ Áno                                          | ❌ Nie                                                     | ✅ Áno – len na uložené dáta                                  |
| **Primárne/kľúče**          | ✅ Áno                                          | ❌ Nie                                                     | ❌ Nie, len cez indexy                                        |
| **CRUD operácie**           | ✅ Plne podporované                            | ⚠️ Často len SELECT                                        | ❌ Len SELECT                                                 |
| **Podpora RLS**             | ✅ Áno                                          | ⚠️ Nie priamo – cez podkladové tabuľky                     | ❌ Nie                                                        |
| **Vhodné použitie**         | Trvalé údaje, riadenie referenčnej integrity   | Zjednodušenie dotazov, pohľad na podmnožinu dát            | Predpočítané reporty, analýzy, dashboardy                    |
| **Automatická aktualizácia**| ✅ Áno                                          | ✅ Áno – vždy pri SELECT                                   | ❌ Nie – treba `REFRESH` ručne alebo cez cron/job             |
