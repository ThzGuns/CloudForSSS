<?php
require 'config.php';

$stmt = $pdo->query("SELECT * FROM files ORDER BY uploaded_at DESC");

echo "<h1>Bestanden</h1><ul>";
while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
    echo "<li>
            <strong>{$row['filename']}</strong><br>
            {$row['description']}<br>
            <a href='downloads.php?file=" . urlencode($row['filename']) . "'>
                Download
            </a>
          </li><br>";
}
echo "</ul><a href='index.html'>Terug</a>";
