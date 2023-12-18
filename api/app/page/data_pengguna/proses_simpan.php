<?php
require_once('../../../include/all_include.php');

$id_pengguna = id_otomatis("id_pengguna", "data_pengguna", "10"); //isset($_POST["id_pengguna"]) ? $_POST["id_pengguna"] : "";
$nama = isset($_POST["nama"]) ? $_POST["nama"] : "";
$alamat = isset($_POST["alamat"]) ? $_POST["alamat"] : "";
$jenis_kelamin = isset($_POST["jenis_kelamin"]) ? $_POST["jenis_kelamin"] : "";
$no_telepon = isset($_POST["no_telepon"]) ? $_POST["no_telepon"] : "";
$username = isset($_POST["username"]) ? $_POST["username"] : "";
$password = isset($_POST["password"]) ? $_POST["password"] : "";
$password = md5($password);

$query = mysql_query("insert into data_pengguna values (
'$id_pengguna'
,'$nama'
,'$alamat'
,'$jenis_kelamin'
,'$no_telepon'
,'$username'
,'$password'

)");

$resp = [];
if ($query) {
	$resp["status"] = "success";
} else {
	$resp["status"] = "gagal";
}

echo (json_encode($resp));
