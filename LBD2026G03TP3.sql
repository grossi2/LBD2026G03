-- Ano: 2026
-- Grupo Nro: 03
-- Integrantes: Singh Neelam Rocio del Milagro, Villanueva Giribaldi Camilo
-- Tema: Sistema de Gestion para Farmacia
-- Nombre del Esquema: LBD2026G03Farmacia
-- Plataforma (SO + Version): Windows
-- Motor y Version: MySQL Server 8.0
-- GitHub Repositorio: LBD2026G03
-- GitHub Usuarios: RooSingh, VillanuevaGiribaldi

use LBD2026G03Farmacia;

-- -----------------------------------------------------
-- Tabla auditoría de usuarios - aud_usuarios
-- -----------------------------------------------------

DROP TABLE IF EXISTS aud_usuarios;

CREATE TABLE IF NOT EXISTS aud_usuarios (
    Id BIGINT NOT NULL AUTO_INCREMENT,
    FechaAud DATETIME NOT NULL,
    UsuarioAud VARCHAR(30) NOT NULL,
    IP VARCHAR(40) NOT NULL,
    UserAgent VARCHAR(255) NULL,
    TipoAud CHAR(1) NOT NULL, -- Tipo de auditoria (I: Inserción, B: Borrado, A: Modificación (Antes), D: Modificación (Después))
    `IdUsuario` INT NOT NULL,
    `Nombre` VARCHAR(45) NOT NULL,
    `Apellido` VARCHAR(45) NOT NULL,
    `NombreUsuario` VARCHAR(45) NOT NULL,
    `Dni` VARCHAR(9) NOT NULL,
    `Sexo` CHAR(1) NOT NULL,
    `Edad` TINYINT UNSIGNED NOT NULL,
    `Direccion` VARCHAR(120) NOT NULL,
    `Telefono` VARCHAR(20) NOT NULL,
    `Mail` VARCHAR(100) NOT NULL,
    `EstadoCivil` VARCHAR(20) NOT NULL,
    `Puesto` ENUM('GERENTE', 'EMPLEADO') NOT NULL DEFAULT 'EMPLEADO',
    `AntiguedadAnios` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `Estado` CHAR(1) NOT NULL DEFAULT 'A',
    `Contrasena` VARCHAR(60) NOT NULL,
    PRIMARY KEY (Id),
    INDEX IX_FechaAud (FechaAud ASC),
    INDEX IX_Usuario (UsuarioAud ASC),
    INDEX IX_IP (IP ASC)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- TRIGGERS
-- -----------------------------------------------------

-- -----------------------------------------------------
-- 1 - Creación
-- -----------------------------------------------------

DROP TRIGGER IF EXISTS trig_usuarios_creacion;

DELIMITER //

CREATE TRIGGER trig_usuarios_creacion 
AFTER INSERT ON Usuarios FOR EACH ROW 
BEGIN
	INSERT INTO aud_usuarios (
		Id,
		FechaAud,
		UsuarioAud,
		IP,
		UserAgent,
		TipoAud,
		IdUsuario,
		Nombre,
		Apellido,
		NombreUsuario,
		Dni,
		Sexo,
		Edad,
		Direccion,
		Telefono,
		Mail,
		EstadoCivil,
		Puesto,
		AntiguedadAnios,
		Estado,
		Contrasena
	) VALUES(
		0, 
        NOW(), 
        SUBSTRING_INDEX(USER(),'@',1), 
        SUBSTRING_INDEX(USER(),'@',-1), 
        NULL,
        'I',
		NEW.IdUsuario,
        NEW.Nombre,
        NEW.Apellido,
        NEW.NombreUsuario,
        NEW.Dni,
        NEW.Sexo,
        NEW.Edad,
        NEW.Direccion,
        NEW.Telefono,
        NEW.Mail,
        NEW.EstadoCivil,
        NEW.Puesto,
        NEW.AntiguedadAnios,
        NEW.Estado,
        NEW.Contrasena
        );
END//

DELIMITER;

-- -----------------------------------------------------
-- 2 - Modificación
-- -----------------------------------------------------

DROP TRIGGER IF EXISTS trig_usuarios_modificacion;

DELIMITER //

CREATE TRIGGER trig_usuarios_modificacion 
AFTER UPDATE ON Usuarios 
FOR EACH ROW BEGIN
	INSERT INTO aud_usuarios (
		Id,
		FechaAud,
		UsuarioAud,
		IP,
		UserAgent,
		TipoAud,
		IdUsuario,
		Nombre,
		Apellido,
		NombreUsuario,
		Dni,
		Sexo,
		Edad,
		Direccion,
		Telefono,
		Mail,
		EstadoCivil,
		Puesto,
		AntiguedadAnios,
		Estado,
		Contrasena
	) VALUES(
		0, 
        NOW(), 
        SUBSTRING_INDEX(USER(),'@',1), 
        SUBSTRING_INDEX(USER(),'@',-1), 
        NULL,
        'A',
		OLD.IdUsuario,
        OLD.Nombre,
        OLD.Apellido,
        OLD.NombreUsuario,
        OLD.Dni,
        OLD.Sexo,
        OLD.Edad,
        OLD.Direccion,
        OLD.Telefono,
        OLD.Mail,
        OLD.EstadoCivil,
        OLD.Puesto,
        OLD.AntiguedadAnios,
        OLD.Estado,
        OLD.Contrasena
        );
	INSERT INTO aud_usuarios (
		Id,
		FechaAud,
		UsuarioAud,
		IP,
		UserAgent,
		TipoAud,
		IdUsuario,
		Nombre,
		Apellido,
		NombreUsuario,
		Dni,
		Sexo,
		Edad,
		Direccion,
		Telefono,
		Mail,
		EstadoCivil,
		Puesto,
		AntiguedadAnios,
		Estado,
		Contrasena
	) VALUES(
		0, 
        NOW(), 
        SUBSTRING_INDEX(USER(),'@',1), 
        SUBSTRING_INDEX(USER(),'@',-1), 
        NULL,
        'D',
		NEW.IdUsuario,
        NEW.Nombre,
        NEW.Apellido,
        NEW.NombreUsuario,
        NEW.Dni,
        NEW.Sexo,
        NEW.Edad,
        NEW.Direccion,
        NEW.Telefono,
        NEW.Mail,
        NEW.EstadoCivil,
        NEW.Puesto,
        NEW.AntiguedadAnios,
        NEW.Estado,
        NEW.Contrasena
        );
END//

DELIMITER;

-- -----------------------------------------------------
-- 3 - Borrado
-- -----------------------------------------------------

DROP TRIGGER IF EXISTS trig_usuarios_borrado;

DELIMITER //

CREATE TRIGGER trig_usuarios_borrado 
AFTER DELETE ON Usuarios 
FOR EACH ROW BEGIN
	INSERT INTO aud_usuarios (
		Id,
		FechaAud,
		UsuarioAud,
		IP,
		UserAgent,
		TipoAud,
		IdUsuario,
		Nombre,
		Apellido,
		NombreUsuario,
		Dni,
		Sexo,
		Edad,
		Direccion,
		Telefono,
		Mail,
		EstadoCivil,
		Puesto,
		AntiguedadAnios,
		Estado,
		Contrasena
	) VALUES(
		0, 
        NOW(), 
        SUBSTRING_INDEX(USER(),'@',1), 
        SUBSTRING_INDEX(USER(),'@',-1), 
        NULL,
        'B',
		OLD.IdUsuario,
        OLD.Nombre,
        OLD.Apellido,
        OLD.NombreUsuario,
        OLD.Dni,
        OLD.Sexo,
        OLD.Edad,
        OLD.Direccion,
        OLD.Telefono,
        OLD.Mail,
        OLD.EstadoCivil,
        OLD.Puesto,
        OLD.AntiguedadAnios,
        OLD.Estado,
        OLD.Contrasena
        );
END
/
/

DELIMITER;

-- -----------------------------------------------------
-- PROCEDIMIENTOS ALMACENADOS
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Realizar (lo más eficientemente posible) los siguientes procedimientos almacenados,
-- incluyendo el control de errores lógicos y mensajes de error:
-- -----------------------------------------------------

-- -----------------------------------------------------
-- 4 - Creación de un usuario
-- -----------------------------------------------------

DROP PROCEDURE IF EXISTS sp_crear_usuario;

DELIMITER //

CREATE PROCEDURE sp_crear_usuario (
	IN pNombre VARCHAR(45),
	IN pApellido VARCHAR(45),
	IN pNombreUsuario VARCHAR(45),
	IN pDni VARCHAR(9),
	IN pSexo CHAR(1),
	IN pEdad TINYINT UNSIGNED,
	IN pDireccion VARCHAR(120),
	IN pTelefono VARCHAR(20),
	IN pMail VARCHAR(100),
	IN pEstadoCivil VARCHAR(20),
	IN pPuesto VARCHAR(20),
	IN pAntiguedadAnios TINYINT UNSIGNED,
	IN pEstado CHAR(1),
	IN pContrasena VARCHAR(60),
	OUT pMensaje VARCHAR(100)
)
SALIR:BEGIN
	DECLARE pIdUsuario INT;
     
	IF (pNombre IS NULL OR TRIM(pNombre) = '' OR
		pApellido IS NULL OR TRIM(pApellido) = '' OR
		pNombreUsuario IS NULL OR TRIM(pNombreUsuario) = '' OR
		pDni IS NULL OR TRIM(pDni) = '' OR
		pSexo IS NULL OR TRIM(pSexo) = '' OR
		pDireccion IS NULL OR TRIM(pDireccion) = '' OR
		pTelefono IS NULL OR TRIM(pTelefono) = '' OR
		pMail IS NULL OR TRIM(pMail) = '' OR
		pEstadoCivil IS NULL OR TRIM(pEstadoCivil) = '' OR
		pPuesto IS NULL OR TRIM(pPuesto) = '' OR
		pEstado IS NULL OR TRIM(pEstado) = '' OR
		pContrasena IS NULL OR TRIM(pContrasena) = '') THEN
        SET pMensaje = 'Campos obligatorios.';
        LEAVE SALIR;
	END IF;
    
	IF pSexo NOT IN ('F', 'M', 'X') THEN
		SET pMensaje = 'Error. El sexo debe ser F, M o X.';
		LEAVE SALIR;
	END IF;

	IF pEdad < 18 OR pEdad > 99 THEN
		SET pMensaje = 'Error. La edad debe estar entre 18 y 99 anos.';
		LEAVE SALIR;
	END IF;

	IF pPuesto NOT IN ('GERENTE', 'EMPLEADO') THEN
		SET pMensaje = 'Error. El puesto debe ser GERENTE o EMPLEADO.';
		LEAVE SALIR;
	END IF;

	IF pEstado NOT IN ('A', 'I') THEN
		SET pMensaje = 'Error. El estado debe ser A o I.';
		LEAVE SALIR;
	END IF;

	IF CHAR_LENGTH(TRIM(pContrasena)) < 6 THEN
		SET pMensaje = 'Error. La contraseña debe tener por lo menos 6 caracteres.';
        LEAVE SALIR;
	END IF;
    
	IF EXISTS (SELECT IdUsuario FROM Usuarios WHERE NombreUsuario = TRIM(pNombreUsuario)) THEN
		SET pMensaje = 'Error. Nombre de usuario ya existente.';
		LEAVE SALIR;
	END IF;

	IF EXISTS (SELECT IdUsuario FROM Usuarios WHERE Dni = TRIM(pDni)) THEN
		SET pMensaje = 'Error. DNI ya existente.';
		LEAVE SALIR;
	END IF;

	IF EXISTS (SELECT IdUsuario FROM Usuarios WHERE Mail = LOWER(TRIM(pMail))) THEN
		SET pMensaje = 'Error. Mail ya existente.';
        LEAVE SALIR;
	END IF;
    
	INSERT INTO Usuarios (
		Nombre,
		Apellido,
		NombreUsuario,
		Dni,
		Sexo,
		Edad,
		Direccion,
		Telefono,
		Mail,
		EstadoCivil,
		Puesto,
		AntiguedadAnios,
		Estado,
		Contrasena
	) VALUES (
		TRIM(pNombre),
		TRIM(pApellido),
		TRIM(pNombreUsuario),
		TRIM(pDni),
		pSexo,
		pEdad,
		TRIM(pDireccion),
		TRIM(pTelefono),
		LOWER(TRIM(pMail)),
		UPPER(TRIM(pEstadoCivil)),
		UPPER(TRIM(pPuesto)),
		pAntiguedadAnios,
		pEstado,
		TRIM(pContrasena)
	);
                             
		SET pIdUsuario = LAST_INSERT_ID();
    
	SET pMensaje = CONCAT('Usuario ', pIdUsuario, ' creado con exito.');
END//

DELIMITER;

-- Llamadas
SET @pMensaje = '';

CALL sp_crear_usuario (
    'Juan',
    'Joaquinez',
    'jjoaquinez2',
    '32145678',
    'M',
    35,
    'San Martin 500',
    '3816661101',
    'juan.joaquinez2@farmaciasanrafael.com.ar',
    'CASADO',
    'EMPLEADO',
    0,
    'A',
    '123456',
    @pMensaje
); -- Usuario creado con exito
CALL sp_crear_usuario (
    'Laura',
    'Suarez',
    'lsuarez2',
    '30111222',
    'F',
    30,
    'Roca 100',
    '3815552200',
    'laura.suarez@farmaciasanrafael.com.ar',
    'SOLTERO',
    'EMPLEADO',
    1,
    'A',
    '123456',
    @pMensaje
); -- Falla por DNI repetido
CALL sp_crear_usuario (
    'Elena',
    'Ruiz',
    'eruiz2',
    '32123458',
    'F',
    28,
    'San Juan 300',
    '3815552202',
    NULL,
    'SOLTERO',
    'EMPLEADO',
    3,
    'A',
    '123456',
    @pMensaje
); -- Falla por campos obligatorios
CALL sp_crear_usuario (
    'Pedro',
    'Acosta',
    'pacosta2',
    '32123459',
    'M',
    31,
    'Lavalle 250',
    '3815552203',
    'pedro.acosta@farmaciasanrafael.com.ar',
    'CASADO',
    'EMPLEADO',
    4,
    'A',
    '123',
    @pMensaje
); -- Falla por contrasena menor a 6 caracteres
SELECT @pMensaje AS Mensaje;

SELECT * FROM aud_usuarios;

-- -----------------------------------------------------
-- 5 - Modificación de un usuario
-- -----------------------------------------------------

DROP PROCEDURE IF EXISTS sp_modificar_usuario;

DELIMITER //
CREATE PROCEDURE sp_modificar_usuario (
	IN pIdUsuario INT,
	IN pNombre VARCHAR(45),
	IN pApellido VARCHAR(45),
	IN pNombreUsuario VARCHAR(45),
	IN pDni VARCHAR(9),
	IN pSexo CHAR(1),
	IN pEdad TINYINT UNSIGNED,
	IN pDireccion VARCHAR(120),
	IN pTelefono VARCHAR(20),
	IN pMail VARCHAR(100),
	IN pEstadoCivil VARCHAR(20),
	IN pPuesto VARCHAR(20),
	IN pAntiguedadAnios TINYINT UNSIGNED,
	IN pEstado CHAR(1),
	IN pContrasena VARCHAR(60),
	OUT pMensaje VARCHAR(100)
)
SALIR:BEGIN    
    IF (pNombre IS NULL OR TRIM(pNombre) = '' OR
		pApellido IS NULL OR TRIM(pApellido) = '' OR
		pNombreUsuario IS NULL OR TRIM(pNombreUsuario) = '' OR
		pDni IS NULL OR TRIM(pDni) = '' OR
		pSexo IS NULL OR TRIM(pSexo) = '' OR
		pDireccion IS NULL OR TRIM(pDireccion) = '' OR
		pTelefono IS NULL OR TRIM(pTelefono) = '' OR
		pMail IS NULL OR TRIM(pMail) = '' OR
		pEstadoCivil IS NULL OR TRIM(pEstadoCivil) = '' OR
		pPuesto IS NULL OR TRIM(pPuesto) = '' OR
		pEstado IS NULL OR TRIM(pEstado) = '') THEN
        SET pMensaje = 'Campos obligatorios.';
        LEAVE SALIR;
	END IF;

	IF pSexo NOT IN ('F', 'M', 'X') THEN
		SET pMensaje = 'Error. El sexo debe ser F, M o X.';
		LEAVE SALIR;
	END IF;

	IF pEdad < 18 OR pEdad > 99 THEN
		SET pMensaje = 'Error. La edad debe estar entre 18 y 99 anos.';
		LEAVE SALIR;
	END IF;

	IF pPuesto NOT IN ('GERENTE', 'EMPLEADO') THEN
		SET pMensaje = 'Error. El puesto debe ser GERENTE o EMPLEADO.';
		LEAVE SALIR;
	END IF;

	IF pEstado NOT IN ('A', 'I') THEN
		SET pMensaje = 'Error. El estado debe ser A o I.';
        LEAVE SALIR;
	END IF;
    
    IF pContrasena IS NOT NULL AND TRIM(pContrasena) <> '' AND CHAR_LENGTH(TRIM(pContrasena)) < 6 THEN
		SET pMensaje = 'Error. La contrasena debe tener por lo menos 6 caracteres.';
        LEAVE SALIR;
	END IF;
    
	IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE IdUsuario = pIdUsuario) THEN
		SET pMensaje = 'Error. Usuario no existente.';
		LEAVE SALIR;
	END IF;

	IF EXISTS (SELECT IdUsuario FROM Usuarios WHERE NombreUsuario = TRIM(pNombreUsuario) AND IdUsuario <> pIdUsuario) THEN
		SET pMensaje = 'Error. Nombre de usuario ya existente.';
		LEAVE SALIR;
	END IF;

	IF EXISTS (SELECT IdUsuario FROM Usuarios WHERE Dni = TRIM(pDni) AND IdUsuario <> pIdUsuario) THEN
		SET pMensaje = 'Error. DNI ya existente.';
		LEAVE SALIR;
	END IF;

	IF EXISTS (SELECT IdUsuario FROM Usuarios WHERE Mail = LOWER(TRIM(pMail)) AND IdUsuario <> pIdUsuario) THEN
		SET pMensaje = 'Error. Mail ya existente.';
        LEAVE SALIR;
	END IF;
    
    IF pContrasena IS NULL OR TRIM(pContrasena) = '' THEN
		UPDATE Usuarios
		SET Nombre = TRIM(pNombre),
			Apellido = TRIM(pApellido),
			NombreUsuario = TRIM(pNombreUsuario),
			Dni = TRIM(pDni),
			Sexo = pSexo,
			Edad = pEdad,
			Direccion = TRIM(pDireccion),
			Telefono = TRIM(pTelefono),
			Mail = LOWER(TRIM(pMail)),
			EstadoCivil = UPPER(TRIM(pEstadoCivil)),
			Puesto = UPPER(TRIM(pPuesto)),
			AntiguedadAnios = pAntiguedadAnios,
			Estado = pEstado
		WHERE IdUsuario = pIdUsuario;
    ELSE
		UPDATE Usuarios
		SET Nombre = TRIM(pNombre),
			Apellido = TRIM(pApellido),
			NombreUsuario = TRIM(pNombreUsuario),
			Dni = TRIM(pDni),
			Sexo = pSexo,
			Edad = pEdad,
			Direccion = TRIM(pDireccion),
			Telefono = TRIM(pTelefono),
			Mail = LOWER(TRIM(pMail)),
			EstadoCivil = UPPER(TRIM(pEstadoCivil)),
			Puesto = UPPER(TRIM(pPuesto)),
			AntiguedadAnios = pAntiguedadAnios,
			Estado = pEstado,
			Contrasena = TRIM(pContrasena)
		WHERE IdUsuario = pIdUsuario;
	END IF;
    
    SET pMensaje = 'Usuario modificado con exito.';
