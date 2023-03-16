create or replace view sdx_ti_mdr.vw_mdr_29_tp AS
SELECT
    rut_organizacion,
    codigo_comercio,
    medio_pago,
    tipo_registro,
    mes,
    anio,
    SUM(venta) --venta_fixed_1
    as venta, --venta E172
    tasa_estimada,
    SUM(comision_bruta_estimada) --comision_bruta_estimada_fixed_2 
    as comision_bruta_estimada, --comision_bruta_estimada_fixed_1 E173
    SUM(comision_neta_estimada) --comision_neta_estimada_fixed_2
    as comision_neta_estimada, --comision_neta_estimada_fixed_1 E174
    SUM(iva_comision_estimada) --iva_comision_estimada_fixed_2
    as iva_comision_estimada, --iva_comision_estimada_fixed_1 E175
    ROUND(SUM(comision_neta_real)*100/SUM(venta),2) AS tasa_real, 
    SUM(comision_bruta_real) --comision_bruta_real_fixed_2
    as comision_bruta_real, --comision_bruta_real_fixed_1 E176
    SUM(comision_neta_real) --comision_neta_real_fixed_2
    as comision_neta_real, --comision_neta_real_fixed_1 E177
    SUM(iva_comision_real) --iva_comision_real_fixed_2
    as iva_comision_real, --iva_comision_real_fixed_1 E178
    cobrador,
	psp
FROM
sdx_ti_mdr.ajuste_octubre_2022_6_tp
  where CONCAT(codigo_comercio, medio_pago) IN (select 
CONCAT(codigo_comercio, medio_pago) 
from sdx_ti_mdr.ajuste_octubre_2022_6_tp group by codigo_comercio, medio_pago  having count(1) > 1)
GROUP BY     rut_organizacion,
    codigo_comercio,
    medio_pago,
    tipo_registro,
    mes,
    anio,
    tasa_estimada,
    cobrador,
	psp
union
SELECT
    rut_organizacion,
    codigo_comercio,
    medio_pago,
    tipo_registro,
    mes,
    anio,
    venta,
    tasa_estimada,
    comision_bruta_estimada,
    comision_neta_estimada,
    iva_comision_estimada,
    ROUND((comision_neta_real)*100/(venta),2) AS tasa_real, 
    comision_bruta_real,
    comision_neta_real,
    iva_comision_real,
    cobrador,
	psp
FROM
sdx_ti_mdr.ajuste_octubre_2022_6_tp
  where CONCAT(codigo_comercio, medio_pago) IN (select 
CONCAT(codigo_comercio, medio_pago) 
from sdx_ti_mdr.ajuste_octubre_2022_6_tp group by codigo_comercio, medio_pago  having count(1) = 1);

drop table sdx_ti_mdr.ajuste_octubre_2022_7_tp;
create table sdx_ti_mdr.ajuste_octubre_2022_7_tp
as select * from sdx_ti_mdr.vw_mdr_29_tp
;