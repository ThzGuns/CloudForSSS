<?php
require 'config.php';

if (!isset($_FILES['file']) || $_FILES['file']['error'] !== UPLOAD_ERR_OK) {
    die("Geen geldig bestand ontvangen.");
}

$filename     = basename($_FILES['file']['name']);
$tmpPath      = $_FILES['file']['tmp_name'];
$description  = $_POST['description'] ?? '';

$localDir = __DIR__ . "/uploads/";
if (!is_dir($localDir)) {
    mkdir($localDir, 0755, true);
}
$localPath = $localDir . $filename;

if (!move_uploaded_file($tmpPath, $localPath)) {
    die("Kon bestand niet lokaal opslaan.");
}

$bucket      = getenv('BUCKET_NAME') ?: 'terra-bucket-cloud';
$s3Key       = "uploads/" . $filename;

$tmpEscaped  = escapeshellarg($localPath);
$bucketEsc   = escapeshellarg($bucket);
$keyEscaped  = escapeshellarg($s3Key);

$cmd = "aws s3 cp $tmpEscaped s3://$bucketEsc/$keyEscaped 2>&1";
exec($cmd, $output, $status);

if ($status !== 0) {
    echo "Fout bij S3 upload:<br>";
    echo implode("<br>", $output);
    exit;
}

$stmt = $pdo->prepare("INSERT INTO files (filename, description) VALUES (?, ?)");
$stmt->execute([$filename, $description]);

echo "Upload gelukt! <a href='index.html'>Terug</a>";
