<?php
$email = $_GET['email'] ?? '';
?>

<!DOCTYPE html>
<html>
<head>
    <title>Reset Password</title>
    <style>
        body { font-family: Arial; padding: 20px; }
        input[type="password"] { width: 300px; padding: 10px; margin-bottom: 10px; }
        button { padding: 10px 20px; }
    </style>
</head>
<body>
    <h2>Reset Password</h2>
    <form method="POST" action="reset_password_submit.php">
        <input type="hidden" name="email" value="<?php echo htmlspecialchars($email); ?>">

        <label>Password Baru:</label><br>
        <input type="password" name="new_password" required><br>

        <label>Konfirmasi Password:</label><br>
        <input type="password" name="confirm_password" required><br>

        <button type="submit">Simpan Password Baru</button>
    </form>
</body>
</html>
