create database PROGRAMACION;
call programacion.prueba1("Juan", 80);
call programacion.suerte();
call programacion.contar();

SET @texto = 'holamundo';
SET @n = 25;
SET @n = @n+3;
SELECT @texto, @n;


set @iva=0.21;
use supermercado;
select NOMBRE,PRECIO,PRECIO*@iva as ImporteIva
from PRODUCTO;

use TIENDA;
select DESCRIPCION,PRECIO,PRECIO*@iva as ImporteIva
from PRODUCTO;
