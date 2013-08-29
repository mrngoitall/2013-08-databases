-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'patrons'
-- 
-- ---

DROP TABLE IF EXISTS patrons;
		
CREATE TABLE patrons (
  patron_id MEDIUMINT NOT NULL AUTO_INCREMENT,
  patron_join_date DATETIME NULL DEFAULT NULL,
  patron_first_name VARCHAR(200)NULL DEFAULT NULL,
  patron_last_name VARCHAR(200)NULL DEFAULT NULL,
  patron_address VARCHAR(200)NULL DEFAULT NULL,
  patron_city VARCHAR(200)NULL DEFAULT NULL,
  patron_state VARCHAR(2) NULL DEFAULT NULL,
  patron_zip MEDIUMINT NULL DEFAULT NULL,
  patron_cell_phone INT NULL DEFAULT NULL,
  patron_home_phone INT NULL DEFAULT NULL,
  patron_work_phone INT NULL DEFAULT NULL,
  patron_deactivated_date TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (patron_id)
);

-- ---
-- Table 'book_catalog'
-- Table of all books in the library (informational)
-- ---

DROP TABLE IF EXISTS book_catalog;
		
CREATE TABLE book_catalog (
  book_id INT NOT NULL AUTO_INCREMENT,
  book_title VARCHAR(200)NULL DEFAULT NULL,
  book_author_first VARCHAR(200)NULL DEFAULT NULL,
  book_author_last VARCHAR(200)NULL DEFAULT NULL,
  book_publish_date TIMESTAMP NULL DEFAULT NULL,
  book_isbn BIGINT NULL DEFAULT NULL,
  book_lccn VARCHAR(200)NULL DEFAULT NULL,
  PRIMARY KEY (book_id)
) COMMENT 'Table of all books in the library (informational)';

-- ---
-- Table 'book_circ_status'
-- Table of all books (including duplicate copies) in the library, including status of each copy.
-- ---

DROP TABLE IF EXISTS book_circ_status;
		
CREATE TABLE book_circ_status (
  book_circ_status_id INT NOT NULL AUTO_INCREMENT,
  book_circ_id INT NULL DEFAULT NULL,
  book_status_id SMALLINT NOT NULL,
  patron_id MEDIUMINT NULL DEFAULT NULL,
  book_circ_loan_date DATETIME NULL DEFAULT NULL,
  book_circ_due_date DATETIME NULL DEFAULT NULL,
  book_circ_removed_date DATETIME NULL DEFAULT NULL,
  book_circ_status_seq_no INT NULL DEFAULT NULL,
  PRIMARY KEY (book_circ_status_id)
) COMMENT 'Table of all books (including duplicate copies) in the libra';

-- ---
-- Table 'book_status'
-- 
-- ---

DROP TABLE IF EXISTS book_status;
		
CREATE TABLE book_status (
  book_status_id SMALLINT NOT NULL AUTO_INCREMENT,
  book_status VARCHAR(200)NULL DEFAULT NULL,
  PRIMARY KEY (book_status_id)
);

-- ---
-- Table 'holds'
-- Prevents patrons from checking out new material. 
-- ---

DROP TABLE IF EXISTS holds;
		
CREATE TABLE holds (
  hold_id INT NOT NULL AUTO_INCREMENT,
  patron_id MEDIUMINT NULL DEFAULT NULL,
  hold_type_id TINYINT NULL DEFAULT NULL,
  book_circ_status_id INT NULL DEFAULT NULL,
  hold_fee DECIMAL NULL DEFAULT NULL,
  hold_status TINYINT NULL DEFAULT NULL,
  hold_established_date DATETIME NULL DEFAULT NULL,
  hold_release_date DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (hold_id)
) COMMENT 'Prevents patrons from checking out new material. ';

-- ---
-- Table 'fees'
-- Fees associated with a particular patron (from material checkout fees, to late fees)
-- ---

DROP TABLE IF EXISTS fees;
		
CREATE TABLE fees (
  fee_id TINYINT NOT NULL AUTO_INCREMENT,
  fee_type_id TINYINT NULL DEFAULT NULL,
  patron_id MEDIUMINT NULL DEFAULT NULL,
  fee_amount DECIMAL NULL DEFAULT NULL,
  fee_paid_amount DECIMAL NULL DEFAULT NULL,
  PRIMARY KEY (fee_id)
) COMMENT 'Fees associated with a particular patron (from material chec';

-- ---
-- Table 'hold_types'
-- Late book, damaged book, miscellaneous bans, etc.
-- ---

DROP TABLE IF EXISTS hold_types;
		
CREATE TABLE hold_types (
  hold_type_id TINYINT NOT NULL AUTO_INCREMENT,
  hold_type VARCHAR(200)NULL DEFAULT NULL,
  hold_fee SMALLINT NULL DEFAULT NULL,
  PRIMARY KEY (hold_type_id)
) COMMENT 'Late book, damaged book, miscellaneous bans, etc.';

