<?php
include '../../../include/all_include.php';

if (!isset($_POST['id_lokasi'])) {
?>
    <script>
        alert("AKSES DITOLAK");
        location.href = "index.php";
    </script>
<?php
    die();
}


$id_lokasi = id_otomatis("data_lokasi", "id_lokasi", "10");
$nama = xss($_POST['nama']);
$foto1 = upload('foto1');
$foto2 = upload('foto2');
$deskripsi = xss($_POST['deskripsi']);
$lat = xss($_POST['lat']);
$lng = xss($_POST['lng']);


$query = mysql_query("insert into data_lokasi values (
'$id_lokasi'
 ,'$nama'
 ,'$foto1'
 ,'$foto2'
 ,'$deskripsi'
 ,'$lat'
 ,'$lng'

)");

if ($query) {
?>
    <script>
        location.href = "<?php index(); ?>?input=popup_tambah";
    </script>
<?php
} else {
    echo "GAGAL DIPROSES";
}
?>