END//

DELIMITER ;

-- Llamadas
SET @pMensaje = '';

CALL sp_modificar_usuario (
    21,
    'Juan',
    'Joaquinez Modificado',
    'jjoaquinez2',
    '32145678',
    'M',
    36,
    'San Martin 550',
    '3816661199',
    'juan.joaquinez2@farmaciasanrafael.com.ar',
    'CASADO',
    'EMPLEADO',
    1,
    'A',
    '654321',
    @pMensaje
); -- Usuario modificado con exito
CALL sp_modificar_usuario (
    21,
    'Juan',
    'Joaquinez',
    'jperez',
    '32145678',
    'M',
    36,
    'San Martin 550',
    '3816661199',
    'juan.joaquinez3@farmaciasanrafael.com.ar',
    'CASADO',
    'EMPLEADO',
    1,
    'A',
    '654321',
    @pMensaje
); -- Falla por nombre de usuario repetido
CALL sp_modificar_usuario (
    21,
    'Juan',
    'Joaquinez',
    'jjoaquinez2',
    '32145678',
    'M',
    36,
    'San Martin 550',
    '3816661199',
    '',
    'CASADO',
    'EMPLEADO',
    1,
    'A',
    '654321',
    @pMensaje
); -- Falla por campos obligatorios
CALL sp_modificar_usuario (
    5000,
    'Juan',
    'Joaquinez',
    'jjoaquinez2',
    '32145678',
    'M',
    36,
    'San Martin 550',
    '3816661199',
    'juan.joaquinez4@farmaciasanrafael.com.ar',
    'CASADO',
    'EMPLEADO',
    1,
    'A',
    '654321',
    @pMensaje
); -- Falla porque el usuario no existe
SELECT @pMensaje AS Mensaje;

