create or replace view sdx_ti_mdr.vw_mdr_31_tp as
WITH DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES as (select to_date(parametro) DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES from sdx_ti_mdr.parametros_ajuste where nombre_parametro='DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES'),
comision_credito_14 as
(
Select cod_eecc
, estado
, tasa_comision
from raw_arc.contratos, DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES
where partition_year = lpad(year(DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES.DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES),4,0)
and partition_month = lpad(month(DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES.DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES),2,0)
and partition_day = lpad(day(DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES.DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES),2,0)
and tipo_contrato = '14'
and estado in ('01', '04')
), comision_credito_01 as
(
Select c.cod_eecc
, c.estado
, tasa_comision
from raw_arc.contratos c, DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES
where partition_year = lpad(year(DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES.DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES),4,0)
and partition_month = lpad(month(DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES.DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES),2,0)
and partition_day = lpad(day(DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES.DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES),2,0)
and c.cod_eecc not in (select distinct ca.cod_eecc from comision_credito_14 ca)
and c.tipo_contrato = '01'
and estado in ('01', '04')
), debito as
(
Select cod_eecc
, estado
, tasa_comision
from raw_arc.contratos, DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES
where partition_year = lpad(year(DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES.DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES),4,0)
and partition_month = lpad(month(DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES.DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES),2,0)
and partition_day = lpad(day(DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES.DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES),2,0)
and tipo_contrato = '03'
and estado in ('01', '04')
), comision_credito_59 as
(
Select c.cod_eecc
, c.estado
, tasa_comision
from raw_arc.contratos c, DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES
where partition_year = lpad(year(DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES.DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES),4,0)
and partition_month = lpad(month(DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES.DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES),2,0)
and partition_day = lpad(day(DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES.DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES),2,0)
and c.cod_eecc not in (select distinct ca.cod_eecc from comision_credito_14 ca)
and c.tipo_contrato = '59'
and estado in ('01', '04')
), comision_credito_60 as
(
Select c.cod_eecc
, c.estado
, tasa_comision
from raw_arc.contratos c, DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES
where partition_year = lpad(year(DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES.DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES),4,0)
and partition_month = lpad(month(DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES.DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES),2,0)
and partition_day = lpad(day(DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES.DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES),2,0)
and c.cod_eecc not in (select distinct ca.cod_eecc from comision_credito_14 ca)
and c.tipo_contrato = '60'
and estado in ('01', '04')
)
SELECT
                rut_organizacion,
                codigo_comercio,
                medio_pago,
                tipo_registro,
                mes,
                anio,
                venta,
                CASE WHEN tasa_estimada is null then round(comision_neta_estimada/venta,4)*100 else tasa_estimada end as tasa_estimada, --tasa_estimada_final R075
                comision_bruta_estimada,
                comision_neta_estimada,
                iva_comision_estimada,
                tasa_real,
                comision_bruta_real,
                comision_neta_real,
                iva_comision_real,
                comision_bruta_real-comision_bruta_estimada valor_ajuste,
                case when nvl(nvl(nvl(c14.tasa_comision, c01.tasa_comision),c59.tasa_comision), c60.tasa_comision) is null and d03.cod_eecc is not null then 1 else 0 end as flg_solo_debito,
                case when venta<=0 then 1 else 0 end as flg_venta_negativa,
                CASE WHEN nvl(nvl(nvl(nvl(c14.tasa_comision, c01.tasa_comision),c59.tasa_comision), c60.tasa_comision),d03.cod_eecc) is null then 1 else 0 end as flg_comercio_inactivo,
                case when tasa_real<=0 then 1 else 0 end as flg_tasa_real_negativa,
                case when (CASE WHEN tasa_estimada is null then round(comision_neta_estimada/venta,4)*100 else tasa_estimada end) <=0 then 1 else 0 end as flg_tasa_estimada_negativa,
                case when tasa_real>=100 then 1 else 0 end as flg_tasa_real_mayor,
                psp
FROM
                sdx_ti_mdr.ajuste_octubre_2022_7_tp vw_mdr_29
left join comision_credito_14 c14
on  codigo_comercio = c14.cod_eecc
left join comision_credito_01 c01
on  codigo_comercio = c01.cod_eecc
left join comision_credito_59 c59
on  codigo_comercio = c59.cod_eecc
left join comision_credito_60 c60
on  codigo_comercio = c60.cod_eecc
left join debito d03
on  codigo_comercio = d03.cod_eecc;

drop table sdx_ti_mdr.ajuste_octubre_2022_9_tp;
create table sdx_ti_mdr.ajuste_octubre_2022_9_tp
as select * from sdx_ti_mdr.vw_mdr_31_tp
;