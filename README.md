# CUT GO — Sistema de Información de Transporte Estudiantil
## Centro Universitario de Tonalá — UdeG

### Descripción
Aplicación web (FastAPI + MySQL + React) que centraliza información de transporte público para estudiantes del CUT (Av. Nuevo Periférico 555, Tonalá, Jalisco). Los estudiantes registran horarios reales de camiones, reportan incidentes y califican rutas. El sistema genera estadísticas y mapas de riesgo.

### Stack técnico
- **Backend:** FastAPI (Python 3.11)
- **Base de datos:** MySQL 8.0
- **ORM:** SQLAlchemy + PyMySQL
- **Frontend:** React 18 + Vite
- **Mapas:** Leaflet.js
- **Gráficas:** Chart.js

### Modelo de datos (6 tablas)

**1. USUARIOS** — Perfil de cada estudiante
- `id_usuario` (PK, INT AUTO_INCREMENT)
- `nombre` (VARCHAR 100)
- `carrera` (VARCHAR 80)
- `semestre` (INT)
- `municipio_origen` (VARCHAR 80)
- `contrasena_hash` (VARCHAR 255)
- `rol` (ENUM: 'estudiante','admin', DEFAULT 'estudiante')
- `fecha_registro` (TIMESTAMP, DEFAULT NOW())

**2. RUTAS** — Catálogo de rutas de camiones al CUT
- `id_ruta` (PK, INT AUTO_INCREMENT)
- `nombre_ruta` (VARCHAR 100)
- `numero_camion` (VARCHAR 20)
- `municipio_origen` (VARCHAR 80)
- `activa` (BOOLEAN, DEFAULT TRUE)
- `descripcion` (TEXT)

**3. PARADAS** — Puntos de parada con coordenadas GPS
- `id_parada` (PK, INT AUTO_INCREMENT)
- `id_ruta` (FK → RUTAS)
- `nombre_parada` (VARCHAR 120)
- `latitud` (DECIMAL 10,7)
- `longitud` (DECIMAL 10,7)
- `orden_en_ruta` (INT)
- `es_terminal` (BOOLEAN, DEFAULT FALSE)

**4. REGISTROS_HORARIO** — Timestamps reales registrados por usuarios
- `id_registro` (PK, INT AUTO_INCREMENT)
- `id_parada` (FK → PARADAS)
- `id_usuario` (FK → USUARIOS)
- `timestamp_real` (DATETIME)
- `validaciones_pos` (INT, DEFAULT 0)
- `validaciones_neg` (INT, DEFAULT 0)

**5. INCIDENTES** — Reportes de seguridad
- `id_incidente` (PK, INT AUTO_INCREMENT)
- `id_parada` (FK → PARADAS)
- `id_usuario` (FK → USUARIOS)
- `tipo_incidente` (ENUM: 'robo','acoso','accidente','camion_lleno','retraso','otro')
- `descripcion` (TEXT)
- `estado` (ENUM: 'activo','resuelto', DEFAULT 'activo')
- `fecha_reporte` (TIMESTAMP, DEFAULT NOW())

**6. CALIFICACIONES** — Evaluaciones de rutas
- `id_calif` (PK, INT AUTO_INCREMENT)
- `id_ruta` (FK → RUTAS)
- `id_usuario` (FK → USUARIOS)
- `puntuacion` (DECIMAL 2,1 — rango 1.0 a 5.0)
- `categoria` (ENUM: 'seguridad','puntualidad','comodidad','limpieza')
- `timestamp` (TIMESTAMP, DEFAULT NOW())

### Relaciones
- RUTAS 1→N PARADAS
- PARADAS 1→N REGISTROS_HORARIO / INCIDENTES
- RUTAS 1→N CALIFICACIONES
- USUARIOS 1→N REGISTROS_HORARIO / INCIDENTES / CALIFICACIONES

### Endpoints FastAPI requeridos
- `GET /api/rutas` → Lista todas las rutas activas.
- `GET /api/rutas/{id}/paradas` → Paradas de una ruta con coordenadas.
- `POST /api/horarios` → Registrar observación de horario.
- `POST /api/incidentes` → Reportar incidente.
- `GET /api/estadisticas/incidentes` → Top paradas peligrosas.
- `GET /api/estadisticas/frecuencia` → Frecuencia promedio real.
- `GET /api/paradas/{id}/proximos` → Próximo camión estimado.

### Datos reales de referencia
- **Ruta 631:** Tonalá Centro → CUT (vía Periférico Norte)
- **Ruta 630:** Central Camionera → CUT
- **Ruta 275:** Zapopan → Tonalá → CUT
- **Ruta 258:** San Pedro Tlaquepaque → CUT
- **TUR Periférico:** Conexión desde Las Águilas
- **Coordenadas CUT:** 20.6269, -103.2334