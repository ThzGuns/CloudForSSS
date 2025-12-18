<?php
require 'config.php';

if (!isset($_GET['file'])) {
    die("Geen bestand opgegeven.");
}

$filename = basename($_GET['file']);
$bucket   = getenv('BUCKET_NAME') ?: 'terra-bucket-cloud';
$s3Key    = "uploads/$filename";

/* Temp file */
$tmpFile = tempnam(sys_get_temp_dir(), 's3_');

/* Download from S3 to temp file */
$cmd = sprintf(
    'aws s3 cp s3://%s/%s %s 2>&1',
    escapeshellarg($bucket),
    escapeshellarg($s3Key),
    escapeshellarg($tmpFile)
);

exec($cmd, $output, $status);

if ($status !== 0 || !file_exists($tmpFile)) {
    unlink($tmpFile);
    die("Kon bestand niet downloaden van S3.");
}

/* FORCE DOWNLOAD */
header('Content-Description: File Transfer');
header('Content-Type: application/octet-stream');
header('Content-Disposition: attachment; filename="' . $filename . '"');
header('Content-Length: ' . filesize($tmpFile));
header('Cache-Control: no-cache');
header('Pragma: public');
flush();

/* Output file */
readfile($tmpFile);
unlink($tmpFile);
exit;
