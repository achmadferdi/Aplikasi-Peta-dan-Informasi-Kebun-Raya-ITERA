<?php 
require_once('../../../include/all_include.php');

$id_lokasi=isset($_POST["id_lokasi"]) ? $_POST["id_lokasi"]:"";
$nama=isset($_POST["nama"]) ? $_POST["nama"]:"";
$foto1=isset($_POST["foto1"]) ? $_POST["foto1"]:"";
$foto2=isset($_POST["foto2"]) ? $_POST["foto2"]:"";
$deskripsi=isset($_POST["deskripsi"]) ? $_POST["deskripsi"]:"";


$query=mysql_query("insert into data_lokasi values (
'$id_lokasi'
,'$nama'
,'$foto1'
,'$foto2'
,'$deskripsi'

)");

$resp = [];
if($query){
	$resp["status"]="success";
}
else
{
	$resp["status"]="gagal";
}

echo (json_encode($resp)) 
?>
