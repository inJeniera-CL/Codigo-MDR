create or replace view sdx_ti_mdr.vw_mdr_26_tp as 
WITH DIA_HABIL_ANTERIOR_CAMBIO_TASA as (select to_date(parametro) DIA_HABIL_ANTERIOR_CAMBIO_TASA from sdx_ti_mdr.parametros_ajuste where nombre_parametro='DIA_HABIL_ANTERIOR_CAMBIO_TASA')
SELECT
	      vw_mdr_18.id_proceso
	, vw_mdr_18.tms_ingesta
	, vw_mdr_18.tms_extraccion_fuente
	, vw_mdr_18.lnin_sec
	, vw_mdr_18.fch_transaccion
	, vw_mdr_18.sid_tx_secuencia
	, vw_mdr_18.cdg_comercio
	, vw_mdr_18.mto_transaccion
	, vw_mdr_18.mto_comision
	, vw_mdr_18.mto_vuelto
	, vw_mdr_18.num_bin_ext
	, vw_mdr_18.cdg_producto_canal_contratado
	, vw_mdr_18.cdg_tipo_transaccion
	, vw_mdr_18.cdg_medio_pago
	, vw_mdr_18.cdg_moneda_iso
	, vw_mdr_18.fch_procesamiento
	, vw_mdr_18.fch_cambio_uf
	, vw_mdr_18.fch_cambio_dolar
	, vw_mdr_18.num_periodo_gestion
	, vw_mdr_18.val_uf
	, vw_mdr_18.val_dolar
	, vw_mdr_18.mto_transaccion_clp
	, vw_mdr_18.mto_transaccion_uf
	, vw_mdr_18.mto_transaccion_usd
	, vw_mdr_18.mto_comision_uf
	, vw_mdr_18.mto_vuelto_uf
	, vw_mdr_18.ttx_tipo_flujo
	, vw_mdr_18.ttx_cod_rubro
	, vw_mdr_18.ttx_cod_moneda_tr
	, vw_mdr_18.ttx_monto_orig
	, vw_mdr_18.ttx_fecha
	, vw_mdr_18.ttx_tipo_tx
	, vw_mdr_18.ttx_tipo_tran
	, vw_mdr_18.ttx_nac_o_ext
	, vw_mdr_18.ttx_marca_bin
	, vw_mdr_18.ttx_tipo_contrato
	, vw_mdr_18.ttx_tipo_tarjeta
	, vw_mdr_18.ttx_medio_pago
	, vw_mdr_18.ttx_emisor
	, vw_mdr_18.ttx_iva_comision
	, vw_mdr_18.lnin_sec_ant
	, vw_mdr_18.identificador_producto
	, vw_mdr_18.partition_year
	, vw_mdr_18.partition_month
	, vw_mdr_18.partition_day
	, vw_mdr_18.mto_transaccion_sin_vuelto
	, vw_mdr_18.mto_transaccion_sin_vuelto_uf
	, vw_mdr_18.cod_cred
	, vw_mdr_18.count_trx
	, vw_mdr_18.rut
	, vw_mdr_18.tipo_conexion
	, vw_mdr_18.cod_rubro
	, vw_mdr_18.emisor_fixed
	, vw_mdr_18.bin
	, vw_mdr_18.medio_pago_pucon
	, vw_mdr_18.marca_fixed
	, vw_mdr_18.emsr_gestion_fixed
	, vw_mdr_18.dsc_marca
	, vw_mdr_18.medio_pago_pucon_fixed
	, vw_mdr_18.medio_pago_pucon_fixed_informe
	, vw_mdr_18.modalidad
	, vw_mdr_18.dsc_marca_fixed
	, vw_mdr_18.dsc_marca_fixed_informe
	, vw_mdr_18.product
	, vw_mdr_18.banco
	, vw_mdr_18.criterio
	, vw_mdr_18.mcc
	, vw_mdr_18.ti_product
	, vw_mdr_18.categoria
	, vw_mdr_18.categoria_especiales
	, vw_mdr_18.categoria_final
	, vw_mdr_18.medio_pago_marca
	, vw_mdr_18.tasa
	, vw_mdr_18.emisor_informe
	, vw_mdr_18.id_informe
	, vw_mdr_18.nombre_informe
	, vw_mdr_18.emisor_informe_finanzas
	, vw_mdr_18.rut_informe_finanzas
	, vw_mdr_18.monto_tasa
	, vw_mdr_18.ti
	, vw_mdr_18.psp
	, vw_mdr_18.membresia
	, vw_mdr_18.switch_usd
	, vw_mdr_18.switch_usd_promedio
	, vw_mdr_18.grupo
	, vw_mdr_18.membresia_uf
	, vw_mdr_18.switch_uf
	, vw_mdr_18.switch_uf_promedio
	, vw_mdr_18.costo_marca
	, vw_mdr_18.tasa_ma_ajustado
	, vw_mdr_18.monto_ma_ajustado
	, vw_mdr_18.membresia_uf_nacional
	, vw_mdr_18.switch_uf_nacional_3p
	, vw_mdr_18.switch_uf_promedio_nacional_3p
	, vw_mdr_18.membresia_uf_nacional_redcompra
	, vw_mdr_18.grupo_negativo
	, vw_mdr_18.cod_mod_ti
	, case when (ka.fecha_inicio is null or fch_procesamiento >= ka.fecha_inicio) and ka.tasa is not null then 1 else 0 end as flg_ka
	, case when (ka.fecha_inicio is null or fch_procesamiento >= ka.fecha_inicio) and ka.tasa is not null then ka.tasa/100 else null end as tasa_ka
	, nvl(c1.tasa_comision,0)/100 tasa_mes
	, case when rut_cobradores.rut is null then 0 else 1 end as cobrador
	, vw_mdr_25.tasa_mdr_real_no_redondeada_sin_maxima as tasa_mdr_real
	, flg_franquicia
