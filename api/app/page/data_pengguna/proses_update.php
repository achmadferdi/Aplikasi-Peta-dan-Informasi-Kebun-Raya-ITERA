<?php

require_once('../../../include/all_include.php');

$id_pengguna = isset($_POST["id_pengguna"]) ? $_POST["id_pengguna"] : "";
$nama = isset($_POST["nama"]) ? $_POST["nama"] : "";
$alamat = isset($_POST["alamat"]) ? $_POST["alamat"] : "";
$jenis_kelamin = isset($_POST["jenis_kelamin"]) ? $_POST["jenis_kelamin"] : "";
$no_telepon = isset($_POST["no_telepon"]) ? $_POST["no_telepon"] : "";
$username = isset($_POST["username"]) ? $_POST["username"] : "";
$password = isset($_POST["password"]) ? $_POST["password"] : "";

if (strlen($password) > 0) {

    $password = md5($password);

    $sql = "UPDATE data_pengguna SET 
    nama=?,
    alamat=?,
    jenis_kelamin=?,
    no_telepon=?,
    username=?,
    password=?

    WHERE id_pengguna=?";

    $stmt = $dbh->prepare($sql);
    $stmt->execute([
        $nama,
        $alamat,
        $jenis_kelamin,
        $no_telepon,
        $username,
        $password,

        $id_pengguna
    ]);
} else {
    $sql = "UPDATE data_pengguna SET 
    nama=?,
    alamat=?,
    jenis_kelamin=?,
    no_telepon=?,
    username=?

    WHERE id_pengguna=?";

    $stmt = $dbh->prepare($sql);
    $stmt->execute([
        $nama,
        $alamat,
        $jenis_kelamin,
        $no_telepon,
        $username,
        $id_pengguna
    ]);
}

$resp = [];
$resp["status"] = "success";
echo (json_encode($resp));
