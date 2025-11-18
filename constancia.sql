-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-11-2025 a las 14:40:00
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `constancia`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumnos`
--

CREATE TABLE `alumnos` (
  `alumno_id` int(11) NOT NULL,
  `matricula` varchar(20) NOT NULL,
  `nombre_completo` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `alumnos`
--

INSERT INTO `alumnos` (`alumno_id`, `matricula`, `nombre_completo`) VALUES
(1, '1801', 'ricardo jorge mendoza hernandez'),
(2, '1802', 'geovanni albarran benitez');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documentos`
--

CREATE TABLE `documentos` (
  `documento_id` int(11) NOT NULL,
  `alumno_id` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `ano_emision` year(4) NOT NULL,
  `url_certificado` varchar(512) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `documentos`
--

INSERT INTO `documentos` (`documento_id`, `alumno_id`, `titulo`, `ano_emision`, `url_certificado`) VALUES
(1, 1, 'Stem', '2023', 'https://sultepec-my.sharepoint.com/personal/geovanni_albarran_d_normalsultepec_edu_mx/_layouts/15/onedrive.aspx?id=%2Fpersonal%2Fgeovanni%5Falbarran%5Fd%5Fnormalsultepec%5Fedu%5Fmx%2FDocuments%2FPrueba%2F1%2E%20Raymundo%20Sa%CC%81nchez%20Zavala%2Epdf&parent=%2Fpersonal%2Fgeovanni%5Falbarran%5Fd%5Fnormalsultepec%5Fedu%5Fmx%2FDocuments%2FPrueba&ga=1'),
(2, 2, 'Stem', '2025', 'https://sultepec-my.sharepoint.com/personal/geovanni_albarran_d_normalsultepec_edu_mx/_layouts/15/onedrive.aspx?id=%2Fpersonal%2Fgeovanni%5Falbarran%5Fd%5Fnormalsultepec%5Fedu%5Fmx%2FDocuments%2FPrueba%2F2%2E%20Jose%CC%81%20Alberto%20Meji%CC%81a%2Epdf&parent=%2Fpersonal%2Fgeovanni%5Falbarran%5Fd%5Fnormalsultepec%5Fedu%5Fmx%2FDocuments%2FPrueba&ga=1'),
(3, 2, 'IA En la educacion', '2023', 'https://sultepec-my.sharepoint.com/personal/geovanni_albarran_d_normalsultepec_edu_mx/_layouts/15/onedrive.aspx?id=%2Fpersonal%2Fgeovanni%5Falbarran%5Fd%5Fnormalsultepec%5Fedu%5Fmx%2FDocuments%2FPrueba%2F3%2E%20Rosali%CC%81o%20Flores%2Epdf&parent=%2Fpersonal%2Fgeovanni%5Falbarran%5Fd%5Fnormalsultepec%5Fedu%5Fmx%2FDocuments%2FPrueba&ga=1');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alumnos`
--
ALTER TABLE `alumnos`
  ADD PRIMARY KEY (`alumno_id`),
  ADD UNIQUE KEY `matricula` (`matricula`);

--
-- Indices de la tabla `documentos`
--
ALTER TABLE `documentos`
  ADD PRIMARY KEY (`documento_id`),
  ADD KEY `alumno_id` (`alumno_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alumnos`
--
ALTER TABLE `alumnos`
  MODIFY `alumno_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `documentos`
--
ALTER TABLE `documentos`
  MODIFY `documento_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `documentos`
--
ALTER TABLE `documentos`
  ADD CONSTRAINT `documentos_ibfk_1` FOREIGN KEY (`alumno_id`) REFERENCES `alumnos` (`alumno_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
