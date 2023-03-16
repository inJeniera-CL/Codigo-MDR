CREATE OR REPLACE VIEW sdx_ti_mdr.vw_mdr_09_tp AS	
SELECT 
	  vw_mdr_08.id_proceso
	, vw_mdr_08.tms_ingesta
	, vw_mdr_08.tms_extraccion_fuente
	, vw_mdr_08.lnin_sec
	, vw_mdr_08.fch_transaccion
	, vw_mdr_08.sid_tx_secuencia
	, vw_mdr_08.cdg_comercio
	, vw_mdr_08.mto_transaccion
	, vw_mdr_08.mto_comision
	, vw_mdr_08.mto_vuelto
	, vw_mdr_08.num_bin_ext
	, vw_mdr_08.cdg_producto_canal_contratado
	, vw_mdr_08.cdg_tipo_transaccion
	, vw_mdr_08.cdg_medio_pago
	, vw_mdr_08.ttx_cod_moneda_tr cdg_moneda_iso
	, vw_mdr_08.fch_procesamiento
	, vw_mdr_08.fch_cambio_uf
	, vw_mdr_08.fch_cambio_dolar
	, vw_mdr_08.num_periodo_gestion
	, vw_mdr_08.val_uf
	, vw_mdr_08.val_dolar
	, vw_mdr_08.mto_transaccion_clp
	, vw_mdr_08.mto_transaccion_uf
	, vw_mdr_08.mto_transaccion_usd
	, vw_mdr_08.mto_comision_uf
	, vw_mdr_08.mto_vuelto_uf
	, vw_mdr_08.ttx_tipo_flujo
	, vw_mdr_08.ttx_cod_rubro
	, vw_mdr_08.ttx_cod_moneda_tr
	, vw_mdr_08.ttx_monto_orig
	, vw_mdr_08.ttx_fecha
	, vw_mdr_08.ttx_tipo_tx
	, vw_mdr_08.ttx_tipo_tran
	, vw_mdr_08.ttx_nac_o_ext
	, vw_mdr_08.ttx_marca_bin
	, vw_mdr_08.ttx_tipo_contrato
	, vw_mdr_08.ttx_tipo_tarjeta
	, vw_mdr_08.ttx_medio_pago
	, vw_mdr_08.ttx_emisor
	, vw_mdr_08.ttx_iva_comision
	, vw_mdr_08.lnin_sec_ant
	, vw_mdr_08.identificador_producto
	, vw_mdr_08.partition_year
	, vw_mdr_08.partition_month
	, vw_mdr_08.partition_day
	, vw_mdr_08.flg_surcharge
	, vw_mdr_08.cod_mod_ti
	, mto_transaccion_sin_vuelto
	, mto_transaccion_sin_vuelto_uf
	, cod_cred
	, count_trx
	, vw_mdr_08.rut
	, vw_mdr_08.tipo_conexion
	, vw_mdr_08.cod_rubro
	, vw_mdr_08.emisor_fixed
	, vw_mdr_08.bin
	, vw_mdr_08.medio_pago_pucon
	, vw_mdr_08.marca_fixed
	, vw_mdr_08.emsr_gestion_fixed
	, vw_mdr_08.dsc_marca
	, vw_mdr_08.medio_pago_pucon_fixed
	, vw_mdr_08.modalidad
	, vw_mdr_08.dsc_marca_fixed
    , vw_mdr_08.product
    , vw_mdr_08.banco
    , vw_mdr_08.criterio
    , vw_mdr_08.mcc	
	, vw_mdr_08.ti_product
	, CASE WHEN vw_mdr_08.criterio='VISA' THEN 		
	CASE WHEN vw_mdr_08.modalidad='NO PRESENCIAL' AND ic_visa_categorias.merchant_categories IN ('Emergentes 1','Emergentes 2','Emergentes 3','Emergentes 4') THEN ic_visa_categorias.merchant_categories	
	WHEN vw_mdr_08.modalidad='NO PRESENCIAL' AND ic_visa_categorias.merchant_categories NOT IN ('Emergentes 1','Emergentes 2','Emergentes 3','Emergentes 4') THEN 'Otros No Presencial'	
	WHEN vw_mdr_08.modalidad='PRESENCIAL' AND ic_visa_categorias.merchant_categories IN ('Emergentes 1','Emergentes 2','Emergentes 3','Emergentes 4','Emergentes 5','Consumo Diario 1','Consumo Diario 2','Viajes y Entretenimiento') THEN ic_visa_categorias.merchant_categories	
	WHEN vw_mdr_08.modalidad='PRESENCIAL' AND ic_visa_categorias.merchant_categories NOT IN ('Emergentes 1','Emergentes 2','Emergentes 3','Emergentes 4','Emergentes 5','Consumo Diario 1','Consumo Diario 2','Viajes y Entretenimiento') THEN 'Otros Presencial'	
	ELSE NULL END	
WHEN vw_mdr_08.criterio='MC' THEN ic_mastercard_categorias.merchant_categories		
WHEN vw_mdr_08.criterio='AMEX' THEN ic_amex_familia_mcc.categoria		
ELSE NULL END as categoria		
FROM sdx_ti_mdr.mdr_08_10_2022_tp vw_mdr_08		
LEFT JOIN sdx_ti_mdr.ic_amex_familia_mcc_20220408 ic_amex_familia_mcc ON vw_mdr_08.mcc=ic_amex_familia_mcc.mcc		
LEFT JOIN sdx_ti_mdr.ic_visa_categorias ON vw_mdr_08.mcc=ic_visa_categorias.mcc		
LEFT JOIN sdx_ti_mdr.ic_mastercard_categorias_20220408 ic_mastercard_categorias ON vw_mdr_08.mcc=ic_mastercard_categorias.mcc;