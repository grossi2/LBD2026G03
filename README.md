# Sistema de Gestion para Farmacias

Repositorio del trabajo practico de Laboratorio de Bases de Datos. El proyecto modela una base de datos para la gestion operativa de una farmacia.

## Descripcion

La solucion contempla la administracion de:

- productos y monodrogas;
- proveedores y usuarios;
- compras y ventas;
- stock, lotes y fechas de vencimiento.

El objetivo es centralizar la informacion necesaria para el seguimiento diario de la farmacia y facilitar consultas sobre operaciones, inventario y trazabilidad de productos.

## Tecnologias y herramientas

- MySQL 8.0
- MySQL Workbench para el modelado

## Contenido del repositorio

El repositorio incluye el archivo `LBD2026G03TP2.zip`, que contiene:

- `LBD2026G03Script.sql`: crea la base de datos `LBD2026G03Farmacia`, sus tablas, restricciones, indices y datos de prueba.
- `LBD2026G03TP2.sql`: contiene las consultas desarrolladas para el trabajo practico.

## Como ejecutar

1. Descargar o descomprimir `LBD2026G03TP2.zip`.
2. Abrir MySQL Workbench o cualquier cliente compatible con MySQL 8.0.
3. Conectarse a una instancia de MySQL Server.
4. Ejecutar `LBD2026G03Script.sql` para crear el esquema y cargar los datos iniciales.
5. Ejecutar `LBD2026G03TP2.sql` sobre la base creada para correr las consultas del trabajo.

## Resultado esperado

Al finalizar la ejecucion, deberia quedar creada la base `LBD2026G03Farmacia` con su estructura completa y datos de ejemplo, lista para validar las consultas entregadas.
