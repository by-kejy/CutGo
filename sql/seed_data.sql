USE cutgo;

-- Usuario admin de prueba (contraseña: cutgo2026)
-- Usuario admin de prueba (contraseña: cutgo2026)
INSERT INTO USUARIOS (nombre, correo, carrera, semestre, municipio_origen, contrasena_hash, rol)
VALUES 
('Admin CUT GO', 'admin@cutgo.com', 'Sistemas', 1, 'Tonalá', '$2b$12$demo_hash_admin', 'admin'),
('admin_cutgo', 'yohana.nava4259@alumnos.udg.mx', 'Ingeniería en Ciencias Computacionales', 3, 'Chapala', '$2b$12$SzO7vHddrhABJF7QZLBFKeGJeBsNpDve.HVyusY4vCrz3WOX9GQD2', 'admin'),
('Ana García López', 'ana@alumnos.udg.mx', 'Ing. Computacional', 3, 'Tonalá', '$2b$12$demo_hash_1', 'estudiante'),
('Luis Martínez Ruiz', 'luis@alumnos.udg.mx', 'Ing. Computacional', 5, 'Zapopan', '$2b$12$demo_hash_2', 'estudiante'),
('María Torres Soto', 'maria@alumnos.udg.mx', 'Diseño Digital', 3, 'Tlaquepaque', '$2b$12$demo_hash_3', 'estudiante'),
('Carlos Pérez Vega', 'carlos@alumnos.udg.mx', 'Ing. Computacional', 1, 'Guadalajara', '$2b$12$demo_hash_4', 'estudiante');

-- 6 rutas reales hacia el CUT Tonalá
INSERT INTO RUTAS (nombre_ruta, numero_camion, municipio_origen, activa, descripcion)
VALUES
('Tonalá Centro → CUT', '631', 'Tonalá', TRUE, 'Sale de Mercado Tonalá, recorre Av. Tonalá y sube por Periférico Norte hasta CUT'),
('Central Camionera → CUT', '630', 'Guadalajara', TRUE, 'Conecta la Central de Autobuses Guadalajara con el CUT vía Periférico'),
('Tlaquepaque → CUT', '258', 'San Pedro Tlaquepaque', TRUE, 'Desde la Glorieta El Árbol en Tlaquepaque hasta el CUT'),
('Ruta 9 - Central L3 → CUT', 'RUTA-9', 'Tlaquepaque', TRUE, 'Ruta directa desde Central Nueva L3 hasta CUTonalá'),
('Ruta 368 CUT — Periférico Norte → CUTonalá', '368-CUT', 'Guadalajara', TRUE, 'Primera ruta histórica del CUT, desde agosto 2014. Sale de Estación Periférico Norte L1 Tren Ligero, recorre Periférico Oriente hasta CUTonalá. Operada por SITEUR.'),
('C98 Mi Transporte Eléctrico — Periférico Norte → CUT → Aeropuerto', 'C98', 'Guadalajara', TRUE, 'Primera ruta 100% eléctrica de México, SITEUR desde julio 2021. Frecuencia 12 min. Horario 5:00–22:30 hrs.');

-- Paradas reales Ruta 631 (Tonalá Centro → CUT)
INSERT INTO PARADAS (id_ruta, nombre_parada, latitud, longitud, orden_en_ruta, es_terminal)
VALUES
(1, 'Mercado Municipal Tonalá', 20.6234, -103.2371, 1, TRUE),
(1, 'Plaza Principal Tonalá', 20.6228, -103.2354, 2, FALSE),
(1, 'Av. Tonalá / Constitución', 20.6240, -103.2340, 3, FALSE),
(1, 'Glorieta Tonalá', 20.6218, -103.2358, 4, FALSE),
(1, 'Periférico Norte / Tonalá', 20.6250, -103.2335, 5, FALSE),
(1, 'Las Águilas Periférico', 20.6260, -103.2334, 6, FALSE),
(1, 'CUT — Entrada Principal', 20.5666, -103.2278, 7, TRUE);

-- Paradas Ruta 630 (Central → CUT)
INSERT INTO PARADAS (id_ruta, nombre_parada, latitud, longitud, orden_en_ruta, es_terminal)
VALUES
(2, 'Central de Autobuses GDL', 20.6572, -103.3467, 1, TRUE),
(2, 'Av. Dr. R. Michel / López Cotilla', 20.6550, -103.3440, 2, FALSE),
(2, 'Glorieta Independencia', 20.6534, -103.3399, 3, FALSE),
(2, 'Periférico Sur / Lázaro Cárdenas', 20.6410, -103.3100, 4, FALSE),
(2, 'Av. 8 de Julio / Periférico', 20.6320, -103.2800, 5, FALSE),
(2, 'Tonalá Entrada Sur', 20.6245, -103.2400, 6, FALSE),
(2, 'CUT — Entrada Principal', 20.5666, -103.2278, 7, TRUE);

-- Paradas Ruta 258 (Tlaquepaque → CUT)
INSERT INTO PARADAS (id_ruta, nombre_parada, latitud, longitud, orden_en_ruta, es_terminal)
VALUES
(3, 'Glorieta El Árbol Tlaquepaque', 20.6415, -103.3074, 1, TRUE),
(3, 'Av. Niños Héroes Tlaquepaque', 20.6380, -103.3020, 2, FALSE),
(3, 'Carretera Guadalajara-Tonalá km5', 20.6360, -103.2800, 3, FALSE),
(3, 'Carretera Guadalajara-Tonalá km8', 20.6340, -103.2640, 4, FALSE),
(3, 'Entrada Tonalá / Carretera', 20.6290, -103.2480, 5, FALSE),
(3, 'Av. Periférico Norte Tonalá', 20.6270, -103.2380, 6, FALSE),
(3, 'CUT — Entrada Principal', 20.5666, -103.2278, 7, TRUE);