SELECT * FROM aud_usuarios;

-- -----------------------------------------------------
-- 6 - Borrado de un usuario
-- -----------------------------------------------------
drop procedure if exists sp_borrar_usuario;
DELIMITER //

CREATE PROCEDURE sp_borrar_usuario (IdUsuario int)

salir: begin
	DECLARE vMensaje VARCHAR(200);
    DECLARE eliminable boolean;
    
		-- Antes de eliminar al usuario verificar que no haya tablas con referencias a este. Se crea un mensaje indicando las tablas que referencial al usuario
	IF IdUsuario IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Por favor ingrese el id de un usuario';
		LEAVE salir;
	ELSEIF NOT exists (select 1 from Usuarios u where u.IdUsuario=IdUsuario) THEN
		set vMensaje = CONCAT('El usuario de id ',IdUsuario,' no existe');
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = vMensaje;
		LEAVE salir;
    ELSEIF exists (select 1 from LineaVentas l where l.IdUsuario=IdUsuario) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede eliminar un usuario con ventas';
		LEAVE salir;
	ELSEIF exists (select 1 from LineaCompras l where l.IdUsuario=IdUsuario) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede eliminar un usuario con compras';
		LEAVE salir;
	ELSEIF exists (select 1 from Ventas l where l.IdUsuario=IdUsuario) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede eliminar un usuario con ventas';
		LEAVE salir;
	ELSEIF exists (select 1 from Compras l where l.IdUsuario=IdUsuario) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede eliminar un usuario con compras';
		LEAVE salir;
		else    
			-- Realizados los controles se elimina el usuario
			DELETE FROM Usuarios u WHERE u.IdUsuario=IdUsuario;
	END IF;
