<?php 
require_once('../../../include/all_include.php');

$id_lokasi=isset($_POST["id_lokasi"]) ? $_POST["id_lokasi"]:"";
$nama=isset($_POST["nama"]) ? $_POST["nama"]:"";
$foto1=isset($_POST["foto1"]) ? $_POST["foto1"]:"";
$foto2=isset($_POST["foto2"]) ? $_POST["foto2"]:"";
$deskripsi=isset($_POST["deskripsi"]) ? $_POST["deskripsi"]:"";


$sql = "UPDATE data_lokasi SET 
nama=?,
foto1=?,
foto2=?,
deskripsi=?,

WHERE id_lokasi=?";

$stmt = $dbh->prepare($sql);
$stmt->execute([
$nama,
$foto1,
$foto2,
$deskripsi,

$id_lokasi]);
$resp = [];
$resp["status"]="success";
echo (json_encode($resp)) 
?>
