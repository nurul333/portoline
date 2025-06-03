<?php
include 'koneksi.php';

$id = $_POST['id'];

$sql = "DELETE FROM trainings WHERE id='$id'";
if ($conn->query($sql) === TRUE) {
    echo json_encode(["success" => true]);
} else {
    echo json_encode(["success" => false]);
}
?>
