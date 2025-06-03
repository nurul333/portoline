<?php
header('Content-Type: application/json');
require_once 'koneksi.php'; // koneksi ke DB

if (!isset($_GET['user_id'])) {
    echo json_encode(['success' => false, 'message' => 'User ID tidak ditemukan']);
    exit;
}

$user_id = $_GET['user_id'];

$query = "SELECT * FROM jobseeker_profile WHERE user_id = ?";
$stmt = $conn->prepare($query);
$stmt->bind_param("s", $user_id);
$stmt->execute();
$result = $stmt->get_result();

if ($row = $result->fetch_assoc()) {
    echo json_encode([
        'success' => true,
        'data' => [
            'name' => $row['name'],
            'email' => $row['email'],
            'dob' => $row['dob'],
            'hobby' => $row['hobby'],
            'profile_image_base64' => $row['profile_image_base64'] ?? '',
            'certificates_base64' => $row['certificates_base64'] ?? '[]',
        ]
    ]);
} else {
    echo json_encode([
        'success' => true, // Tetap true agar tidak error di Flutter
        'data' => [
            'name' => '',
            'email' => '',
            'dob' => '',
            'hobby' => '',
            'profile_image_base64' => '',
            'certificates_base64' => '[]',
        ]
    ]);
}
?>
