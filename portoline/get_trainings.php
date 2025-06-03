<?php
header('Content-Type: application/json');
include 'koneksi.php';

if (!isset($_GET['trainer_id'])) {
    echo json_encode(["error" => "trainer_id is required"]);
    exit;
}

$trainer_id = $_GET['trainer_id'];

// Amankan query pakai prepared statement
$stmt = $conn->prepare("SELECT judul, perusahaan, deskripsi, harga, image FROM trainings WHERE trainer_id = ?");
$stmt->bind_param("s", $trainer_id);
$stmt->execute();
$result = $stmt->get_result();

$trainings = [];

while ($row = $result->fetch_assoc()) {
    $row['image_url'] = "http://192.168.56.1/proyek2_mobile/portoline/uploads/" . $row['image'];
    $trainings[] = $row;
}

echo json_encode($trainings);
?>