END //
DELIMITER ;



-- Usuarios que se intentan borrar
select IdUsuario, Dni as 'ID' from Usuarios 
where IdUsuario=(select IdUsuario from Usuarios u Where u.Dni='20111222') or IdUsuario=1 or IdUsuario=(select IdUsuario from Usuarios u Where u.Dni='20555522');

-- No se provee un IdUsuario de un usuario existente
call sp_borrar_usuario (100);

-- No puede eliminarse un usuario cuyo id es referenciado en la tabla de compras
call sp_borrar_usuario ((select IdUsuario from Usuarios u Where u.Dni='20111222'));

-- No puede eliminarse un usuario cuyo id es referenciado en la tabla delineaVentas
call sp_borrar_usuario (1);

-- Borrado correcto
call sp_borrar_usuario ((select IdUsuario from Usuarios u Where u.Dni='20555522'));

-- Se observa que se eliminó un usuario
select IdUsuario, Dni as 'ID' from Usuarios 
where IdUsuario=(select IdUsuario from Usuarios u Where u.Dni='20111222') or IdUsuario=1 or IdUsuario=(select IdUsuario from Usuarios u Where u.Dni='20555522');

-- -----------------------------------------------------
-- 7 - Busqueda de un usuario
-- -----------------------------------------------------

