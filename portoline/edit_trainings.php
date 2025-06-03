<?php
include 'koneksi.php';

$id = $_POST['id'];
$title = $_POST['title'];
$description = $_POST['description'];
$company = $_POST['company'];
$price = $_POST['price'];

$image_url = $_POST['image_url']; // default
if (isset($_FILES['image'])) {
    $filename = uniqid() . '_' . $_FILES['image']['name'];
    $path = "uploads/" . $filename;
    move_uploaded_file($_FILES['image']['tmp_name'], $path);
    $image_url = $path;
}

$sql = "UPDATE trainings SET 
        title='$title',
        description='$description',
        company_name='$company',
        price='$price',
        image_url='$image_url'
        WHERE id='$id'";

if ($conn->query($sql) === TRUE) {
    echo json_encode(["success" => true]);
} else {
    echo json_encode(["success" => false]);
}
?>
