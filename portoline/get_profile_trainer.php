<?php
include 'koneksi.php';
header('Content-Type: application/json');

$user_id = $_GET['user_id'] ?? '';
if (empty($user_id)) {
    echo json_encode(["success" => false, "error" => "User ID is required"]);
    exit;
}

$query = "SELECT * FROM trainer_profile WHERE user_id = ?";
$stmt = $conn->prepare($query);
$stmt->bind_param("i", $user_id);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();

    $profile_base64 = '';
    if (!empty($row['profile_image']) && file_exists($row['profile_image'])) {
        $profile_base64 = base64_encode(file_get_contents($row['profile_image']));
    }

    echo json_encode([
        "success" => true,
        "data" => [
            "name" => $row['name'],
            "email" => $row['email'],
            "dob" => $row['dob'],
            "hobby" => $row['hobby'],
            "profile_image_base64" => $profile_base64
        ]
    ]);
} else {
    echo json_encode(["success" => false, "error" => "Profile not found"]);
}

$stmt->close();
$conn->close();