-- ---
-- Table 'fee_types'
-- 
-- ---

DROP TABLE IF EXISTS fee_types;
		
CREATE TABLE fee_types (
  fee_type_id TINYINT NOT NULL AUTO_INCREMENT,
  fee_type VARCHAR(200)NULL DEFAULT NULL,
  PRIMARY KEY (fee_type_id)
);

-- ---
-- Table 'book_circ'
-- 
-- ---

DROP TABLE IF EXISTS book_circ;
		
CREATE TABLE book_circ (
  book_circ_id INT NOT NULL AUTO_INCREMENT,
  book_id INT NULL DEFAULT NULL,
  book_circ_barcode INT NULL DEFAULT NULL,
  book_circ_call_no VARCHAR(200)NULL DEFAULT NULL,
  PRIMARY KEY (book_circ_id)
);

-- ---
-- Table 'keywords'
-- 
-- ---

DROP TABLE IF EXISTS keywords;
		
CREATE TABLE keywords (
  keyword_id INT NOT NULL AUTO_INCREMENT,
  keyword VARCHAR(200)NULL DEFAULT NULL,
  PRIMARY KEY (keyword_id)
);

-- ---
-- Table 'book_keywords'
-- 
-- ---

DROP TABLE IF EXISTS book_keywords;
		
CREATE TABLE book_keywords (
  book_keywords_id INT NOT NULL AUTO_INCREMENT,
  book_id INT NULL DEFAULT NULL,
  keyword_id INT NULL DEFAULT NULL,
  PRIMARY KEY (book_keywords_id)
);

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE book_circ_status ADD FOREIGN KEY (book_circ_id) REFERENCES book_circ (book_circ_id);
ALTER TABLE book_circ_status ADD FOREIGN KEY (book_status_id) REFERENCES book_status (book_status_id);
ALTER TABLE book_circ_status ADD FOREIGN KEY (patron_id) REFERENCES patrons (patron_id);
ALTER TABLE holds ADD FOREIGN KEY (patron_id) REFERENCES patrons (patron_id);
ALTER TABLE holds ADD FOREIGN KEY (hold_type_id) REFERENCES hold_types (hold_type_id);
ALTER TABLE holds ADD FOREIGN KEY (book_circ_status_id) REFERENCES book_circ_status (book_circ_status_id);
ALTER TABLE fees ADD FOREIGN KEY (fee_type_id) REFERENCES fee_types (fee_type_id);
ALTER TABLE fees ADD FOREIGN KEY (patron_id) REFERENCES patrons (patron_id);
ALTER TABLE book_circ ADD FOREIGN KEY (book_id) REFERENCES book_catalog (book_id);
ALTER TABLE book_keywords ADD FOREIGN KEY (book_id) REFERENCES book_catalog (book_id);
ALTER TABLE book_keywords ADD FOREIGN KEY (keyword_id) REFERENCES keywords (keyword_id);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE patrons ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE book_catalog ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE book_circ_status ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE book_status ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE holds ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE fees ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE hold_types ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE fee_types ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE book_circ ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE keywords ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE book_keywords ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO patrons (patron_id,patron_join_date,patron_first_name,patron_last_name,patron_address,patron_city,patron_state,patron_zip,patron_cell_phone,patron_home_phone,patron_work_phone,patron_deactivated_date) VALUES
-- ('','','','','','','','','','','','');
-- INSERT INTO book_catalog (book_id,book_title,book_author_first,book_author_last,book_publish_date,book_isbn,book_lccn) VALUES
-- ('','','','','','','');
-- INSERT INTO book_circ_status (book_circ_status_id,book_circ_id,book_status,patron_id,book_circ_loan_date,book_circ_due_date,book_circ_removed_date,book_circ_status_seq_no) VALUES
-- ('','','','','','','','');
-- INSERT INTO book_status (book_status_id,book_status) VALUES
-- ('','');
-- INSERT INTO holds (hold_id,patron_id,hold_type_id,book_circ_status_id,hold_fee,hold_status,hold_established_date,hold_release_date) VALUES
-- ('','','','','','','','');
-- INSERT INTO fees (fee_id,fee_type_id,patron_id,fee_amount,fee_paid_amount) VALUES
-- ('','','','','');
-- INSERT INTO hold_types (hold_type_id,hold_type,hold_fee) VALUES
-- ('','','');
-- INSERT INTO fee_types (fee_type_id,fee_type) VALUES
-- ('','');
-- INSERT INTO book_circ (book_circ_id,book_id,book_circ_barcode,book_circ_call_no) VALUES
-- ('','','','');
-- INSERT INTO keywords (keyword_id,keyword) VALUES
-- ('','');
-- INSERT INTO book_keywords (book_keywords_id,book_id,keyword_id) VALUES
-- ('','','');

