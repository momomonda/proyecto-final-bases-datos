SET FOREIGN_KEY_CHECKS = 1;

-- 1. Tabla Cliente
CREATE TABLE IF NOT EXISTS cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    telefono VARCHAR(20),
    correo VARCHAR(150),
    direccion VARCHAR(255)
) ENGINE=InnoDB;

-- 2. Tabla Tipo de Ajuste o Reparación (Catálogo de servicios)
CREATE TABLE IF NOT EXISTS tipo_ajuste (
    id_ajuste INT AUTO_INCREMENT PRIMARY KEY,
    nombre_servicio VARCHAR(150) NOT NULL,
    descripcion TEXT,
    costo_base DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;

-- 3. Tabla Orden de Servicio (Relaciona al cliente y maneja la gestión de citas/entregas)
CREATE TABLE IF NOT EXISTS orden_servicio (
    id_orden INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    fecha_cita DATETIME NOT NULL,
    estado ENUM('pendiente', 'en_proceso', 'entregado', 'retrasado') DEFAULT 'pendiente',
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 4. Tabla Intermedia: Detalle Orden - Tipo de Ajuste (Relación N:M)
CREATE TABLE IF NOT EXISTS detalle_orden_ajuste (
    id_orden INT NOT NULL,
    id_ajuste INT NOT NULL,
    PRIMARY KEY (id_orden, id_ajuste),
    FOREIGN KEY (id_orden) REFERENCES orden_servicio(id_orden) ON DELETE CASCADE,
    FOREIGN KEY (id_ajuste) REFERENCES tipo_ajuste(id_ajuste) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 5. Tabla Mano de Obra (Relacionada 1:N con la orden de servicio)
CREATE TABLE IF NOT EXISTS mano_obra (
    id_mano_obra INT AUTO_INCREMENT PRIMARY KEY,
    id_orden INT NOT NULL,
    descripcion_labor VARCHAR(255) NOT NULL,
    tiempo_invertido_horas DECIMAL(5,2) NOT NULL,
    costo_operario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_orden) REFERENCES orden_servicio(id_orden) ON DELETE CASCADE
) ENGINE=InnoDB;