<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

$conn = new mysqli(
    "localhost",
    "appuser",
    "password123",
    "files_db"
);

if ($conn->connect_error) {
    die("DB fout: " . $conn->connect_error);
}

if (!isset($_FILES['file'])) {
    die("Geen bestand ontvangen");
}

$filename = basename($_FILES['file']['name']);
$description = $_POST['description'];

$upload_dir = "/var/www/html/uploads/";
if (!is_dir($upload_dir)) {
    mkdir($upload_dir, 0755, true);
}

move_uploaded_file($_FILES['file']['tmp_name'], $upload_dir . $filename);

$stmt = $conn->prepare("INSERT INTO files (filename, description) VALUES (?, ?)");
$stmt->bind_param("ss", $filename, $description);
$stmt->execute();

echo "Upload gelukt! <a href='index.html'>Terug</a>";