drop procedure if exists sp_buscar_usuario;
DELIMITER //
CREATE PROCEDURE sp_buscar_usuario(busqueda VARCHAR(100),IncluirInactivos boolean ) 
-- devolver los productos cuyo nombre sea similar a el string recibido
salir: begin
	IF busqueda IS NULL OR TRIM(busqueda) = '' then 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Por favor ingrese un criterio de busqueda valido';
		LEAVE salir;
    ELseIF IncluirInactivos IS NULL  then 
		SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Por favor indique si desea incluir los usuarios inactivos en la busqueda';
		LEAVE salir;
    ELSE
		select `IdUsuario`, `Nombre`, `Apellido`, `NombreUsuario`, `Dni`, `Sexo`, `Edad`, `Direccion`, `Telefono`, `Mail`, `EstadoCivil`, `Puesto`, `AntiguedadAnios`,`Estado` from Usuarios u 
        where (CONCAT(u.Nombre,' ',u.Apellido)like CONCAT('%', busqueda, '%')
        or CONCAT(u.Apellido,' ',u.Nombre)like CONCAT('%', busqueda, '%')
        ) AND
        (
        not IncluirInactivos and u.Estado='A'
        or  IncluirInactivos
        )
        ;
	END IF;
END //
DELIMITER ;


