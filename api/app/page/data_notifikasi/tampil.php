<?php

require_once('../../../include/all_include.php');

$resp = [];
$resp["status"] = "success";
$resp["result"] = array();

$id_pengguna = $_POST['id_pengguna'];

$whereId = "nama = '$id_pengguna'";

if (isset($_POST['berdasarkan']) && !empty($_POST['berdasarkan']) && isset($_POST['isi']) && !empty($_POST['isi'])) {
	$berdasarkan =  mysql_real_escape_string($_POST['berdasarkan']);
	$isi =  mysql_real_escape_string($_POST['isi']);
	$limit =  mysql_real_escape_string($_POST['limit']);
	$hal =  mysql_real_escape_string($_POST['hal']);
	if (isset($_POST['dari']) && !empty($_POST['dari']) && isset($_POST['sampai']) && !empty($_POST['sampai'])) {
		$dari =  mysql_real_escape_string($_POST['dari']);
		$sampai =  mysql_real_escape_string($_POST['sampai']);
		$query = "SELECT * FROM data_notifikasi where $berdasarkan like '%$isi%' and $whereId";
	} else {
		$query = "SELECT * FROM data_notifikasi where $berdasarkan like '%$isi%' abd $whereId";
	}
} else {
	$query = "select * from data_notifikasi where $whereId";
}

$proses = mysql_query($query);
while ($data = mysql_fetch_array($proses)) {

	$id_notifikasi = $data["id_notifikasi"];
	$hasil['id_notifikasi'] = $id_notifikasi;
	$hasil['notifikasi'] = $data["notifikasi"];
	$hasil['nama'] = baca_database("", "nama", "select * from data_pengguna where id_pengguna = '$data[nama]'");
	$hasil['id_pengguna'] = $data["nama"];
	$hasil['status'] = $data["status"];

	array_push($resp["result"], $hasil);
}

json_print($resp);
