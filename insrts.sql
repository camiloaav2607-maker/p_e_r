SET search_path TO concesionario;

-- Inserción de Vehículos
INSERT INTO vehiculos (marca, modelo, año, estado, precio, disponibilidad) VALUES 
('Mazda', 'MX5', 2027, 'Nuevo', 178985000.00, 'Disponible'),
('Mazda', 'CX30', 2026, 'Usado', 118898500.00, 'Vendido'),
('Renault', 'Clio', 2018, 'Usado', 28000000.00, 'Vendido'),
('Toyota', 'Tacoma', 2027, 'Nuevo', 520000000.00, 'Disponible'),
('Chevrolet', 'Onix', 2024, 'Nuevo', 75000000.00, 'Vendido');

-- Inserción de Empleados
INSERT INTO empleados (nombre, identificacion, rol, contratacion) VALUES 
('Brayan Espinosa', '123456789', 'Vendedor', '2022-12-14'),
('Camilo Albarracin', '123856789', 'Service', '2024-05-26'),
('Andres Florez', '123897645', 'Service', '2020-06-20'),
('Aquiles Vendo', '456789123', 'Vendedor', '2021-07-30');

-- Inserción de Horarios de Servicio
INSERT INTO departamento_servicios (id_empleado, horario) VALUES 
(2, 'Lunes a Viernes 8:00 AM - 5:00 PM'),
(3, 'Lunes a Sábado 7:00 AM - 2:00 PM');

-- Inserción de Clientes
INSERT INTO clientes (nombre, identificacion, telefono, fecha_contacto, tipo) VALUES 
('Carlos Mendoza', '789456', '315123456', '2026-05-04', 'Comprador'),
('Ana Gomez', '7894565', '310987654', '2026-06-01', 'Comprador'),
('Andres Pastrana', '45678912', '312456789', '2026-06-12', 'Potencial'),
('Sofia Ruiz', '8963547', '316554433', '2026-06-20', 'Potencial');

-- Relación de Vehículos de Interés para Clientes Potenciales
INSERT INTO clientes_interes (id_cliente, id_vehiculo) VALUES 
(3, 1), -- Andres está interesado en el Mazda MX5
(4, 4); -- Sofia está interesada en la Toyota Tacoma

-- Inserción de Ventas (Registros coherentes)
-- Argumentos: id_vendedor, id_cliente, id_vehiculo, fecha, total, comision (ej. 5%)
INSERT INTO ventas (id_vendedor, id_cliente, id_vehiculo, fecha_venta, total_venta, comision_generada) VALUES 
(1, 1, 2, '2026-05-10', 118898500.00, 5944925.00), -- Brayan le vendió a Carlos
(4, 2, 3, '2026-06-15', 28000000.00, 1400000.00),  -- Aquiles le vendió a Ana
(1, 1, 5, '2026-06-25', 75000000.00, 3750000.00);  -- Brayan le vendió OTRO carro a Carlos (Para pruebas de recompra)

-- Inserción de Proveedores
INSERT INTO proveedores (nombre) VALUES 
('Mitsubishi Parts'),
('Bosch Automotive'),
('Mazda Genuine Parts');

-- Inserción de Historial de Servicios
INSERT INTO historial_servicios (servicio, fecha, id_empleado, id_vehiculo, id_proveedor) VALUES 
('Mantenimiento', '2026-05-20', 2, 2, 3), -- Camilo atendió el Mazda CX30 usando piezas de Mazda
('Reparacion', '2026-06-18', 3, 3, 2);    -- Andres atendió el Renault Clio usando repuestos Bosch
