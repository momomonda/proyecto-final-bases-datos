-- Habilitar extensión para generar UUID si se necesitara (opcional, no usada aquí)
-- CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. Tabla Cliente
CREATE TABLE IF NOT EXISTS cliente (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    telefono VARCHAR(20),
    correo VARCHAR(150),
    direccion VARCHAR(255)
);

-- 2. Tabla Tipo de Ajuste o Reparación (Catálogo de servicios)
CREATE TABLE IF NOT EXISTS tipo_ajuste (
    id_ajuste SERIAL PRIMARY KEY,
    nombre_servicio VARCHAR(150) NOT NULL,
    descripcion TEXT,
    costo_base NUMERIC(10,2) NOT NULL
);

-- 3. Tipo ENUM para el estado de la orden
CREATE TYPE estado_orden AS ENUM ('pendiente', 'en_proceso', 'entregado', 'retrasado');

-- 4. Tabla Orden de Servicio (Relaciona al cliente y maneja la gestión de citas/entregas)
CREATE TABLE IF NOT EXISTS orden_servicio (
    id_orden SERIAL PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    fecha_cita TIMESTAMP NOT NULL,
    estado estado_orden DEFAULT 'pendiente',
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE
);

-- 5. Tabla Intermedia: Detalle Orden - Tipo de Ajuste (Relación N:M)
CREATE TABLE IF NOT EXISTS detalle_orden_ajuste (
    id_orden INTEGER NOT NULL,
    id_ajuste INTEGER NOT NULL,
    PRIMARY KEY (id_orden, id_ajuste),
    FOREIGN KEY (id_orden) REFERENCES orden_servicio(id_orden) ON DELETE CASCADE,
    FOREIGN KEY (id_ajuste) REFERENCES tipo_ajuste(id_ajuste) ON DELETE CASCADE
);

-- 6. Tabla Mano de Obra (Relacionada 1:N con la orden de servicio)
CREATE TABLE IF NOT EXISTS mano_obra (
    id_mano_obra SERIAL PRIMARY KEY,
    id_orden INTEGER NOT NULL,
    descripcion_labor VARCHAR(255) NOT NULL,
    tiempo_invertido_horas NUMERIC(5,2) NOT NULL,
    costo_operario NUMERIC(10,2) NOT NULL,
    FOREIGN KEY (id_orden) REFERENCES orden_servicio(id_orden) ON DELETE CASCADE
);