-- Paradas Ruta 9 (Central L3 → CUT)
INSERT INTO PARADAS (id_ruta, nombre_parada, latitud, longitud, orden_en_ruta, es_terminal)
VALUES
(4, 'Estación Central de Autobuses — Línea 3', 20.6285, -103.2858, 1, TRUE),
(4, 'Av. Las Torres / Av. Tonalá', 20.6270, -103.2780, 2, FALSE),
(4, 'Av. Tonalá / Carretera GDL–Tonalá km3', 20.6255, -103.2650, 3, FALSE),
(4, 'Av. Tonalá / Av. Tonaltecas', 20.6240, -103.2500, 4, FALSE),
(4, 'Av. Tonaltecas — Centro Tonalá', 20.6228, -103.2370, 5, FALSE),
(4, 'Camino al Vado / Tonaltecas', 20.6100, -103.2340, 6, FALSE),
(4, 'Camino al Vado / Periférico Nuevo', 20.5900, -103.2310, 7, FALSE),
(4, 'Periférico Nuevo / Hospital Civil de Oriente', 20.5720, -103.2290, 8, FALSE),
(4, 'CUTonalá — Entrada Principal', 20.5666, -103.2278, 9, TRUE);

-- Paradas Ruta 368 (368-CUT)
INSERT INTO PARADAS (id_ruta, nombre_parada, latitud, longitud, orden_en_ruta, es_terminal)
VALUES
(5, 'Estación Periférico Norte L1 — Tren Ligero', 20.6897, -103.3418, 1, TRUE),
(5, 'Periférico Oriente / Federalismo', 20.6890, -103.3380, 2, FALSE),
(5, 'Periférico / Calz. Independencia', 20.6830, -103.3310, 3, FALSE),
(5, 'Periférico / Av. Revolución', 20.6750, -103.3200, 4, FALSE),
(5, 'Periférico / Lázaro Cárdenas', 20.6650, -103.3050, 5, FALSE),
(5, 'Periférico / Tlaquepaque Norte', 20.6520, -103.2850, 6, FALSE),
(5, 'Periférico / Carretera GDL–Tonalá', 20.6400, -103.2650, 7, FALSE),
(5, 'Periférico Oriente / Av. Tonalá', 20.6320, -103.2550, 8, FALSE),
(5, 'Periférico Nuevo / Ejido Tateposco', 20.6050, -103.2380, 9, FALSE),
(5, 'CUTonalá — Entrada Principal', 20.5666, -103.2278, 10, TRUE);

-- Paradas Ruta C98
INSERT INTO PARADAS (id_ruta, nombre_parada, latitud, longitud, orden_en_ruta, es_terminal)
VALUES
(6, 'Estación Periférico Norte L1 — Tren Ligero', 20.6897, -103.3418, 1, TRUE),
(6, 'Periférico / Ricardo Flores Magón', 20.6820, -103.3300, 2, FALSE),
(6, 'Periférico / Col. Jalisco', 20.6700, -103.3100, 3, FALSE),
(6, 'Periférico / Av. 8 de Julio', 20.6600, -103.2950, 4, FALSE),
(6, 'Periférico / Av. Tonalá Oriente', 20.6400, -103.2700, 5, FALSE),
(6, 'Periférico / Carretera GDL–Zapotlanejo', 20.6300, -103.2550, 6, FALSE),
(6, 'Periférico / Entrada Tonalá Norte', 20.6200, -103.2450, 7, FALSE),
(6, 'Periférico Nuevo / Hospital Civil de Oriente', 20.5720, -103.2300, 8, FALSE),
(6, 'CUTonalá — Entrada Principal', 20.5666, -103.2278, 9, FALSE),
(6, 'Parques del Castillo — Terminal C98', 20.5200, -103.2100, 10, TRUE);

-- Registros de horario de muestra (últimos 7 días)
-- (Note: IDs might need adjustment if using these for fresh installs)
-- For simplicity, keeping sample data minimal or tied to first route.
INSERT INTO REGISTROS_HORARIO (id_parada, id_usuario, timestamp_real, validaciones_pos)
VALUES
(1, 2, '2026-04-21 06:45:00', 3),
(1, 3, '2026-04-21 07:12:00', 5),
(1, 2, '2026-04-21 07:38:00', 2);

-- Incidentes de muestra
INSERT INTO INCIDENTES (id_parada, id_usuario, tipo_incidente, descripcion, estado)
VALUES
(1, 2, 'robo', 'Arrebataron celular en la parada cerca del Mercado a las 6:50am', 'activo'),
(4, 3, 'acoso', 'Un hombre acosando a estudiantes mujeres en parada Constitución', 'activo');

-- Calificaciones de muestra
INSERT INTO CALIFICACIONES (id_ruta, id_usuario, puntuacion, categoria)
VALUES
(1, 2, 3.5, 'seguridad'),
(1, 3, 4.0, 'seguridad'),
(2, 4, 3.0, 'seguridad');