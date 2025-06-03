<?php
include 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(["status" => "error", "message" => "Method Not Allowed"]);
    exit();
}

if (
    empty($_POST['judul']) || empty($_POST['deskripsi']) || empty($_POST['perusahaan']) ||
    empty($_POST['harga']) || empty($_POST['trainer_id']) || !isset($_FILES['image'])
) {
    http_response_code(400);
    echo json_encode(["status" => "error", "message" => "Semua data wajib diisi."]);
    exit();
}

$judul = $_POST['judul'];
$deskripsi = $_POST['deskripsi'];
$perusahaan = $_POST['perusahaan'];
$harga = $_POST['harga'];
$trainer_id = $_POST['trainer_id'];

// Handle file upload
$uploadDir = "uploads/";
$imageName = uniqid() . "_" . basename($_FILES["image"]["name"]);
$targetFile = $uploadDir . $imageName;

if (!move_uploaded_file($_FILES["image"]["tmp_name"], $targetFile)) {
    http_response_code(500);
    echo json_encode(["status" => "error", "message" => "Gagal upload gambar."]);
    exit();
}

// Simpan ke database
$stmt = $conn->prepare("INSERT INTO trainings (judul, deskripsi, perusahaan, harga, image, trainer_id) VALUES (?, ?, ?, ?, ?, ?)");
$stmt->bind_param("sssssi", $judul, $deskripsi, $perusahaan, $harga, $imageName, $trainer_id);

if ($stmt->execute()) {
    echo json_encode(["status" => "success", "message" => "Pelatihan berhasil disimpan"]);
} else {
    http_response_code(500);
    echo json_encode(["status" => "error", "message" => "Gagal menyimpan pelatihan"]);
}
?>
