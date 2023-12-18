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


$id_notifikasi = id_otomatis("data_notifikasi", "id_notifikasi", "10");
              $notifikasi=($_POST['notifikasi']);
              $nama=($_POST['nama']);
              
              $status=($_POST['status']);


$query = mysql_query("insert into data_notifikasi values (
'$id_notifikasi'
 ,'$notifikasi'
 ,'$nama'
 ,'$status'

)");

if ($query) {
    ?>
    <script>location.href = "<?php index(); ?>?input=popup_tambah";</script>
    <?php
} else {
    echo "GAGAL DIPROSES";
}
?>
