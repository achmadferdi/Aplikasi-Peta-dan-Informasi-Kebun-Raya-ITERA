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


$id_pengguna = id_otomatis("data_pengguna", "id_pengguna", "10");
              $nama=xss($_POST['nama']);
              $alamat=xss($_POST['alamat']);
              $jenis_kelamin=xss($_POST['jenis_kelamin']);
              $no_telepon=xss($_POST['no_telepon']);
              $username=xss($_POST['username']);
              $password=md5($_POST['password']);


$query = mysql_query("insert into data_pengguna values (
'$id_pengguna'
 ,'$nama'
 ,'$alamat'
 ,'$jenis_kelamin'
 ,'$no_telepon'
 ,'$username'
 ,'$password'

)");

if ($query) {
    ?>
    <script>location.href = "<?php index(); ?>?input=popup_tambah";</script>
    <?php
} else {
    echo "GAGAL DIPROSES";
}
?>
