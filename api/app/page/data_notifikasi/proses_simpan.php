<?php
require_once('../../../include/all_include.php');

$id_notifikasi = id_otomatis("data_notifikasi", "id_notifikasi", "20"); //isset($_POST["id_notifikasi"]) ? $_POST["id_notifikasi"] : "";
$notifikasi = isset($_POST["notifikasi"]) ? $_POST["notifikasi"] : "";
$nama = isset($_POST["nama"]) ? $_POST["nama"] : "";
$status = "proses"; //isset($_POST["status"]) ? $_POST["status"] : "";

$notifikasi = xss($notifikasi);

$query = mysql_query("INSERT into data_notifikasi values (
	'$id_notifikasi'
	,'$notifikasi'
	,'$nama'
	,'$status'

)");

$resp = [];
if ($query) {
	$resp["status"] = "success";
} else {
	$resp["status"] = "gagal";
	$resp["error"] = mysql_error();
	$resp["sql"] = "INSERT into data_notifikasi values (
		'$id_notifikasi'
		,'$notifikasi'
		,'$nama'
		,'$status'
	
	)";
}

echo (json_encode($resp));
