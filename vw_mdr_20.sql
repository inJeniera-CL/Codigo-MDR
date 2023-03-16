create or replace view sdx_ti_mdr.vw_mdr_20_tp as 
WITH 
DIA_HABIL_ANTERIOR_CAMBIO_TASA 				
as (select to_date(parametro) DIA_HABIL_ANTERIOR_CAMBIO_TASA from sdx_ti_mdr.parametros_ajuste where nombre_parametro='DIA_HABIL_ANTERIOR_CAMBIO_TASA'),
DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES 
as (select to_date(parametro) DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES from sdx_ti_mdr.parametros_ajuste where nombre_parametro='DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES')
select
    vw_mdr_18.grupo,
	vw_mdr_18.mcc ,
	vw_mdr_18.medio_pago_marca ,
    vw_mdr_18.psp ,
	vw_mdr_18.cdg_comercio ,
	vw_mdr_18.cod_cred,
	vw_mdr_18.cod_rubro,
	vw_mdr_18.rut ,
	vw_mdr_18.ttx_tipo_contrato , 
	vw_mdr_18.grupo_negativo,
	vw_mdr_19.tasa_mdr_real tasa_mdr_sin_maxima,
	tasa_estimada_comision,
	vw_mdr_19.tasa_mdr_real_no_redondeada tasa_mdr_real_no_redondeada_sin_maxima,
	vw_mdr_19.tasa_mdr_real_sin_costo_marca tasa_mdr_real_sin_costo_marca,
	sum(mto_comision_uf) mto_comision_uf,
	sum(vw_mdr_18.mto_transaccion_sin_vuelto_uf) as mto_transaccion_sin_vuelto_uf,
	sum(vw_mdr_18.monto_tasa) as monto_tasa_uf ,
    sum(vw_mdr_18.membresia_uf) as monto_membresia_uf ,
    sum(vw_mdr_18.switch_uf_promedio) as monto_switch_uf ,
	sum(vw_mdr_18.membresia_uf_nacional) as monto_membresia_uf_nacional ,
    nvl(sum(vw_mdr_18.switch_uf_promedio_nacional_3p),0) as switch_uf_nacional_3p ,
	nvl(sum(vw_mdr_18.membresia_uf_nacional_redcompra),0) membresia_uf_nacional_redcompra,
    sum(vw_mdr_18.monto_ma_ajustado) as monto_ma_uf,
	vw_mdr_18.flg_mc,
	case when (ka.fecha_inicio is null or fch_procesamiento >= ka.fecha_inicio) and ka.tasa is not null then 1 else 0 end as flg_ka,
	case when (ka.fecha_inicio is null or fch_procesamiento >= ka.fecha_inicio) and ka.tasa is not null then ka.tasa/100 else null end as tasa_ka,
    fecha_afiliacion_cod_cred,
	fecha_afiliacion_rut,
	fecha_afiliacion_grupo,
	c2.estado,
	nvl(c2.tasa_comision,0)/100 tasa_actual,
	nvl(c1.tasa_comision,0)/100 tasa_mes
from
    sdx_ti_mdr.proceso_202210_tp vw_mdr_18, DIA_HABIL_ANTERIOR_CAMBIO_TASA, DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES
	left join sdx_ti_mdr.vw_mdr_19_tp vw_mdr_19
		on vw_mdr_18.medio_pago_marca = vw_mdr_19.medio_pago_marca
		and vw_mdr_18.mcc = vw_mdr_19.mcc
		and vw_mdr_18.psp = vw_mdr_19.psp
		and vw_mdr_18.grupo=vw_mdr_19.grupo
		and vw_mdr_18.flg_mc=vw_mdr_19.flg_mc
	LEFT JOIN sdx_ti_mdr.ka
		ON regexp_replace(vw_mdr_18.rut,"^0+","") = regexp_replace(ka.rut,"^0+","")
		AND regexp_replace(vw_mdr_18.ttx_tipo_contrato,"^0+","") = regexp_replace(ka.tipo_contrato,"^0+","")
		and regexp_replace(vw_mdr_18.mcc,"^0+","") = regexp_replace(ka.mcc,"^0+","")
	LEFT JOIN sdx_ti_mdr.vw_fecha_afiliacion 
		on regexp_replace(vw_mdr_18.cod_cred,"^0+","") = regexp_replace(vw_fecha_afiliacion.cod_cred,"^0+","")
	left join raw_arc.contratos c1 on c1.cod_eecc=cdg_comercio and ttx_tipo_contrato=c1.tipo_contrato and c1.partition_day=lpad(day(DIA_HABIL_ANTERIOR_CAMBIO_TASA.DIA_HABIL_ANTERIOR_CAMBIO_TASA),2,0) and c1.partition_month=lpad(month(DIA_HABIL_ANTERIOR_CAMBIO_TASA.DIA_HABIL_ANTERIOR_CAMBIO_TASA),2,0) and c1.partition_year=lpad(year(DIA_HABIL_ANTERIOR_CAMBIO_TASA.DIA_HABIL_ANTERIOR_CAMBIO_TASA),4,0)
	left join raw_arc.contratos c2 on c2.cod_eecc=cdg_comercio and ttx_tipo_contrato=c2.tipo_contrato and c2.partition_day=lpad(day(DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES.DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES),2,0) and c2.partition_month=lpad(month(DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES.DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES),2,0) and c2.partition_year=lpad(year(DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES.DIA_HABIL_ANTERIOR_EJECUCION_PROCESO_AJUSTES),4,0)
group by 
    vw_mdr_18.grupo,
	vw_mdr_18.mcc ,
	vw_mdr_18.medio_pago_marca ,
    vw_mdr_18.psp ,
	vw_mdr_18.cdg_comercio ,
	vw_mdr_18.rut ,
	vw_mdr_18.ttx_tipo_contrato , 
	vw_mdr_19.tasa_mdr_real,
	vw_mdr_19.tasa_mdr_real_no_redondeada,
	vw_mdr_19.tasa_mdr_real_sin_costo_marca,
	vw_mdr_18.cod_cred,
	vw_mdr_18.cod_rubro,
	vw_mdr_18.grupo_negativo,
	tasa_estimada_comision,
	vw_mdr_18.flg_mc,
	case when (ka.fecha_inicio is null or fch_procesamiento >= ka.fecha_inicio) and ka.tasa is not null then 1 else 0 end,
	case when (ka.fecha_inicio is null or fch_procesamiento >= ka.fecha_inicio) and ka.tasa is not null then ka.tasa/100 else null end,
    fecha_afiliacion_cod_cred,
	fecha_afiliacion_rut,
	fecha_afiliacion_grupo,
	c2.estado,
	nvl(c2.tasa_comision,0)/100,
	nvl(c1.tasa_comision,0)/100;
