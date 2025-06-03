<?php
header('Content-Type: application/json');
require_once 'koneksi.php';

$data = $_POST;

$user_id = $data['user_id'] ?? '';
$name = $data['name'] ?? '';
$email = $data['email'] ?? '';
$dob = $data['dob'] ?? '';
$hobby = $data['hobby'] ?? '';
$profile_image_base64 = $data['profile_image_base64'] ?? '';
$certificates_base64 = $data['certificates_base64'] ?? '[]';

// Cek apakah data untuk user_id sudah ada
$check = $conn->prepare("SELECT id FROM jobseeker_profile WHERE user_id = ?");
$check->bind_param("s", $user_id);
$check->execute();
$checkResult = $check->get_result();

if ($checkResult->num_rows > 0) {
    // update
    $query = "UPDATE jobseeker_profile SET name=?, email=?, dob=?, hobby=?, profile_image_base64=?, certificates_base64=? WHERE user_id=?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("sssssss", $name, $email, $dob, $hobby, $profile_image_base64, $certificates_base64, $user_id);
} else {
    // insert
    $query = "INSERT INTO jobseeker_profile (user_id, name, email, dob, hobby, profile_image_base64, certificates_base64)
              VALUES (?, ?, ?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("sssssss", $user_id, $name, $email, $dob, $hobby, $profile_image_base64, $certificates_base64);
}

if ($stmt->execute()) {
    echo json_encode(['success' => true]);
} else {
    echo json_encode(['success' => false, 'error' => $stmt->error]);
}
?>
