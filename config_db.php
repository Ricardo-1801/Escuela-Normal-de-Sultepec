<?php
// config_db.php

// Configuración de la base de datos
define('DB_SERVER', 'localhost');
define('DB_USERNAME', 'root');  // Usuario por defecto en XAMPP/WAMP
define('DB_PASSWORD', ''); // Contraseña por defecto (vacía) en XAMPP/WAMP
define('DB_NAME', 'constancia'); // Nombre de la BD


$mysqli = new mysqli(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_NAME);

// 3. Verificar la conexión
if ($mysqli->connect_error) {
    // Si la conexión falla, detenemos el script y enviamos un error 500 al frontend
    http_response_code(500); 
    echo json_encode(array(
        "encontrado" => false, 
        "mensaje" => "Error de conexión con la base de datos. Código: " . $mysqli->connect_errno
    ));
    exit();
}

$mysqli->set_charset("utf8mb4");

// NOTA: Se omite la etiqueta de cierre PHP para evitar impresiones accidentales (silencioso).