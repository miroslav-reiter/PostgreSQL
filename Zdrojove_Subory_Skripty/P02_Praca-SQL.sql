-- Vytvaraci dopyt 
CREATE TABLE ZAKAZNICI (
	ID_ZAKAZNICI SERIAL PRIMARY KEY,
	MENO VARCHAR(50),
	PRIEZVISKO VARCHAR(70),
	DATUM_REGISTRACIE DATE,
	VIP BOOLEAN
);

-- Vytvaraci dopyt 
CREATE TABLE STUDENTI (
	ID_STUDENT SERIAL PRIMARY KEY,
	MENO VARCHAR(50),
	PRIEZVISKO VARCHAR(70),
	VEK INT,
	KURZ VARCHAR(100)
);

-- Upravovaci dopyt 
ALTER TABLE STUDENTI
ADD COLUMN EMAIL VARCHAR(100);

ALTER TABLE STUDENTI
DROP COLUMN VEK;

-- Vyberovy dopyt
SELECT
	*
FROM
	STUDENTI;

-- Vkladaci dopyt
insert into studenti (meno, priezvisko, kurz, email)
values 
('Adam', 'Sangala', 'PostgreSQL I. Zaciatok', 'adam@nieco.sk'),
('Igor', 'Sangala', 'DataScience I. Zaciatok', 'igor@nieco.sk'),
('Eva', 'Mila', 'PostgreSQL I. Zaciatok', 'eva@nieco.sk'),
('Maria', 'Mocna', 'DataScience I. Zaciatok', 'maria@nieco.sk');