-- No provee un objeto a buscar
call sp_buscar_usuario(null,false);

-- No indica si la busqueda debe incluir los usuarios Inactivos o no
call sp_buscar_usuario('Juan',null);

-- No ingreso un string a buscar
call sp_buscar_usuario('',true);

-- Busca a usuarios cuyo nombre y apellido inclullan 'lo', incluye Inactivos (Gonzalo)
call sp_buscar_usuario('lo',true);

-- Busca a usuarios cuyo nombre y apellido inclullan 'lo', no incluye Inactivos (Gonzalo no está en la salida)
call sp_buscar_usuario('lo',false);

-- -----------------------------------------------------
-- 8 - Listar Ventas de un usuario
-- -----------------------------------------------------

drop procedure if exists sp_ventas_usuario;
DELIMITER //
CREATE PROCEDURE sp_ventas_usuario(IdUsuario INT ) 
-- devolver los productos cuyo nombre sea similar a el string recibido
salir: begin
	DECLARE vMensaje VARCHAR(100);
	IF IdUsuario IS NULL OR IdUsuario = 0 then 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Por favor ingrese un usuario valido';
		LEAVE salir;
	ELSEIF NOT exists (select 1 from Usuarios u where u.IdUsuario=IdUsuario and u.Estado='A') THEN
		set vMensaje =  CONCAT ('No se encontro al usuario con id ',IdUsuario);
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =vMensaje;
		LEAVE salir;
    ELSE
		SELECT date(lv.FechaTransaccion),SUM(lv.Cantidad*lv.PrecioUnitario) FROM LineaVentas lv
        WHERE lv.IdUsuario=IdUsuario
        group by date(lv.FechaTransaccion)
        order by lv.FechaTransaccion desc;
	END IF;
