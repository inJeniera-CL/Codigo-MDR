create or replace view sdx_ti_mdr.vw_mdr_24_tp as 
SELECT
	vw_mdr_23.grupo,
	vw_mdr_23.mcc,
	vw_mdr_23.medio_pago_marca,
	vw_mdr_23.psp,
	vw_mdr_23.cdg_comercio,
	vw_mdr_23.rut,
	vw_mdr_23.cod_cred,
	vw_mdr_23.cod_rubro,
	vw_mdr_23.ttx_tipo_contrato,
	vw_mdr_23.tasa_mdr_sin_maxima,
	vw_mdr_23.tasa_mdr_real_no_redondeada_sin_maxima,
	vw_mdr_23.tasa_mdr_real_sin_costo_marca,
	vw_mdr_23.mto_transaccion_sin_vuelto_uf,
	vw_mdr_23.monto_tasa_uf,
	vw_mdr_23.monto_membresia_uf,
	vw_mdr_23.monto_switch_uf,
	vw_mdr_23.monto_membresia_uf_nacional,
	vw_mdr_23.switch_uf_nacional_3p,
	vw_mdr_23.membresia_uf_nacional_redcompra,
	vw_mdr_23.monto_ma_uf,
	vw_mdr_23.mto_comision_uf,
	vw_mdr_23.flg_ka,
	vw_mdr_23.tasa_ka,	
	case when tasa_ka is not null
	then tasa_ka
	else tasa_mdr_real_sin_costo_marca end AS tasa_mdr_real,
	vw_mdr_23.estado,
	vw_mdr_23.tasa_actual,
	vw_mdr_23.tasa_mes,
	(CASE WHEN rut_cobradores.rut is not null then 1 else 0 end) as cobrador,
	vw_mdr_23.fecha_afiliacion_cod_cred,
	vw_mdr_23.fecha_afiliacion_rut,
	vw_mdr_23.fecha_afiliacion_grupo,
	vw_mdr_23.flg_mc
FROM
	sdx_ti_mdr.vw_mdr_20_tp vw_mdr_23
LEFT JOIN 
	sdx_ti_mdr.rut_cobradores rut_cobradores on regexp_replace(rut_cobradores.rut,"^0+","")=regexp_replace(vw_mdr_23.rut,"^0+","") 
	and vw_mdr_23.cod_rubro = rut_cobradores.cod_rubro
WHERE
grupo_negativo=0;

drop table sdx_ti_mdr.ajuste_octubre_2022_2_tp;
create table sdx_ti_mdr.ajuste_octubre_2022_2_tp
as select * from sdx_ti_mdr.vw_mdr_24_tp
;