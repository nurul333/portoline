<?php
include 'koneksi.php';
header('Content-Type: application/json');

$user_id = $_POST['user_id'] ?? '';
$name = $_POST['name'] ?? '';
$email = $_POST['email'] ?? '';
$dob = $_POST['dob'] ?? '';
$hobby = $_POST['hobby'] ?? '';
$profile_base64 = $_POST['profile_image_base64'] ?? '';

if (empty($user_id)) {
    echo json_encode(["success" => false, "error" => "User ID is required"]);
    exit;
}

$profile_filename = '';
if (!empty($profile_base64)) {
    $profile_data = base64_decode($profile_base64);
    $profile_filename = 'uploads/profile_' . $user_id . '_' . time() . '.png';
    file_put_contents($profile_filename, $profile_data);
}

$check_sql = "SELECT * FROM trainer_profile WHERE user_id = ?";
$stmt = $conn->prepare($check_sql);
$stmt->bind_param("i", $user_id);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $update_sql = "UPDATE trainer_profile SET name=?, email=?, dob=?, hobby=?, profile_image=? WHERE user_id=?";
    $stmt = $conn->prepare($update_sql);
    $stmt->bind_param("sssssi", $name, $email, $dob, $hobby, $profile_filename, $user_id);
} else {
    $insert_sql = "INSERT INTO trainer_profile (user_id, name, email, dob, hobby, profile_image) VALUES (?, ?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($insert_sql);
    $stmt->bind_param("isssss", $user_id, $name, $email, $dob, $hobby, $profile_filename);
}

if ($stmt->execute()) {
    echo json_encode(["success" => true]);
} else {
    echo json_encode(["success" => false, "error" => $stmt->error]);
}

$stmt->close();
$conn->close();