END //
DELIMITER ;

-- Caso correcto
call sp_ventas_usuario(15);

-- El parametro de entrada es nulo 
call sp_ventas_usuario(null);

-- No hay un usuario 0
call sp_ventas_usuario(0);

-- No hay un usuario 50
call sp_ventas_usuario(50);

-- -----------------------------------------------------
-- 9 - Ranking de productos en un rango de fechas
-- -----------------------------------------------------
drop procedure if exists sp_ranking_productos;
DELIMITER //
CREATE PROCEDURE sp_ranking_productos(FechaMin DATE, FechaMax DATE) 

salir: begin
	IF FechaMin IS NULL then 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Por favor ingrese la fecha mínima';
		LEAVE salir;
	ELSEIF FechaMax IS NULL  then 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Por favor ingrese la fecha maxima';
		LEAVE salir;
    ELSEIF DATEDIFF(FechaMin,FechaMax)>0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha mínima debe ser anterior a la Fecha maxima';
		LEAVE salir;
    ELSE
		SELECT p.Nombre as 'Producto', SUM(lv.Cantidad) as 'Cantidad de ventas', SUM(lv.Cantidad*lv.PrecioUnitario)  as 'Capital generado' from Productos p
        inner join 
        LineaVentas lv on lv.IdProducto=p.IdProducto
        WHERE lv.FechaTransaccion<=FechaMax and lv.FechaTransaccion>=FechaMin
        group by p.IdProducto
        order by Ventas desc;
	END IF;
