use view_procedure ; -- database name



/*CREATE VIEW view_name AS
SELECT
	column1,
	column2,
	….
FROM
	table_name
WHERE
	condition*/

-- create tb_master_member
CREATE TABLE tb_master_member (
  tbmm_id int(11) NOT NULL,
  tbmm_firstname varchar(50) DEFAULT NULL,
  tbmm_lastname varchar(50) DEFAULT NULL,
  tbmm_gender varchar(20) DEFAULT NULL,
  tbmm_dob date DEFAULT NULL,
  tbmm_address varchar(100) DEFAULT NULL,
  tbmm_country varchar(20) DEFAULT NULL,
  PRIMARY KEY (tbmm_id)
);

-- insert tb_master_member

INSERT INTO view_procedure.tb_master_member
(tbmm_firstname, tbmm_lastname, tbmm_gender, tbmm_dob, tbmm_address, tbmm_country)
VALUES( 'Ridwan', 'Santoso', 'Pria', '2020-04-12', 'Jl. Nangka no 62, Rero', 'Indonesia'),
      ( 'Juli', 'Ani', 'Wanita', '1990-03-25', 'Jl. BUntu No 1', 'Indonesia');

-- create view
CREATE VIEW vw_customer AS
	SELECT tbmm_firstname, tbmm_gender
FROM tb_master_member
WHERE tbmm_country in ('Indonesia');

-- SELECT VIEW
SELECT * from vw_customer;


-- UPDATE VIEW
CREATE OR REPLACE
VIEW view_name AS
SELECT
	column1,
	column2,
	….
FROM
	table_name
WHERE
	condition;

CREATE OR REPLACE VIEW vw_customer AS
	SELECT tbmm_firstname, tbmm_gender, tbmm_address 
FROM tb_master_member
WHERE tbmm_country in ('Indonesia');

-- DROP VIEW
DROP VIEW vw_customer;

SELECT * FROM vw_customer;

-- Contoh Update value dalam view tapi not recomended
UPDATE
	vw_customer
set
	tbmm_firstname = 'Julia'
where
	tbmm_firstname = 'Juli';


-- Contoh INsert pada view -> tetapi tidak berhasil karena ada key yg tidak terisi
INSERT INTO vw_customer values ("Sony","Pria");


-- Contoh Complex View
CREATE VIEW vw_transaction AS
SELECT
	tbto.tbto_id,
	tbto.tbto_created_date,
	tbto .tbto_qty,
	tbmm.tbmm_firstname,
	tbmm.tbmm_lastname
FROM
	tb_transaction_order tbto
INNER JOIN tb_master_member tbmm 
ON
	tbto.tbto_member_id = tbmm.tbmm_id;


-- CREATE STORE PROCEDURE


CREATE PROCEDURE show_member()
BEGIN
	SELECT * FROM tb_master_member WHERE tbmm_country = 'Malaysia';
END;

-- CALL STORE PROCEDURE 
CALL show_member();



-- CREATE STORE PROCEDURE WITH PARAMETER
CREATE PROCEDURE show_member_param(IN country_filter varchar(20))
BEGIN
	SELECT * FROM tb_master_member WHERE tbmm_country = country_filter;
END;

-- PANGGIL SP WITH PARAM
CALL show_member_param('Indonesia');



-- CREATE STORE PROCEDURE WITH PARAMETER IN IN
CREATE PROCEDURE show_member_param_in(IN country_filter varchar(20), IN member_id_filter int)
BEGIN
	SELECT * FROM tb_master_member WHERE tbmm_country = country_filter and tbmm_id = member_id_filter;
END;

-- PANGGIL SP WITH PARAM
CALL show_member_param_in('Indonesia',2);


-- CREATE STORE PROCEDURE WITH PARAMETER IN OUT
CREATE PROCEDURE show_member_param_in_out(IN qty_filter INT, OUT total INT)
BEGIN
	SELECT count(tbto_id) INTO total FROM tb_transaction_order WHERE tbto_qty  = qty_filter;
END;

-- PANGGIL STORE PROCEDURE WITH PARAMETER IN OUT

CALL show_member_param_in_out(3,@total);

select @total;


-- INSERT DALAM STORE PROCEDURE
CREATE OR REPLACE PROCEDURE insert_barang()
BEGIN
	INSERT INTO tb_master_barang (tbmb_name,tbmb_harga,tbmb_stok) VALUES('Air MIneral B', 5000, 200);
END;

-- CALL INSERT SP
CALL insert_barang();


-- UPDATE DALAM STORE PROCEDURE
CREATE OR REPLACE PROCEDURE update_barang()
BEGIN
	UPDATE tb_master_barang SET tbmb_harga = 7000 WHERE tbmb_name ='Air MIneral B';
END;

-- CALL UPDATE SP
CALL update_barang();



-- DELETE DALAM STORE PROCEDURE
CREATE OR REPLACE PROCEDURE delete_barang()
BEGIN
	DELETE FROM tb_master_barang WHERE tbmb_name ='Air MIneral A';
END;

-- CALL DELETE SP
CALL delete_barang();

 

-- DROP STORE PROCEDURE
DROP PROCEDURE show_member; 






