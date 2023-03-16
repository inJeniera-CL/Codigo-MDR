create or replace view sdx_ti_mdr.vw_mdr_25_tp as 
WITH AFILIACION_HASTA as (select to_date(parametro) AFILIACION_HASTA from sdx_ti_mdr.parametros_ajuste where nombre_parametro='AFILIACION_HASTA')
SELECT
	grupo,
	mcc,
	medio_pago_marca,
	psp,
	cdg_comercio,
	rut,
	cod_cred,
	cod_rubro,
	ttx_tipo_contrato,
	tasa_mdr_sin_maxima,
	tasa_mdr_real_no_redondeada_sin_maxima,
	tasa_mdr_real_sin_costo_marca,
	mto_transaccion_sin_vuelto_uf,
	monto_tasa_uf,
	monto_membresia_uf,
	monto_switch_uf,
	monto_membresia_uf_nacional,
	switch_uf_nacional_3p,
	membresia_uf_nacional_redcompra,
	monto_ma_uf,
	mto_comision_uf,
	flg_ka,
	tasa_ka,
	tasa_mdr_real,
	estado,
	tasa_actual,
	tasa_mes,
	cobrador,
	fecha_afiliacion_grupo,
	fecha_afiliacion_cod_cred,
	fecha_afiliacion_rut,
	flg_mc
FROM
	sdx_ti_mdr.ajuste_octubre_2022_2_tp vw_mdr_24, AFILIACION_HASTA
where flg_ka=0 
and (tasa_mes!=0 or psp = 1)
and cod_rubro not in ('501','509') 
and (fecha_afiliacion_grupo<AFILIACION_HASTA.AFILIACION_HASTA or fecha_afiliacion_grupo is null or grupo='COPEC' or fecha_afiliacion_grupo >= '2022-02-01')
;

drop table sdx_ti_mdr.ajuste_octubre_2022_3_tp;
create table sdx_ti_mdr.ajuste_octubre_2022_3_tp
as select * from sdx_ti_mdr.vw_mdr_25_tp
;