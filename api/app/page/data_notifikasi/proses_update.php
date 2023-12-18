<?php 
require_once('../../../include/all_include.php');

$id_notifikasi=isset($_POST["id_notifikasi"]) ? $_POST["id_notifikasi"]:"";
$notifikasi=isset($_POST["notifikasi"]) ? $_POST["notifikasi"]:"";
$nama=isset($_POST["nama"]) ? $_POST["nama"]:"";
$status=isset($_POST["status"]) ? $_POST["status"]:"";


$sql = "UPDATE data_notifikasi SET 
notifikasi=?,
nama=?,
status=?,

WHERE id_notifikasi=?";

$stmt = $dbh->prepare($sql);
$stmt->execute([
$notifikasi,
$nama,
$status,

$id_notifikasi]);
$resp = [];
$resp["status"]="success";
echo (json_encode($resp)) 
?>
