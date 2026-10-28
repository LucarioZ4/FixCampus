-- Migración 001: Tablas independientes de catálogo

CREATE TABLE ROLES (
    id_rol INT PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE UBICACIONES (
    ubicacion_id INT PRIMARY KEY,
    nombre_lugar VARCHAR(100) NOT NULL,
    direccion VARCHAR(150) NOT NULL
);

CREATE TABLE CATEGORIAS (
    categoria_id INT PRIMARY KEY,
    nombre_cat VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT
);

CREATE TABLE ESTADOS (
    estado_id INT PRIMARY KEY,
    nombre_estado VARCHAR(50) NOT NULL UNIQUE,
    color VARCHAR(20) NOT NULL DEFAULT '#000000'
);

-- Migración 002: Usuarios y especialización ISA (Técnicos)

CREATE TABLE USUARIOS (
    user_id INT PRIMARY KEY,
    cedula VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(20),
    estado VARCHAR(20) NOT NULL DEFAULT 'activo',
    id_rol INT NOT NULL,
    CONSTRAINT fk_usuarios_roles FOREIGN KEY (id_rol) 
        REFERENCES ROLES(id_rol) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_usuario_estado CHECK (estado IN ('activo', 'inactivo', 'bloqueado'))
);

-- Especialización ISA
CREATE TABLE TECNICOS (
    user_id INT PRIMARY KEY,
    especialidad VARCHAR(100) NOT NULL,
    CONSTRAINT fk_tecnicos_usuarios FOREIGN KEY (user_id) 
        REFERENCES USUARIOS(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Migración 003: Reportes y tabla intermedia M:N con técnicos

CREATE TABLE REPORTES (
    id_reporte INT PRIMARY KEY,
    ticket VARCHAR(20) NOT NULL UNIQUE,
    descripcion TEXT NOT NULL,
    prioridad VARCHAR(20) NOT NULL DEFAULT 'Media',
    costo_estimado NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
    user_id INT NOT NULL,           -- Creador del reporte
    ubicacion_id INT NOT NULL,      -- Dónde se ubica
    categoria_id INT NOT NULL,      -- Categoría del reporte
    estado_id INT NOT NULL,         -- Estado actual
    CONSTRAINT fk_reportes_usuarios FOREIGN KEY (user_id) 
        REFERENCES USUARIOS(user_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_reportes_ubicaciones FOREIGN KEY (ubicacion_id) 
        REFERENCES UBICACIONES(ubicacion_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_reportes_categorias FOREIGN KEY (categoria_id) 
        REFERENCES CATEGORIAS(categoria_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_reportes_estados FOREIGN KEY (estado_id) 
        REFERENCES ESTADOS(estado_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_reportes_prioridad CHECK (prioridad IN ('Baja', 'Media', 'Alta', 'Urgente')),
    CONSTRAINT chk_reportes_costo CHECK (costo_estimado >= 0)
);

-- Relación M:N entre TECNICOS y REPORTES
CREATE TABLE ASIGNADO_A (
    user_id INT NOT NULL,
    id_reporte INT NOT NULL,
    fecha_asig TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, id_reporte),
    CONSTRAINT fk_asignado_tecnicos FOREIGN KEY (user_id) 
        REFERENCES TECNICOS(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_asignado_reportes FOREIGN KEY (id_reporte) 
        REFERENCES REPORTES(id_reporte) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Migración 004: Comentarios e Historial de Estados

CREATE TABLE COMENTARIOS (
    comentario_id INT PRIMARY KEY,
    contenido TEXT NOT NULL,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    user_id INT NOT NULL,
    id_reporte INT NOT NULL,
    CONSTRAINT fk_comentarios_usuarios FOREIGN KEY (user_id) 
        REFERENCES USUARIOS(user_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_comentarios_reportes FOREIGN KEY (id_reporte) 
        REFERENCES REPORTES(id_reporte) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE HISTORIAL_REPORTES (
    historial_id INT PRIMARY KEY,
    fecha_cambio TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    observacion TEXT,
    id_reporte INT NOT NULL,
    estado_id INT NOT NULL,
    CONSTRAINT fk_historial_reportes FOREIGN KEY (id_reporte) 
        REFERENCES REPORTES(id_reporte) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_historial_estados FOREIGN KEY (estado_id) 
        REFERENCES ESTADOS(estado_id) ON DELETE RESTRICT ON UPDATE CASCADE
);