END //
DELIMITER ;

-- Llamada exitosa
call sp_ranking_productos('2026-05-16','2026-06-05');

-- No se provee una fecha minima
call sp_ranking_productos(null,'2026-7-16');

-- No se provee una fecha maxima
call sp_ranking_productos('2026-7-16',null);

-- La fecha minima es posterior a la maxima
call sp_ranking_productos('2026-7-16','2026-05-16');

-- -----------------------------------------------------
-- 10 - Crear una linea venta si hay suficientes productos en stock
-- -----------------------------------------------------
drop procedure if exists sp_linea_venta;
DELIMITER //
CREATE PROCEDURE sp_linea_venta(IdUsuario INT, IdVenta INT, IdProducto INT , Cantidad INT, Lote VARCHAR(10))
salir: begin

	IF IdUsuario IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Por favor ingrese un usuario';
		LEAVE salir;
	ELSEIF IdVenta IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Por favor ingrese una venta';
		LEAVE salir;
	ELSEIF IdProducto IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Por favor ingrese un producto';
		LEAVE salir;
	ELSEIF Cantidad IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Por favor ingrese una cantidad';
		LEAVE salir;
	ELSEIF Cantidad <= 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La cantidad debe ser mayor a cero';
		LEAVE salir;
	ELSEIF Lote IS NULL OR TRIM(Lote) = '' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Por favor ingrese un lote';
		LEAVE salir;
	ELSEIF NOT exists (select 1 from Usuarios t where t.IdUsuario=IdUsuario and t.Estado='A') THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El id no corresponde a ningun usuario activo';
		LEAVE salir;
	ELSEIF NOT exists (select 1 from Ventas t where t.IdVenta=IdVenta and t.Estado='A') THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El id no corresponde a ningun venta';
		LEAVE salir;
    ELSEIF NOT exists (select 1 from Productos t where t.IdProducto=IdProducto and t.Estado='A') THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El id no corresponde a ningun producto';
		LEAVE salir;
	ELSEIF Cantidad > (      
		Select COALESCE(sum(T.Cantidad),0) as "stock" from (
		select lc.Cantidad from LineaCompras lc where lc.IdProducto=IdProducto and lc.Lote=Lote
        union all
        select -lv.Cantidad from LineaVentas lv where lv.IdProducto=IdProducto and lv.Lote=Lote
		) as T ) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se tiene suficiente stock del producto con el lote especificado';
		LEAVE salir;
    ELSE
		INSERT INTO LineaVentas(`IdUsuario`, `IdVenta`, `IdProducto`, `Cantidad`, `FechaVencimiento`, `Lote`, `FechaTransaccion`, `PrecioUnitario`) 
        VALUES (
        IdUsuario,IdVenta,IdProducto,Cantidad,
        -- Obtener la fecha de vencimiento del lote
        (select t.FechaVencimiento from LineaCompras t where t.Lote=Lote LIMIT 1), Lote, now(),
        -- Obtener el precio actual del producto
        (select t.PrecioBase FROM Productos t where t.IdProducto=IdProducto)
        );
	END IF;
END //
DELIMITER ;


-- La venta de IdVenta = 50 está vacia, se usa como ejemplo
-- Se crea una linea venta con usuario 1, producto 2 y lote LC11. Si se ejecuta varias veces va a dar error por que se consume el stock (Comportamiento correcto)
call sp_linea_venta(1, 50, 2, 3, 'LC11');

-- Se intenta hacer lo mismo pero con cantidad 20, da error debido a que no se tiene suficiente producto
call sp_linea_venta(1, 50, 2, 20, 'LC11');

-- Usuario no existente
call sp_linea_venta(500, 50, 2, 2, 'LC11');

-- lote es una cadena vacia
call sp_linea_venta(1, 50, 2, 2, ' ');

-- Con este select se pueden ver las lineas ventas creada
SELECT * FROM LineaVentas lv WHERE lv.IdProducto =2 and lv.idVenta =50;


