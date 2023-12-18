<a href="<?php index(); ?>">
    <?php btn_kembali(' KEMBALI'); ?>
</a>

<br><br>

<div class="content-box">
    <div class="content-box-content">
        <table <?php tabel_in(100, '%', 0, 'center'); ?>>
            <tbody>

                <?php
                if (!isset($_GET['proses'])) {

                ?>
                    <script>
                        alert("AKSES DITOLAK");
                        location.href = "index.php";
                    </script>
                <?php
                    die();
                }
                $proses = decrypt(mysql_real_escape_string($_GET['proses']));
                $sql = mysql_query("SELECT * FROM data_notifikasi where id_notifikasi = '$proses'");
                $data = mysql_fetch_array($sql);
                ?>
                <!--h
            <tr>
                <td class="clleft" width="25%">Id Notifikasi </td>
                <td class="clleft" width="2%">:</td>
                <td class="clleft"><?php echo $data['id_notifikasi']; ?></td>	
            </tr>
           h-->

                <tr>
                    <td class="clleft" width="25%">Notifikasi </td>
                    <td class="clleft" width="2%">:</td>
                    <td class="clleft"><?php echo $data['notifikasi']; ?></td>
                </tr>
                <tr>
                    <td class="clleft" width="25%">Nama </td>
                    <td class="clleft" width="2%">:</td>
                    <td class="clleft">
                        <?php
                        echo baca_database("", "nama", "SELECT * FROM data_pengguna WHERE id_pengguna='$data[nama]'");
                        ?>
                    </td>
                </tr>
                 <tr>
                    <td class="clleft" width="25%">Nomor Telepon </td>
                    <td class="clleft" width="2%">:</td>
                    <td class="clleft"><?php echo baca_database("","no_telepon","select * from data_pengguna where id_pengguna = '$data[nama]'"); ?></td>
                </tr>
                <tr>
                    <td class="clleft" width="25%">Status </td>
                    <td class="clleft" width="2%">:</td>
                    <td class="clleft"><?php echo $data['status']; ?></td>
                </tr>




            </tbody>
        </table>
    </div>
</div>