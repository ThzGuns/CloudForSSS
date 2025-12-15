<?php
require 'config.php';

$stmt = $pdo->query("SELECT * FROM files ORDER BY uploaded_at DESC");

echo "<h1>Bestanden</h1><ul>";
while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
    echo "<li>{$row['filename']} - {$row['description']}</li>";
}
echo "</ul><a href='index.html'>Terug</a>";
