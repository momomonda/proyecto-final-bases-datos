PRAGMA foreign_keys = ON

-- 1. Tabla Cliente
CREATE TABLE IF NOT EXISTS cliente (
    id_cliente INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    telefono TEXT,
    correo TEXT,
    direccion TEXT
); 

-- 2. Tabla Tipo de Ajuste o Reparación (Catálogo de servicios)
CREATE TABLE IF NOT EXISTS tipo_ajuste (
    id_ajuste INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_servicio TEXT NOT NULL,
    descripcion TEXT,
    costo_base REAL NOT NULL
);

-- 3. Tabla Orden de Servicio (Relaciona al cliente y maneja la gestión de citas/entregas)
CREATE TABLE IF NOT EXISTS orden_servicio (
    id_orden INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente INTEGER NOT NULL,
    fecha_cita DATETIME NOT NULL,
    estado TEXT CHECK(estado IN ('pendiente', 'en_proceso', 'entregado', 'retrasado')) DEFAULT 'pendiente',
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE
);

-- 4. Tabla Intermedia: Detalle Orden - Tipo de Ajuste (Relación N:M)
CREATE TABLE IF NOT EXISTS detalle_orden_ajuste (
    id_orden INTEGER NOT NULL,
    id_ajuste INTEGER NOT NULL,
    PRIMARY KEY (id_orden, id_ajuste),
    FOREIGN KEY (id_orden) REFERENCES orden_servicio(id_orden) ON DELETE CASCADE,
    FOREIGN KEY (id_ajuste) REFERENCES tipo_ajuste(id_ajuste) ON DELETE CASCADE
);

-- 5. Tabla Mano de Obra (Relacionada 1:N con la orden de servicio o el ajuste)
CREATE TABLE IF NOT EXISTS mano_obra (
    id_mano_obra INTEGER PRIMARY KEY AUTOINCREMENT,
    id_orden INTEGER NOT NULL,
    descripcion_labor TEXT NOT NULL,
    tiempo_invertido_horas REAL NOT NULL,
    costo_operario REAL NOT NULL,
    FOREIGN KEY (id_orden) REFERENCES orden_servicio(id_orden) ON DELETE CASCADE
);