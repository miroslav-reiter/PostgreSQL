-- Inner join vnutorne spojenie, ziska iba riadky, ktore maju zhodu
SELECT
	z.id, o.zakaznik_id, z.meno, o.datum, o.cena
FROM
	testovacie_data_joiny_zakaznici as z
inner join testovacie_data_joiny_objednavky as o
on z.id = o.zakaznik_id;

-------------------------------------------------------------
-- Left  join lave spojenie, z lavej tabulky a prida udaje z pravej, ak existuje zhoda, inak sa vlozi null
select z.id, z.meno, o.datum, o.cena
from testovacie_data_joiny_zakaznici as z
left join testovacie_data_joiny_objednavky as o
on z.id = o.zakaznik_id;

-------------------------------------------------------------
-- Right  join prave spojenie, z pravej tabulky a prida udaje z lavej, ak existuje zhoda, inak sa vlozi null
select z.id, z.meno, o.datum, o.cena
from testovacie_data_joiny_zakaznici as z
right join testovacie_data_joiny_objednavky as o
on z.id = o.zakaznik_id;

-------------------------------------------------------------
-- Full outer  join vonkajsie spojenie, zahrneie vstetky riadky z oboch tabuliek a vyplnala chybajuce hodnoty null, ak nie je zhoda
select z.id, z.meno, o.datum, o.cena
from testovacie_data_joiny_zakaznici as z
full outer join testovacie_data_joiny_objednavky as o
on z.id = o.zakaznik_id;

-- Cross join kartezsky sucin, zahrnie vstetky riadky z oboch tabuliek a vyplnala chybajuce hodnoty null, ak nie je zhoda
select *
from testovacie_data_marketing as m
cross join testovacie_data_joiny_produkty as p;


-- Self join, tabulka sa spoji samo so sebou
select a.meno as zamestnanec, b.meno as sef
from testovacie_data_joiny_zamestnanci a
left join testovacie_data_joiny_zamestnanci b
on a.sef_id = b.id

-- Klazula using namiesto on, ak maju oba stlpce rovnake meno

SELECT
	z.meno, o.datum, o.cena
FROM
	testovacie_data_joiny_zakaznici as z
inner join testovacie_data_joiny_objednavky as o
using (id);
-- on z.id = o.zakaznik_id;

