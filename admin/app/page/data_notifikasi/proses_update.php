<?php
include '../../../include/all_include.php';

if (!isset($_POST['id_notifikasi'])) {
        
    ?>
    <script>
        alert("AKSES DITOLAK");
        location.href = "index.php";
    </script>
    <?php
    die();
}

$id_notifikasi = xss($_POST['id_notifikasi']);
$notifikasi = ($_POST['notifikasi']);
$nama = xss($_POST['nama']);

$status = xss($_POST['status']);


$query = mysql_query("update data_notifikasi set 
notifikasi='$notifikasi',
nama='$nama',

status='$status'

where id_notifikasi='$id_notifikasi' ") or die(mysql_error());

if ($query) {
    ?>
    <script>location.href = "<?php index(); ?>?input=popup_edit";</script>
    <?php
} else {
    echo "GAGAL DIPROSES";
}
?>
