<?php
// Database instellingen
$host = getenv('DB_HOST') ?: 'localhost';
$db   = getenv('DB_NAME') ?: 'files_db';
$user = getenv('DB_USER') ?: 'admin';
$pass = getenv('DB_PASS') ?: 'SuperSecure123!';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db;charset=utf8", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (Exception $e) {
    die("Database connectie mislukt: " . $e->getMessage());
}
