-- 1. CLIENTES
INSERT INTO cliente (nombre, telefono, correo, direccion)
VALUES
('Carlos Gómez', '3001112233', 'carlos@gmail.com', 'Sabaneta'),
('Andrés Martínez', '3012223344', 'andres@gmail.com', 'Envigado'),
('Laura Rodríguez', '3023334455', 'laura@gmail.com', 'Medellín'),
('Felipe Torres', '3034445566', 'felipe@gmail.com', 'Itagüí'),
('Juan Pérez', '3045556677', 'juan@gmail.com', 'La Estrella');


-- 2. TIPOS DE AJUSTE O REPARACIÓN
INSERT INTO tipo_ajuste (nombre_servicio, descripcion, costo_base)
VALUES
('Cambio de aceite', 'Cambio de aceite y filtro del motor', 60000),
('Cambio de frenos', 'Revisión y cambio de pastillas de freno', 120000),
('Revisión de motor', 'Diagnóstico general del motor', 150000),
('Cambio de batería', 'Instalación de batería nueva', 180000),
('Ajuste de suspensión', 'Revisión y ajuste del sistema de suspensión', 100000);


-- 3. ÓRDENES DE SERVICIO
INSERT INTO orden_servicio (id_cliente, fecha_cita, estado)
VALUES
(1, '2026-09-15 08:00:00', 'pendiente'),
(2, '2026-09-15 09:30:00', 'en_proceso'),
(3, '2026-09-16 10:00:00', 'entregado'),
(4, '2026-09-16 14:00:00', 'pendiente'),
(5, '2026-09-17 08:30:00', 'retrasado');


-- 4. DETALLE ORDEN - AJUSTE
INSERT INTO detalle_orden_ajuste (id_orden, id_ajuste)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);


-- 5. MANO DE OBRA
INSERT INTO mano_obra
(id_orden, descripcion_labor, tiempo_invertido_horas, costo_operario)
VALUES
(1, 'Cambio de aceite y filtro', 1.50, 40000),
(2, 'Cambio de pastillas de freno', 2.50, 70000),
(3, 'Diagnóstico y revisión del motor', 3.00, 90000),
(4, 'Instalación de batería', 1.00, 30000),
(5, 'Ajuste del sistema de suspensión', 2.00, 60000);
