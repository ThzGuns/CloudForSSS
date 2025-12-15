<?php
require 'config.php';

if (!isset($_FILES['file'])) {
    die("Geen bestand ontvangen");
}

$filename = basename($_FILES['file']['name']);
$description = $_POST['description'] ?? '';

$upload_dir = __DIR__ . "/uploads/";
if (!is_dir($upload_dir)) {
    mkdir($upload_dir, 0755, true);
}

move_uploaded_file($_FILES['file']['tmp_name'], $upload_dir . $filename);

$stmt = $pdo->prepare("INSERT INTO files (filename, description) VALUES (?, ?)");
$stmt->execute([$filename, $description]);

echo "Upload gelukt! <a href='index.html'>Terug</a>";
