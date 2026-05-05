-- CUT GO — Schema MySQL 8.0
-- Ejecutar en orden

CREATE DATABASE IF NOT EXISTS cutgo;
USE cutgo;

CREATE TABLE USUARIOS (
  id_usuario      INT AUTO_INCREMENT PRIMARY KEY,
  nombre          VARCHAR(100) NOT NULL,
  correo          VARCHAR(100) UNIQUE,
  carrera         VARCHAR(80),
  semestre        INT,
  municipio_origen VARCHAR(80),
  contrasena_hash VARCHAR(255) NOT NULL,
  rol             ENUM('estudiante','admin') DEFAULT 'estudiante',
  fecha_registro  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE RUTAS (
  id_ruta         INT AUTO_INCREMENT PRIMARY KEY,
  nombre_ruta     VARCHAR(100) NOT NULL,
  numero_camion   VARCHAR(20) NOT NULL,
  municipio_origen VARCHAR(80),
  activa          BOOLEAN DEFAULT TRUE,
  descripcion     TEXT
);

CREATE TABLE PARADAS (
  id_parada       INT AUTO_INCREMENT PRIMARY KEY,
  id_ruta         INT NOT NULL,
  nombre_parada   VARCHAR(120) NOT NULL,
  latitud         DECIMAL(10,7) NOT NULL,
  longitud        DECIMAL(10,7) NOT NULL,
  orden_en_ruta   INT NOT NULL,
  es_terminal     BOOLEAN DEFAULT FALSE,
  FOREIGN KEY (id_ruta) REFERENCES RUTAS(id_ruta) ON DELETE CASCADE
);

CREATE TABLE REGISTROS_HORARIO (
  id_registro     INT AUTO_INCREMENT PRIMARY KEY,
  id_parada       INT NOT NULL,
  id_usuario      INT NOT NULL,
  timestamp_real  DATETIME NOT NULL,
  validaciones_pos INT DEFAULT 0,
  validaciones_neg INT DEFAULT 0,
  FOREIGN KEY (id_parada)  REFERENCES PARADAS(id_parada),
  FOREIGN KEY (id_usuario) REFERENCES USUARIOS(id_usuario)
);

CREATE TABLE INCIDENTES (
  id_incidente    INT AUTO_INCREMENT PRIMARY KEY,
  id_parada       INT NOT NULL,
  id_usuario      INT NOT NULL,
  tipo_incidente  ENUM('robo','acoso','accidente','camion_lleno','retraso','otro') NOT NULL,
  descripcion     TEXT,
  estado          ENUM('activo','resuelto') DEFAULT 'activo',
  fecha_reporte   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_parada)  REFERENCES PARADAS(id_parada),
  FOREIGN KEY (id_usuario) REFERENCES USUARIOS(id_usuario)
);

CREATE TABLE CALIFICACIONES (
  id_calif        INT AUTO_INCREMENT PRIMARY KEY,
  id_ruta         INT NOT NULL,
  id_usuario      INT NOT NULL,
  puntuacion      DECIMAL(2,1) NOT NULL CHECK (puntuacion BETWEEN 1.0 AND 5.0),
  categoria       ENUM('seguridad','puntualidad','comodidad','limpieza') NOT NULL,
  timestamp       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_ruta)    REFERENCES RUTAS(id_ruta),
  FOREIGN KEY (id_usuario) REFERENCES USUARIOS(id_usuario)
);

-- Índices para queries frecuentes
CREATE INDEX idx_incidentes_parada ON INCIDENTES(id_parada);
CREATE INDEX idx_horarios_parada   ON REGISTROS_HORARIO(id_parada, timestamp_real);
CREATE INDEX idx_calificaciones_ruta ON CALIFICACIONES(id_ruta, categoria);