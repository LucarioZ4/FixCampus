-- ============================================================
-- MIGRACIÓN 005: DATOS SEMILLA (SEED DATA)
-- ============================================================

-- 1. INSERTAR CATÁLOGOS BASE
INSERT INTO ROLES (nombre_rol) VALUES
('Administrador'),
('Soporte Técnico'),
('Usuario Final');

INSERT INTO UBICACIONES (nombre_lugar, direccion) VALUES
('Bloque B - Laboratorio de Sistemas', 'Campus Sabanas, Piso 2'),
('Biblioteca Central', 'Campus Sabanas, Piso 1'),
('Bloque A - Edificio Administrativo', 'Campus Sabanas, Piso 3'),
('Cafetería Central', 'Campus Sabanas, Primer Piso'),
('Bloque C - Aulas de Clase', 'Campus Sabanas, Piso 1');

INSERT INTO CATEGORIAS (nombre_cat, descripcion) VALUES
('Redes e Internet', 'Fallas de conectividad WiFi, cableado estructurado y switches'),
('Hardware y Equipos', 'Daños en computadores, monitores, periféricos e impresoras'),
('Infraestructura', 'Problemas de iluminación, aire acondicionado, tomas eléctricas y silletería'),
('Software y Sistemas', 'Inconvenientes con licencias, sistemas operativos y plataformas');

INSERT INTO ESTADOS (nombre_estado, color) VALUES
('Pendiente', '#FFC107'),
('En Proceso', '#17A2B8'),
('Resuelto', '#28A745'),
('Cerrado', '#6C757D'),
('Cancelado', '#DC3545');

-- 2. INSERTAR USUARIOS (Administradores, Técnicos y Usuarios Finales)
INSERT INTO USUARIOS (cedula, nombre, email, telefono, estado, id_rol) VALUES
('1065892101', 'Carlos Mario Mendoza', 'carlos.mendoza@unicesar.edu.co', '3001234567', 'activo', 1),
('1065892102', 'Andrés Felipe Gómez', 'andres.gomez@unicesar.edu.co', '3159876543', 'activo', 2),
('1065892103', 'Laura Sofía Martínez', 'laura.martinez@unicesar.edu.co', '3204567890', 'activo', 2),
('1065892104', 'Diana Carolina Orozco', 'diana.orozco@unicesar.edu.co', '3116549870', 'activo', 2),
('1065892105', 'Javier Enrique Torres', 'javier.torres@unicesar.edu.co', '3012348765', 'activo', 3),
('1065892106', 'Mariana Isabel Silva', 'mariana.silva@unicesar.edu.co', '3045671234', 'activo', 3),
('1065892107', 'Jorge Luis Benítez', 'jorge.benitez@unicesar.edu.co', '3187654321', 'activo', 3),
('1065892108', 'Camila Andrea Vega', 'camila.vega@unicesar.edu.co', '3129873412', 'inactivo', 3);

-- 3. REGISTRAR TÉCNICOS (Especialización de Usuarios id: 2, 3, 4)
INSERT INTO TECNICOS (user_id, especialidad) VALUES
(2, 'Infraestructura de Redes y Conectividad'),
(3, 'Mantenimiento Correctivo de Hardware'),
(4, 'Sistemas Eléctricos y Climatización');

-- 4. INSERTAR REPORTES / TICKETS
INSERT INTO REPORTES (ticket, descripcion, user_id, ubicacion_id, categoria_id, estado_id) VALUES
('TCK-2026-001', 'El aire acondicionado del laboratorio 201 no enfría y presenta goteo.', 5, 1, 3, 2),
('TCK-2026-002', 'Sin acceso a la red de cableado en el puesto de consulta 04.', 6, 2, 1, 1),
('TCK-2026-003', 'Fallo de proyección en videobeam del aula C-102.', 7, 5, 2, 3),
('TCK-2026-004', 'Toma corriente sin energía en el área de lockers.', 5, 4, 3, 1),
('TCK-2026-005', 'Falla de conexión WiFi institucional en el área administrativa.', 6, 3, 1, 2),
('TCK-2026-006', 'Computador de recepción no enciende tras descarga eléctrica.', 7, 3, 2, 1),
('TCK-2026-007', 'Mesa de trabajo fracturada en sala de lectura.', 5, 2, 3, 4);

-- 5. ASIGNACIÓN DE TÉCNICOS A REPORTES (M:N)
-- Nota: Los reportes TCK-002, TCK-004 y TCK-006 quedan sin técnico para probar consultas "sin asignación"
INSERT INTO ASIGNADO_A (user_id, id_reporte, fecha_asig) VALUES
(4, 1, '2026-10-10 08:30:00'),
(2, 3, '2026-10-11 09:15:00'),
(3, 3, '2026-10-11 09:20:00'), -- Asignación múltiple para probar JOINs
(2, 5, '2026-10-12 14:00:00');

-- 6. INSERTAR COMENTARIOS EN REPORTES
-- Nota: Algunos reportes no tienen comentarios para permitir consultas externas LEFT JOIN
INSERT INTO COMENTARIOS (contenido, fecha_creacion, user_id, id_reporte) VALUES
('Se realizó inspección inicial, el compresor requiere revisión técnica especializada.', '2026-10-10 10:00:00', 4, 1),
('Favor revisar lo antes posible, afecta la clase de 10:00 AM.', '2026-10-11 07:30:00', 7, 3),
('Se cambió el cable HDMI y el equipo volvió a proyectar correctamente.', '2026-10-11 11:45:00', 3, 3),
('El problema persiste intermitentemente en la tarde.', '2026-10-12 16:30:00', 6, 5);

-- 7. REGISTRAR HISTORIAL DE CAMBIOS DE ESTADO
INSERT INTO HISTORIAL_REPORTES (fecha_cambio, observacion, id_reporte, estado_id) VALUES
('2026-10-10 08:00:00', 'Registro inicial del ticket por el usuario.', 1, 1),
('2026-10-10 08:30:00', 'Asignado a Diana Carolina Orozco.', 1, 2),
('2026-10-11 07:00:00', 'Registro inicial del ticket por el usuario.', 3, 1),
('2026-10-11 09:15:00', 'Asignado a técnicos de hardware.', 3, 2),
('2026-10-11 11:50:00', 'Incidencia resuelta satisfactoriamente.', 3, 3),
('2026-10-12 13:00:00', 'Registro inicial del ticket.', 5, 1),
('2026-10-12 14:00:00', 'Asignado a Andrés Felipe Gómez.', 5, 2);