FROM
	sdx_ti_mdr.proceso_202210_tp vw_mdr_18, DIA_HABIL_ANTERIOR_CAMBIO_TASA
LEFT JOIN sdx_ti_mdr.ajuste_octubre_2022_3_tp vw_mdr_25 
	ON vw_mdr_25.ttx_tipo_contrato=vw_mdr_18.ttx_tipo_contrato 
	and vw_mdr_25.cdg_comercio=vw_mdr_18.cdg_comercio
	and vw_mdr_18.flg_mc = vw_mdr_25.flg_mc
	and vw_mdr_18.medio_pago_marca = vw_mdr_25.medio_pago_marca
	and vw_mdr_18.flg_franquicia=1
LEFT JOIN sdx_ti_mdr.ka
	ON regexp_replace(vw_mdr_18.rut,"^0+","")=regexp_replace(ka.rut,"^0+","")
	AND regexp_replace(vw_mdr_18.ttx_tipo_contrato,"^0+","")=regexp_replace(ka.tipo_contrato,"^0+","")
	and regexp_replace(vw_mdr_18.mcc,"^0+","")=regexp_replace(ka.mcc,"^0+","")
LEFt JOIN raw_arc.contratos c1 
	on c1.cod_eecc=vw_mdr_18.cdg_comercio
	and vw_mdr_18.ttx_tipo_contrato=c1.tipo_contrato 
	and c1.partition_day=lpad(day(DIA_HABIL_ANTERIOR_CAMBIO_TASA.DIA_HABIL_ANTERIOR_CAMBIO_TASA),2,0) 
	and c1.partition_month=lpad(month(DIA_HABIL_ANTERIOR_CAMBIO_TASA.DIA_HABIL_ANTERIOR_CAMBIO_TASA),2,0) 
	and c1.partition_year=lpad(year(DIA_HABIL_ANTERIOR_CAMBIO_TASA.DIA_HABIL_ANTERIOR_CAMBIO_TASA),4,0)
LEFT JOIN sdx_ti_mdr.rut_cobradores rut_cobradores
	on regexp_replace(rut_cobradores.rut,"^0+","")=regexp_replace(vw_mdr_18.rut,"^0+","") 
	and vw_mdr_18.cod_rubro = rut_cobradores.cod_rubro;

drop table sdx_ti_mdr.ajuste_octubre_2022_4_tp;
create table sdx_ti_mdr.ajuste_octubre_2022_4_tp
as select * from sdx_ti_mdr.vw_mdr_26_tp;