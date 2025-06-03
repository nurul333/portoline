<?php
include 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'];
    $newPassword = $_POST['new_password'];

    // Simpan password asli (TIDAK DI-HASH) — Peringatan: tidak aman untuk produksi
    $query = "UPDATE users SET password='$newPassword' WHERE email='$email'";
    $result = mysqli_query($conn, $query);

    if ($result) {
        echo "Password updated successfully";
    } else {
        echo "Failed to update password: " . mysqli_error($conn);
    }
} else {
    echo "Invalid request method.";
}
?>
