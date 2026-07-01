-- Crear el esquema correctamente
CREATE SCHEMA IF NOT EXISTS concesionario;
SET search_path TO concesionario;

-- 1. Enums de control
CREATE TYPE estado_auto AS ENUM ('Nuevo', 'Usado');
CREATE TYPE tipo_empleado AS ENUM ('Vendedor', 'Service');
CREATE TYPE tipo_cliente AS ENUM ('Comprador', 'Potencial');
CREATE TYPE tipo_de_servicio AS ENUM ('Mantenimiento', 'Reparacion');
CREATE TYPE estado_disponibilidad AS ENUM ('Disponible', 'Vendido');

-- 2. Tabla de Vehículos
CREATE TABLE vehiculos (
    id SERIAL PRIMARY KEY,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    año INT NOT NULL,
    estado estado_auto NOT NULL,
    precio DECIMAL(12,2) NOT NULL,
    disponibilidad estado_disponibilidad DEFAULT 'Disponible'
);

-- 3. Tabla de Empleados
CREATE TABLE empleados (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    identificacion VARCHAR(50) UNIQUE NOT NULL,
    rol tipo_empleado NOT NULL,
    contratacion DATE NOT NULL -- Formato estándar: YYYY-MM-DD
);

-- 4. Tabla de Clientes
CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    identificacion VARCHAR(50) UNIQUE NOT NULL,
    telefono VARCHAR(15),
    fecha_contacto DATE NOT NULL,
    tipo tipo_cliente NOT NULL
);

-- 5. Tabla Intermedia: Vehículos de Interés (Para Clientes Potenciales)
CREATE TABLE clientes_interes (
    id_cliente INT REFERENCES clientes(id) ON DELETE CASCADE,
    id_vehiculo INT REFERENCES vehiculos(id) ON DELETE CASCADE,
    PRIMARY KEY (id_cliente, id_vehiculo)
);

-- 6. Tabla de Ventas (Aquí se conecta todo el flujo comercial)
CREATE TABLE ventas (
    id SERIAL PRIMARY KEY,
    id_vendedor INT NOT NULL REFERENCES empleados(id),
    id_cliente INT NOT NULL REFERENCES clientes(id),
    id_vehiculo INT NOT NULL REFERENCES vehiculos(id) UNIQUE, -- Un vehículo específico solo se vende una vez
    fecha_venta DATE NOT NULL,
    total_venta DECIMAL(12,2) NOT NULL,
    comision_generada DECIMAL(12,2) NOT NULL
);

-- 7. Tabla de Proveedores
CREATE TABLE proveedores (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- 8. Tabla de Historial de Servicios
CREATE TABLE historial_servicios (
    id SERIAL PRIMARY KEY,
    servicio tipo_de_servicio NOT NULL,
    fecha DATE NOT NULL,
    id_empleado INT NOT NULL REFERENCES empleados(id),
    id_vehiculo INT NOT NULL REFERENCES vehiculos(id),
    id_proveedor INT REFERENCES proveedores(id) -- Puede ser NULL si no se usaron piezas
);

-- 9. Tabla de Departamento de Servicios (Horarios de técnicos)
CREATE TABLE departamento_servicios (
    id_empleado INT PRIMARY KEY REFERENCES empleados(id) ON DELETE CASCADE,
    horario VARCHAR(50) NOT NULL
);
