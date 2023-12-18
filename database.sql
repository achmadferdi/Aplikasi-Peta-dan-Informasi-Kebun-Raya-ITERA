CREATE DATABASE databases_fredi_pemetaan_kebun_raya_itera ;

USE databases_fredi_pemetaan_kebun_raya_itera ;

CREATE TABLE data_admin (
);

CREATE TABLE data_pengguna (
id_pengguna varchar(50),
nama varchar(100),
alamat tinytext,
jenis_kelamin enum('laki-laki','perempuan'),
no_telepon varchar(15),
username varchar(50),
password varchar(100)
);

CREATE TABLE data_lokasi (
id_lokasi varchar(100),
nama varchar(100),
foto1 varchar(250),
foto2 varchar(250),
deskripsi text
);

CREATE TABLE data_notifikasi (
id_notifikasi varchar(50),
notifikasi varchar(100),
nama varchar(100),
  status enum('proses','selesai')
);