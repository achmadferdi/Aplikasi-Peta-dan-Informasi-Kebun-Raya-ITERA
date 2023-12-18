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

$id_lokasi = xss($_POST['id_lokasi']);
$nama = xss($_POST['nama']);
$foto1 = ($_FILES['foto1']['name']);
if (empty($foto1)) {
    $foto1 = $_POST['foto11'];
} else {
    $foto1 = upload('foto1');
};
$foto2 = ($_FILES['foto2']['name']);
if (empty($foto2)) {
    $foto2 = $_POST['foto21'];
} else {
    $foto2 = upload('foto2');
};
$deskripsi = xss($_POST['deskripsi']);
$lat = xss($_POST['lat']);
$lng = xss($_POST['lng']);

$query = mysql_query("update data_lokasi set 
nama='$nama',
foto1='$foto1',
foto2='$foto2',
lat='$lat',
lng='$lng',
deskripsi='$deskripsi'

where id_lokasi='$id_lokasi' ") or die(mysql_error());

if ($query) {
?>
    <script>
        location.href = "<?php index(); ?>?input=popup_edit";
    </script>
<?php
} else {
    echo "GAGAL DIPROSES";
}
?>