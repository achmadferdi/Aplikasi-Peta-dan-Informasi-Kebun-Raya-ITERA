<?php

require_once('../../../include/all_include.php');

$resp = [];
$resp["status"] = "success";
$resp["result"] = array();

$id_pengguna =  $_POST['id_pengguna'];

$query = "select * from data_pengguna WHERE id_pengguna='$id_pengguna'";

$proses = mysql_query($query);
while ($data = mysql_fetch_array($proses)) {

	$id_pengguna = $data["id_pengguna"];
	$hasil['id_pengguna'] = $id_pengguna;
	$hasil['nama'] = $data["nama"];
	$hasil['alamat'] = $data["alamat"];
	$hasil['jenis_kelamin'] = $data["jenis_kelamin"];
	$hasil['no_telepon'] = $data["no_telepon"];
	$hasil['username'] = $data["username"];
	$hasil['password'] = $data["password"];

	array_push($resp["result"], $hasil);
}

json_print($resp);
