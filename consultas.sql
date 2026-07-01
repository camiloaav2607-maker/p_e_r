SET search_path TO concesionario;

-- 1. Listar Vehículos Disponibles
-- Obtiene marca, modelo y precio de autos que no han sido vendidos.
SELECT marca, modelo, precio 
FROM vehiculos 
WHERE disponibilidad = 'Disponible';


-- 2. Clientes con Compras Recientes
-- Muestra clientes y los datos del vehículo que adquirieron, ordenados del más reciente al más antiguo.
SELECT c.nombre AS cliente, v.marca, v.modelo, vt.fecha_venta
FROM ventas vt
INNER JOIN clientes c ON vt.id_cliente = c.id
INNER JOIN vehiculos v ON vt.id_vehiculo = v.id
ORDER BY vt.fecha_venta DESC;


-- 3. Historial de Servicios por Vehículo
-- Historial completo filtrando por un vehículo específico (Ej: id_vehiculo = 2) mostrando el técnico encargado.
SELECT hs.id AS registro_servicio, hs.fecha, hs.servicio, e.nombre AS tecnico_encargado
FROM historial_servicios hs
INNER JOIN empleados e ON hs.id_empleado = e.id
WHERE hs.id_vehiculo = 2;


-- 4. Proveedores de Piezas Utilizadas
-- Lista de proveedores únicos cuyos componentes se hayan usado en servicios reales.
SELECT DISTINCT p.nombre AS proveedor_utilizado
FROM historial_servicios hs
INNER JOIN proveedores p ON hs.id_proveedor = p.id;


-- 5. Rendimiento del Personal de Ventas
-- Calcula las comisiones totales acumuladas por vendedor en un rango específico de fechas.
SELECT e.nombre AS vendedor, SUM(vt.comision_generada) AS total_comisiones
FROM ventas vt
INNER JOIN empleados e ON vt.id_vendedor = e.id
WHERE vt.fecha_venta BETWEEN '2026-01-01' AND '2026-06-30'
GROUP BY e.id, e.nombre;


-- 6. Servicios Realizados por un Empleado
-- Identifica los mantenimientos que hizo un empleado específico (Ej: id_empleado = 2) y qué vehículo atendió.
SELECT hs.servicio, hs.fecha, v.marca, v.modelo AS modelo_vehiculo
FROM historial_servicios hs
INNER JOIN vehiculos v ON hs.id_vehiculo = v.id
WHERE hs.id_empleado = 2;


-- 7. Clientes Potenciales y Vehículos de Interés
-- Cruza la información de leads y los vehículos que están buscando para el equipo de marketing.
SELECT c.nombre AS cliente_potencial, c.telefono, v.marca, v.modelo AS vehiculo_interes
FROM clientes_interes ci
INNER JOIN clientes c ON ci.id_cliente = c.id
INNER JOIN vehiculos v ON ci.id_vehiculo = v.id
WHERE c.tipo = 'Potencial';


-- 8. Empleados del Departamento de Servicio
-- Lista de los mecánicos/técnicos junto con sus jornadas y turnos de trabajo.
SELECT e.nombre AS empleado_servicio, ds.horario
FROM departamento_servicios ds
INNER JOIN empleados e ON ds.id_empleado = e.id
WHERE e.rol = 'Service';


-- 9. Vehículos vendidos en un rango de precios
-- Encuentra autos vendidos dentro de un presupuesto específico (Ej: entre 50 y 200 millones).
SELECT v.marca, v.modelo, vt.total_venta AS precio_venta, vt.fecha_venta
FROM ventas vt
INNER JOIN vehiculos v ON vt.id_vehiculo = v.id
WHERE vt.total_venta BETWEEN 50000000 AND 200000000;


-- 10. Clientes con Múltiples Compras
-- Identifica clientes leales agrupándolos por compras y filtrando con HAVING a los que tengan más de 1.
SELECT c.nombre AS cliente_fiel, c.identificacion, COUNT(vt.id) AS cantidad_vehiculos_comprados
FROM ventas vt
INNER JOIN clientes c ON vt.id_cliente = c.id
GROUP BY c.id, c.nombre, c.identificacion
HAVING COUNT(vt.id) > 1;
