-- ============================================================
-- MIGRACIÓN 005: DATOS SEMILLA (SEED DATA)
-- ============================================================

-- 1. INSERTAR CATÁLOGOS BASE

INSERT INTO ROLES (id_rol, nombre_rol) VALUES
(1, 'Administrador'),
(2, 'Soporte Técnico'),
(3, 'Usuario Final'),
(4, 'Monitor de Laboratorio'),
(5, 'Coordinador de Infraestructura');

INSERT INTO UBICACIONES (ubicacion_id, nombre_lugar, direccion) VALUES
(1, 'Bloque B - Laboratorio de Sistemas', 'Campus Sabanas, Piso 2'),
(2, 'Biblioteca Central', 'Campus Sabanas, Piso 1'),
(3, 'Bloque A - Edificio Administrativo', 'Campus Sabanas, Piso 3'),
(4, 'Cafetería Central', 'Campus Sabanas, Primer Piso'),
(5, 'Bloque C - Aulas de Clase', 'Campus Sabanas, Piso 1'),
(6, 'Bloque D - Auditorio Principal', 'Campus Sabanas, Piso 1');

INSERT INTO CATEGORIAS (categoria_id, nombre_cat, descripcion) VALUES
(1, 'Redes e Internet', 'Fallas de conectividad WiFi, cableado estructurado y switches'),
(2, 'Hardware y Equipos', 'Daños en computadores, monitores, periféricos e impresoras'),
(3, 'Infraestructura', 'Problemas de iluminación, aire acondicionado, tomas eléctricas y silletería'),
(4, 'Software y Sistemas', 'Inconvenientes con licencias, sistemas operativos y plataformas'),
(5, 'Mobiliario y Cerrajería', 'Puertas trabadas, ventanas rotas, cerraduras dañadas y pupitres');

INSERT INTO ESTADOS (estado_id, nombre_estado, color) VALUES
(1, 'Pendiente', '#FFC107'),
(2, 'En Proceso', '#17A2B8'),
(3, 'Resuelto', '#28A745'),
(4, 'Cerrado', '#6C757D'),
(5, 'Cancelado', '#DC3545');

-- 2. INSERTAR USUARIOS (Administradores, Técnicos, Monitores y Usuarios Finales)
INSERT INTO USUARIOS (user_id, cedula, nombre, email, telefono, estado, id_rol) VALUES
(1, '1065892101', 'Carlos Mario Mendoza', 'carlos.mendoza@unicesar.edu.co', '3001234567', 'activo', 1),
(2, '1065892102', 'Andrés Felipe Gómez', 'andres.gomez@unicesar.edu.co', '3159876543', 'activo', 2),
(3, '1065892103', 'Laura Sofía Martínez', 'laura.martinez@unicesar.edu.co', '3204567890', 'activo', 2),
(4, '1065892104', 'Diana Carolina Orozco', 'diana.orozco@unicesar.edu.co', '3116549870', 'activo', 2),
(5, '1065892105', 'Roberto Carlos Morales', 'roberto.morales@unicesar.edu.co', '3023456789', 'activo', 2),
(6, '1065892106', 'Patricia Elena Gómez', 'patricia.gomez@unicesar.edu.co', '3145678901', 'activo', 2),
(7, '1065892107', 'Javier Enrique Torres', 'javier.torres@unicesar.edu.co', '3012348765', 'activo', 3),
(8, '1065892108', 'Mariana Isabel Silva', 'mariana.silva@unicesar.edu.co', '3045671234', 'activo', 3),
(9, '1065892109', 'Jorge Luis Benítez', 'jorge.benitez@unicesar.edu.co', '3187654321', 'activo', 3),
(10, '1065892110', 'Camila Andrea Vega', 'camila.vega@unicesar.edu.co', '3129873412', 'inactivo', 3),
(11, '1065892111', 'Wilson José Arrieta', 'wilson.arrieta@unicesar.edu.co', '3167890123', 'activo', 4);

-- 3. REGISTRAR TÉCNICOS (Especialización de Usuarios id: 2, 3, 4, 5, 6)
INSERT INTO TECNICOS (user_id, especialidad) VALUES
(2, 'Infraestructura de Redes y Conectividad'),
(3, 'Mantenimiento Correctivo de Hardware'),
(4, 'Sistemas Eléctricos y Climatización'),
(5, 'Soporte de Software y Servidores'),
(6, 'Cerrajería y Mobiliario Técnico');

