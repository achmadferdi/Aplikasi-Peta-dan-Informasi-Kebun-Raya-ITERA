<?php
include '../../../include/all_include.php';

if (!isset($_POST['id_pengguna'])) {
        
    ?>
    <script>
        alert("AKSES DITOLAK");
        location.href = "index.php";
    </script>
    <?php
    die();
}

$id_pengguna = xss($_POST['id_pengguna']);
$nama = xss($_POST['nama']);
$alamat = xss($_POST['alamat']);
$jenis_kelamin = xss($_POST['jenis_kelamin']);
$no_telepon = xss($_POST['no_telepon']);
$username = xss($_POST['username']);
$password = md5($_POST['password']);


$query = mysql_query("update data_pengguna set 
nama='$nama',
alamat='$alamat',
jenis_kelamin='$jenis_kelamin',
no_telepon='$no_telepon',
username='$username',
password='$password'

where id_pengguna='$id_pengguna' ") or die(mysql_error());

if ($query) {
    ?>
    <script>location.href = "<?php index(); ?>?input=popup_edit";</script>
    <?php
} else {
    echo "GAGAL DIPROSES";
}
?>
