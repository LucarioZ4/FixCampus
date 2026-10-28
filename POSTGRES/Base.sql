-- Migración 001: Tablas independientes de catálogo

CREATE TABLE ROLES (
    id_rol INT PRIMARY KEY AUTO_INCREMENT,
    nombre_rol VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE UBICACIONES (
    ubicacion_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_lugar VARCHAR(100) NOT NULL,
    direccion VARCHAR(150) NOT NULL
);

CREATE TABLE CATEGORIAS (
    categoria_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_cat VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT
);

CREATE TABLE ESTADOS (
    estado_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_estado VARCHAR(50) NOT NULL UNIQUE,
    color VARCHAR(20) NOT NULL DEFAULT '#000000'
);

-- Migración 002: Usuarios y especialización ISA (Técnicos)

CREATE TABLE USUARIOS (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
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
    id_reporte INT PRIMARY KEY AUTO_INCREMENT,
    ticket VARCHAR(20) NOT NULL UNIQUE,
    descripcion TEXT NOT NULL,
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
        REFERENCES ESTADOS(estado_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Relación M:N entre TECNICOS y REPORTES
CREATE TABLE ASIGNADO_A (
    user_id INT NOT NULL,
    id_reporte INT NOT NULL,
    fecha_asig DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, id_reporte),
    CONSTRAINT fk_asignado_tecnicos FOREIGN KEY (user_id) 
        REFERENCES TECNICOS(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_asignado_reportes FOREIGN KEY (id_reporte) 
        REFERENCES REPORTES(id_reporte) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Migración 004: Comentarios e Historial de Estados

CREATE TABLE COMENTARIOS (
    comentario_id INT PRIMARY KEY AUTO_INCREMENT,
    contenido TEXT NOT NULL,
    fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    user_id INT NOT NULL,
    id_reporte INT NOT NULL,
    CONSTRAINT fk_comentarios_usuarios FOREIGN KEY (user_id) 
        REFERENCES USUARIOS(user_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_comentarios_reportes FOREIGN KEY (id_reporte) 
        REFERENCES REPORTES(id_reporte) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE HISTORIAL_REPORTES (
    historial_id INT PRIMARY KEY AUTO_INCREMENT,
    fecha_cambio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    observacion TEXT,
    id_reporte INT NOT NULL,
    estado_id INT NOT NULL,
    CONSTRAINT fk_historial_reportes FOREIGN KEY (id_reporte) 
        REFERENCES REPORTES(id_reporte) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_historial_estados FOREIGN KEY (estado_id) 
        REFERENCES ESTADOS(estado_id) ON DELETE RESTRICT ON UPDATE CASCADE
);
