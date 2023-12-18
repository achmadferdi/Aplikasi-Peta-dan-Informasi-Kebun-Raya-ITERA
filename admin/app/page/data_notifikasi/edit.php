<a href="<?php index(); ?>">
    <?php btn_kembali(' KEMBALI KE HALAMAN SEBELUMNYA'); ?>
</a>

<div class="col-sm-12" style="margin-bottom: 20px; margin-top: 20px;">
    <div class="alert alert-warning">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">x</button>
        <strong>Edit Data Notifikasi </strong>
        <hr class="message-inner-separator">
        <p>Silahkan Update Data Notifikasi dibawah ini.</p>
    </div>
</div>


<div class="content-box">
    <form action="proses_update.php" enctype="multipart/form-data" method="post">
        <div class="content-box-content">
            <div id="postcustom">
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
                        <td width="25%" class="leftrowcms">					
                            <label >Id Notifikasi  <font color="red">*</font></label>
                        </td>
                        <td width="2%">:</td>
                        <td>
                           <?php echo $data['id_notifikasi']; ?>	
                        </td>
                    </tr>
                    h-->
                        <input type="hidden" class="form-control" name="id_notifikasi" value="<?php echo $data['id_notifikasi']; ?>" readonly id="id_notifikasi" required="required">

                        <tr>
                            <td width="25%" class="leftrowcms">
                                <label>Notifikasi <span class="highlight"></span></label>
                            </td>
                            <td width="2%">:</td>
                            <td>
                                <textarea class="ckeditor" style="width:50%" type="varchar" name="notifikasi" id="notifikasi" placeholder="Notifikasi " required="required" value="">
                                <?php echo ($data['notifikasi']); ?>
                                </textarea>
                                
                            </td>
                        </tr>
                        <tr>
                            <td width="25%" class="leftrowcms">
                                <label>Nama <span class="highlight"></span></label>
                            </td>
                            <td width="2%">:</td>
                            <td>
                                <select class="form-control" style="width:50%" type="varchar" name="nama" id="nama" placeholder="Nama " required="required" value="<?php echo ($data['nama']); ?>">
                                    <option value="<?= $data['nama'] ?>">
                                        - <?= $data['nama'] ?> ( <?php
                                                                echo baca_database("", "nama", "SELECT * FROM data_pengguna WHERE id_pengguna='$data[nama]'");
                                                                ?> ) -
                                    </option>
                                    <?php
                                    combo_database2("data_pengguna", "id_pengguna", "nama", "SELECT * FROM data_pengguna WHERE id_pengguna <> '$data[nama]'");
                                    ?>
                                </select>
                            </td>
                        </tr>
                     
                        <tr>
                            <td width="25%" class="leftrowcms">
                                <label>Status <span class="highlight"></span></label>
                            </td>
                            <td width="2%">:</td>
                            <td>
                                <select class="form-control" style="width:50%" type="text" name="status" id="status" placeholder="Status " required="required">
                                    <option value="<?php echo ($data['status']); ?>">- <?php echo ($data['status']); ?> -</option><?php combo_enum('data_notifikasi', 'status', ''); ?>
                                </select>
                            </td>
                        </tr>


                    </tbody>
                </table>
                <div class="content-box-content">
                    <center>
                        <?php btn_update(' PROSES UPDATE DATA'); ?>
                    </center>
                </div>
            </div>
        </div>
    </form>