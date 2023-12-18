<?php
include '../../../include/koneksi/koneksi.php';

$tabel = $_GET['tabel'];
$field = $_GET['field'];

$result = mysql_query("SELECT COLUMN_TYPE FROM INFORMATION_SCHEMA.COLUMNS
       WHERE TABLE_SCHEMA = '$database' AND TABLE_NAME = '$tabel' AND COLUMN_NAME = '$field'")
    or die(mysql_error());

$row = mysql_fetch_array($result);
$enumList = explode(",", str_replace("'", "", substr($row['COLUMN_TYPE'], 5, (strlen($row['COLUMN_TYPE']) - 6))));


echo json_encode(['status' => 'success', 'result' => $enumList]);