-- 4. INSERTAR REPORTES / TICKETS
INSERT INTO REPORTES (id_reporte, ticket, descripcion, prioridad, costo_estimado, user_id, ubicacion_id, categoria_id, estado_id) VALUES
(1, 'TCK-2026-001', 'El aire acondicionado del laboratorio 201 no enfría y presenta goteo continuo.', 'Alta', 120000.00, 7, 1, 3, 2),
(2, 'TCK-2026-002', 'Sin acceso a la red de cableado en el puesto de consulta 04 de biblioteca.', 'Media', 15000.00, 8, 2, 1, 1),
(3, 'TCK-2026-003', 'Fallo de proyección en videobeam del aula C-102 durante las clases.', 'Urgente', 350000.00, 9, 5, 2, 3),
(4, 'TCK-2026-004', 'Toma corriente sin energía en el área de lockers.', 'Baja', 25000.00, 7, 4, 3, 1),
(5, 'TCK-2026-005', 'Falla de conexión WiFi institucional en el área administrativa tercer piso.', 'Alta', 50000.00, 8, 3, 1, 2),
(6, 'TCK-2026-006', 'Computador de recepción no enciende tras descarga eléctrica de tormenta.', 'Urgente', 280000.00, 9, 3, 2, 1),
(7, 'TCK-2026-007', 'Mesa de trabajo fracturada y sin soporte en la sala de lectura.', 'Media', 45000.00, 7, 2, 5, 4);

-- 5. ASIGNACIÓN DE TÉCNICOS A REPORTES (M:N)
-- Caso 1: El reporte 3 tiene dos técnicos asignados (2 y 3). El técnico 2 tiene varios reportes.
-- Caso 2: Los reportes TCK-002, TCK-004 y TCK-006 quedan sin técnico asignado.
INSERT INTO ASIGNADO_A (user_id, id_reporte, fecha_asig) VALUES
(4, 1, '2026-10-10 08:30:00'),
(2, 3, '2026-10-11 09:15:00'),
(3, 3, '2026-10-11 09:20:00'),
(2, 5, '2026-10-12 14:00:00'),
(5, 5, '2026-10-12 14:10:00'),
(3, 7, '2026-10-13 10:00:00');

-- 6. INSERTAR COMENTARIOS EN REPORTES
-- Caso 1: El reporte 3 tiene varios comentarios de seguimiento.
-- Caso 2: Los reportes TCK-002, TCK-004 y TCK-006 no tienen comentarios (para probar LEFT JOIN).
INSERT INTO COMENTARIOS (comentario_id, contenido, fecha_creacion, user_id, id_reporte) VALUES
(1, 'Se realizó inspección inicial, el compresor requiere revisión técnica especializada.', '2026-10-10 10:00:00', 4, 1),
(2, 'Favor revisar lo antes posible, afecta la clase magistral de 10:00 AM.', '2026-10-11 07:30:00', 9, 3),
(3, 'Se cambió el cable HDMI y el equipo volvió a proyectar correctamente.', '2026-10-11 11:45:00', 3, 3),
(4, 'El profesor confirma que la imagen es nítida. Listo para cierre.', '2026-10-11 12:00:00', 2, 3),
(5, 'El problema de conexión persiste intermitentemente en horas de la tarde.', '2026-10-12 16:30:00', 8, 5),
(6, 'Se solicitó reemplazo de tornillos y nivelación de superficie.', '2026-10-13 11:15:00', 3, 7);

-- 7. REGISTRAR HISTORIAL DE CAMBIOS DE ESTADO
INSERT INTO HISTORIAL_REPORTES (historial_id, fecha_cambio, observacion, id_reporte, estado_id) VALUES
(1, '2026-10-10 08:00:00', 'Registro inicial del ticket por el usuario.', 1, 1),
(2, '2026-10-10 08:30:00', 'Asignado a Diana Carolina Orozco.', 1, 2),
(3, '2026-10-11 07:00:00', 'Registro inicial del ticket por el usuario.', 3, 1),
(4, '2026-10-11 09:15:00', 'Asignado a técnicos de redes y hardware.', 3, 2),
(5, '2026-10-11 11:50:00', 'Incidencia resuelta satisfactoriamente.', 3, 3),
(6, '2026-10-12 13:00:00', 'Registro inicial del ticket.', 5, 1),
(7, '2026-10-12 14:00:00', 'Asignado a Andrés Felipe Gómez y Roberto Morales.', 5, 2);

-- ============================================================
-- 8. PRUEBAS DE RECHAZO (Demostración de restricciones para sustentar)
-- Descomentar una por una para mostrar cómo PostgreSQL rechaza datos erróneos:
-- ============================================================

-- Prueba A: Falla por CHECK (estado no válido)
-- INSERT INTO USUARIOS (user_id, cedula, nombre, email, telefono, estado, id_rol) 
-- VALUES (99, '99999999', 'Prueba Fallo', 'fallo@unicesar.edu.co', '3000000000', 'suspendido', 3);

-- Prueba B: Falla por UNIQUE (cédula ya existente)
-- INSERT INTO USUARIOS (user_id, cedula, nombre, email, telefono, estado, id_rol) 
-- VALUES (99, '1065892101', 'Duplicado', 'otro@unicesar.edu.co', '3001112233', 'activo', 3);

-- Prueba C: Falla por Llave Foránea (usuario que no existe)
-- INSERT INTO REPORTES (id_reporte, ticket, descripcion, prioridad, costo_estimado, user_id, ubicacion_id, categoria_id, estado_id)
-- VALUES (99, 'TCK-ERR-01', 'Reporte con usuario fantasma', 'Media', 0.00, 999, 1, 1, 1);

-- Prueba D: Falla por ON DELETE RESTRICT (no deja borrar un rol que tiene usuarios)
-- DELETE FROM ROLES WHERE id_rol = 1;