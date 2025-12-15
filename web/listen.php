<?php
require 'config.php';

$stmt = $pdo->query("SELECT * FROM files ORDER BY uploaded_at DESC");
$files = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Bestanden</title>
</head>
<body>
    <h1>Bestanden</h1>

    <ul>
        <?php foreach ($files as $row): ?>
            <li>
                <?= htmlspecialchars($row['filename']) ?> -
                <?= htmlspecialchars($row['description']) ?>
            </li>
        <?php endforeach; ?>
    </ul>

    <a href="index.html">Terug</a>
</body>
</html>
