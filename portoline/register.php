<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Content-Type: application/json");

// Pastikan file koneksi tersedia
include("koneksi.php");

// Ambil data dari body (POST)
$name = $_POST['name'] ?? '';
$email = $_POST['email'] ?? '';
$password = $_POST['password'] ?? '';
$role = $_POST['role'] ?? '';

// Cek apakah data kosong
if (empty($name) || empty($email) || empty($password) || empty($role)) {
    echo json_encode([
        "success" => false,
        "message" => "Semua data wajib diisi!"
    ]);
    exit();
}

// Cek apakah email sudah terdaftar
$checkQuery = "SELECT * FROM users WHERE email = '$email'";
$result = mysqli_query($conn, $checkQuery);

if (mysqli_num_rows($result) > 0) {
    echo json_encode([
        "success" => false,
        "message" => "Email sudah terdaftar!"
    ]);
    exit();
}

// Simpan data baru
$insertQuery = "INSERT INTO users (name, email, password, role) 
                VALUES ('$name', '$email', '$password', '$role')";

if (mysqli_query($conn, $insertQuery)) {
    echo json_encode([
        "success" => true,
        "message" => "Registrasi berhasil!"
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "Gagal menyimpan data!"
    ]);
}
?>