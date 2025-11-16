<?php
require_once 'config_db.php'; // Incluye la conexión a la BD

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

$query_input = isset($_GET['query']) ? trim(strtolower($_GET['query'])) : '';

if (empty($query_input)) {
    http_response_code(400); 
    echo json_encode(array("encontrado" => false, "mensaje" => "Por favor, ingresa una matrícula o nombre."));
    exit();
}

// Lógica de Búsqueda con JOIN: La consulta busca por matrícula exacta O por coincidencia en nombre.
$sql = "SELECT 
            A.nombre_completo, 
            A.matricula, 
            D.titulo, 
            D.ano_emision,      /* <-- CORRECTO: nombre de la columna en BD */
            D.url_certificado 
        FROM alumnos A
        JOIN documentos D ON A.alumno_id = D.alumno_id
        WHERE A.matricula = ? OR A.nombre_completo LIKE ?";

// Preparar la consulta (usando JOIN)
if ($stmt = $mysqli->prepare($sql)) {
    
    // Configurar la búsqueda LIKE para el nombre
    $param_query = "%" . $query_input . "%"; 
    $stmt->bind_param("ss", $query_input, $param_query);

    // Ejecutar la consulta
    $stmt->execute();
    $resultado = $stmt->get_result();

    if ($resultado->num_rows > 0) {
        
        $documentos_encontrados = [];
        $nombre_alumno = "";
        $matricula_alumno = "";

        // Almacenar todos los documentos encontrados para ese alumno
        while ($fila = $resultado->fetch_assoc()) {
            $nombre_alumno = ucwords($fila['nombre_completo']); 
            $matricula_alumno = $fila['matricula']; 
            
            // Mapeamos el valor de la columna 'titulo' de la BD a la clave 'tipo_documento' que el JavaScript espera.
            $documentos_encontrados[] = [
                'tipo_documento' => $fila['titulo'], 
                'anio_emision' => $fila['ano_emision'], /* <-- CORRECCIÓN: Usar la clave 'ano_emision' que viene de la BD */
                'url_certificado' => $fila['url_certificado']
            ];
        }
        
        http_response_code(200);
        echo json_encode(array(
            "encontrado" => true,
            "nombre_completo" => $nombre_alumno,
            "matricula" => $matricula_alumno,
            "documentos" => $documentos_encontrados, // Devolvemos una lista de documentos
            "mensaje" => "Se encontraron " . count($documentos_encontrados) . " documentos para " . $nombre_alumno . "."
        ));
    } else {
        // No encontrado
        http_response_code(404); 
        echo json_encode(array("encontrado" => false, "mensaje" => "No se encontraron documentos o el alumno no existe."));
    }

    $stmt->close();
} else {
    http_response_code(500);
    // Usamos $mysqli->error para depuración.
    echo json_encode(array("encontrado" => false, "mensaje" => "Error interno del servidor al preparar la consulta: " . $mysqli->error));
}

$mysqli->close();
// NOTA: Se omite la etiqueta de cierre PHP ?>