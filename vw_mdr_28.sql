create or replace view sdx_ti_mdr.vw_mdr_28_tp as select
	rut_organizacion,
	codigo_comercio,
	medio_pago,
	tipo_registro,
	mes,
	anio,
	sum(venta) --venta_fixed_2
	venta, --venta_fixed_1 E121
	tasa_estimada,
	sum(comision_bruta_estimada) --comision_bruta_estimada_fixed_3
	comision_bruta_estimada, --comision_bruta_estimada_fixed_2 E122
	sum(comision_neta_estimada) --comision_neta_estimada_fixed_3
	comision_neta_estimada, --comision_neta_estimada_fixed_2 E123
	sum(iva_comision_estimada) --iva_comision_estimada_fixed_3
	iva_comision_estimada, --iva_comision_estimada_fixed_2 E124
	tasa_real, --E125
	sum(comision_bruta_real) --comision_bruta_real_fixed_3
	comision_bruta_real, --comision_bruta_real_fixed_2 E126
	sum(comision_neta_real) --comision_neta_real_fixed_3
	comision_neta_real, --comision_neta_real_fixed_2 E127
	sum(iva_comision_real) --iva_comision_real_fixed_3
	iva_comision_real, --iva_comision_real_fixed_2 E128
	cobrador,
	psp,
	cod_rubro,
	mcc
FROM
	sdx_ti_mdr.ajuste_octubre_2022_5_tp vw_mdr_27
group by 
	rut_organizacion,
	codigo_comercio,
	medio_pago,
	tipo_registro,
	mes,
	anio,
	tasa_estimada,
	tasa_real,
	cobrador, 
	psp;

drop table sdx_ti_mdr.ajuste_octubre_2022_6_tp;
create table sdx_ti_mdr.ajuste_octubre_2022_6_tp
as select * from sdx_ti_mdr.vw_mdr_28_tp
;