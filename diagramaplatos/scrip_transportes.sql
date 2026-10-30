CREATE DATABASE IF NOT EXISTS gestion_transportes;
USE gestion_transportes;

-- 1. Crear tabla EMPLEADO (Superentidad de la jerarquía)
CREATE TABLE empleado (
    dni VARCHAR(9),
    nombre VARCHAR(100) NOT NULL,
    f_nacimiento DATE NOT NULL,
    PRIMARY KEY (dni)
) ENGINE=InnoDB;

-- 2. Crear tabla CONDUCTOR (Subentidad que hereda de Empleado)
CREATE TABLE conductor (
    dni VARCHAR(9),
    num_licencia VARCHAR(50) NOT NULL UNIQUE,
    f_alta DATE NOT NULL,
    PRIMARY KEY (dni),
    FOREIGN KEY (dni) REFERENCES empleado(dni)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 3. Crear tabla PERSONAL_ALMACEN (Subentidad que hereda de Empleado)
CREATE TABLE personal_almacen (
    dni VARCHAR(9),
    turno_trabajo ENUM('mañana', 'tarde') NOT NULL,
    PRIMARY KEY (dni),
    FOREIGN KEY (dni) REFERENCES empleado(dni)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 4. Crear tabla CONDUCTOR_TELEFONO (Tabla para el atributo multivalorado)
CREATE TABLE conductor_telefono (
    dni VARCHAR(9),
    telefono VARCHAR(15),
    PRIMARY KEY (dni, telefono),
    FOREIGN KEY (dni) REFERENCES conductor(dni)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 5. Crear tabla VEHICULO (Entidad fuerte)
CREATE TABLE vehiculo (
    id_vehiculo INT AUTO_INCREMENT,
    modelo VARCHAR(100) NOT NULL,
    f_alta DATE NOT NULL,
    PRIMARY KEY (id_vehiculo)
) ENGINE=InnoDB;

-- 6. Crear tabla RUTA (Entidad débil por identidad respecto a VEHICULO)
CREATE TABLE ruta (
    id_vehiculo INT,
    num_orden_ruta INT, -- Discriminador / Clave parcial
    dni_conductor VARCHAR(9) NOT NULL, -- FK que conecta al conductor que la realiza (1:N)
    PRIMARY KEY (id_vehiculo, num_orden_ruta), -- Clave primaria compuesta por dependencia
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculo(id_vehiculo)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (dni_conductor) REFERENCES conductor(dni)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 7. Crear tabla PAQUETE (Entidad fuerte)
CREATE TABLE paquete (
    id_paquete INT AUTO_INCREMENT,
    descripcion TEXT,
    PRIMARY KEY (id_paquete)
) ENGINE=InnoDB;

-- 8. Crear tabla RUTA_PAQUETE (Tabla intermedia M:N con atributo de relación)
CREATE TABLE ruta_paquete (
    id_vehiculo INT,
    num_orden_ruta INT,
    id_paquete INT,
    hora_estimada_entrega DATETIME NOT NULL, -- Atributo propio de la relación
    PRIMARY KEY (id_vehiculo, num_orden_ruta, id_paquete),
    FOREIGN KEY (id_vehiculo, num_orden_ruta) REFERENCES ruta(id_vehiculo, num_orden_ruta)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_paquete) REFERENCES paquete(id_paquete)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;
