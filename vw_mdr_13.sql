CREATE OR REPLACE VIEW sdx_ti_mdr.vw_mdr_13_tp AS
SELECT
   	 vw_mdr_12.id_proceso
	, vw_mdr_12.tms_ingesta
	, vw_mdr_12.tms_extraccion_fuente
	, vw_mdr_12.lnin_sec
	, vw_mdr_12.fch_transaccion
	, vw_mdr_12.sid_tx_secuencia
	, vw_mdr_12.cdg_comercio
	, vw_mdr_12.mto_transaccion
	, vw_mdr_12.mto_comision
	, vw_mdr_12.mto_vuelto
	, vw_mdr_12.num_bin_ext
	, vw_mdr_12.cdg_producto_canal_contratado
	, vw_mdr_12.cdg_tipo_transaccion
	, vw_mdr_12.cdg_medio_pago
	, vw_mdr_12.ttx_cod_moneda_tr cdg_moneda_iso
	, vw_mdr_12.fch_procesamiento
	, vw_mdr_12.fch_cambio_uf
	, vw_mdr_12.fch_cambio_dolar
	, vw_mdr_12.num_periodo_gestion
	, vw_mdr_12.val_uf
	, vw_mdr_12.val_dolar
	, vw_mdr_12.mto_transaccion_clp
	, vw_mdr_12.mto_transaccion_uf
	, vw_mdr_12.mto_transaccion_usd
	, vw_mdr_12.mto_comision_uf
	, vw_mdr_12.mto_vuelto_uf
	, vw_mdr_12.ttx_tipo_flujo
	, vw_mdr_12.ttx_cod_rubro
	, vw_mdr_12.ttx_cod_moneda_tr
	, vw_mdr_12.ttx_monto_orig
	, vw_mdr_12.ttx_fecha
	, vw_mdr_12.ttx_tipo_tx
	, vw_mdr_12.ttx_tipo_tran
	, vw_mdr_12.ttx_nac_o_ext
	, vw_mdr_12.ttx_marca_bin
	, vw_mdr_12.ttx_tipo_contrato
	, vw_mdr_12.ttx_tipo_tarjeta
	, vw_mdr_12.ttx_medio_pago
	, vw_mdr_12.ttx_emisor
	, vw_mdr_12.ttx_iva_comision
	, vw_mdr_12.lnin_sec_ant
	, vw_mdr_12.identificador_producto
	, vw_mdr_12.partition_year
	, vw_mdr_12.partition_month
	, vw_mdr_12.partition_day
	, vw_mdr_12.flg_surcharge
	, vw_mdr_12.cod_mod_ti
	, mto_transaccion_sin_vuelto
	, mto_transaccion_sin_vuelto_uf
	, cod_cred
	, count_trx
	, vw_mdr_12.rut
	, vw_mdr_12.tipo_conexion
	, vw_mdr_12.cod_rubro
	, vw_mdr_12.emisor_fixed
	, vw_mdr_12.bin
	, vw_mdr_12.medio_pago_pucon
	, vw_mdr_12.marca_fixed
	, vw_mdr_12.emsr_gestion_fixed
	, vw_mdr_12.dsc_marca
	, vw_mdr_12.medio_pago_pucon_fixed
	, vw_mdr_12.modalidad
	, vw_mdr_12.dsc_marca_fixed
    , vw_mdr_12.product
    , vw_mdr_12.banco
    , vw_mdr_12.criterio
    , vw_mdr_12.mcc	
	, vw_mdr_12.ti_product
	, vw_mdr_12.categoria
    , vw_mdr_12.categoria_especiales
	, vw_mdr_12.flg_cliente_especial	
    , vw_mdr_12.categoria_final
    , vw_mdr_12.medio_pago_marca		
    , CASE 
		WHEN vw_ic_visa_normalizado.tasas IS NOT NULL THEN vw_ic_visa_normalizado.tasas
		WHEN ic_visa.tasas IS NOT NULL THEN ic_visa.tasas		
		WHEN ic_amex_clientes_especiales.ic IS NOT NULL THEN ic_amex_clientes_especiales.ic	
		WHEN ic_amex_familia_mcc.ic IS NOT NULL THEN ic_amex_familia_mcc.ic	
		WHEN vw_mdr_12.emsr_gestion_fixed!='EXTRANJERAS' AND vw_mdr_12.emsr_gestion_fixed IS NOT NULL AND ic_amex_familia_mcc.ic IS NULL AND ic_amex_clientes_especiales.ic IS NULL AND vw_mdr_12.criterio = 'AMEX'  THEN '0.0148'	
		WHEN (vw_mdr_12.emsr_gestion_fixed='EXTRANJERAS' OR vw_mdr_12.emsr_gestion_fixed IS NULL) AND vw_mdr_12.criterio = 'AMEX' THEN '0.015'
		WHEN (vw_mdr_12.emsr_gestion_fixed='EXTRANJERAS' OR vw_mdr_12.emsr_gestion_fixed IS NULL) AND vw_mdr_12.criterio = 'MC' THEN '0.01841'
		WHEN (vw_mdr_12.emsr_gestion_fixed='EXTRANJERAS' OR vw_mdr_12.emsr_gestion_fixed IS NULL) AND vw_mdr_12.criterio = 'VISA' THEN '0.01635'
		WHEN (vw_mdr_12.emsr_gestion_fixed='EXTRANJERAS' OR vw_mdr_12.emsr_gestion_fixed IS NULL) AND vw_mdr_12.criterio IS NULL THEN '0.01635'
		WHEN ic_mastercard_debito.rate IS NOT NULL AND vw_mdr_12.modalidad = 'PRESENCIAL' THEN ic_mastercard_debito.rate		
		WHEN ic_mastercard_debito.rate IS NOT NULL AND vw_mdr_12.modalidad = 'NO PRESENCIAL' THEN (ic_mastercard_debito.rate + ic_mastercard_debito.cnp_deb)
		WHEN ic_mastercard_credito.tasa IS NOT NULL AND vw_mdr_12.modalidad = 'PRESENCIAL' THEN ic_mastercard_credito.tasa		
		WHEN ic_mastercard_credito.tasa IS NOT NULL AND vw_mdr_12.modalidad = 'NO PRESENCIAL' AND vw_mdr_12.ti_product = 'Comercial'  THEN ic_mastercard_credito.tasa
		WHEN ic_mastercard_credito.tasa IS NOT NULL AND vw_mdr_12.modalidad = 'NO PRESENCIAL' AND vw_mdr_12.ti_product != 'Comercial' THEN (ic_mastercard_credito.tasa+ic_mastercard_credito.cnp_cre)
		WHEN ic_mastercard_debito_dm.tasa IS NOT NULL AND vw_mdr_12.modalidad = 'PRESENCIAL' THEN ic_mastercard_debito_dm.tasa		
		WHEN ic_mastercard_debito_dm.tasa IS NOT NULL AND vw_mdr_12.modalidad = 'NO PRESENCIAL' AND vw_mdr_12.ti_product = 'Comercial'  THEN ic_mastercard_debito_dm.tasa
		WHEN ic_mastercard_debito_dm.tasa IS NOT NULL AND vw_mdr_12.modalidad = 'NO PRESENCIAL' AND vw_mdr_12.ti_product != 'Comercial' THEN (ic_mastercard_debito_dm.tasa+ic_mastercard_debito_dm.cnp_cre)
		WHEN ic_mastercard_prepago.rate IS NOT NULL AND vw_mdr_12.modalidad = 'PRESENCIAL' THEN ic_mastercard_prepago.rate		
		WHEN ic_mastercard_prepago.rate IS NOT NULL AND vw_mdr_12.modalidad = 'NO PRESENCIAL' THEN (ic_mastercard_prepago.rate + ic_mastercard_prepago.cnp_pre)
		ELSE NULL	
	  END AS TASA		
FROM		
sdx_ti_mdr.vw_mdr_12_tp vw_mdr_12	 	
LEFT JOIN sdx_ti_mdr.vw_ic_visa_normalizado_20220408 vw_ic_visa_normalizado 
	ON vw_mdr_12.medio_pago_pucon_fixed = vw_ic_visa_normalizado.medio_pago	
	AND vw_mdr_12.medio_pago_pucon_fixed IN (4, 5)
	and vw_mdr_12.ti_product = vw_ic_visa_normalizado.ti_product		
	and vw_mdr_12.criterio = 'VISA'		
	and vw_mdr_12.categoria_final = vw_ic_visa_normalizado.categoria	
	AND vw_mdr_12.emsr_gestion_fixed!='EXTRANJERAS'
	AND vw_mdr_12.emsr_gestion_fixed IS NOT NULL
LEFT JOIN sdx_ti_mdr.vw_ic_visa_normalizado_20220408 ic_visa
	ON vw_mdr_12.medio_pago_pucon_fixed = 6
	AND vw_mdr_12.medio_pago_pucon_fixed = ic_visa.medio_pago	
	and vw_mdr_12.criterio = 'VISA'		
	and vw_mdr_12.categoria_final = ic_visa.categoria	
	AND vw_mdr_12.emsr_gestion_fixed!='EXTRANJERAS'
	AND vw_mdr_12.emsr_gestion_fixed IS NOT NULL
LEFT JOIN sdx_ti_mdr.ic_amex_familia_mcc_20220408 ic_amex_familia_mcc
	ON vw_mdr_12.criterio = 'AMEX'		
	AND ic_amex_familia_mcc.mcc = vw_mdr_12.mcc		
	and vw_mdr_12.categoria is not null		
	and vw_mdr_12.categoria_especiales is null	
	AND vw_mdr_12.emsr_gestion_fixed!='EXTRANJERAS'
	AND vw_mdr_12.emsr_gestion_fixed IS NOT NULL
LEFT JOIN sdx_ti_mdr.ic_amex_clientes_especiales_20220408 ic_amex_clientes_especiales
	ON ic_amex_clientes_especiales.cliente_especial = vw_mdr_12.categoria_especiales		
	AND vw_mdr_12.criterio = 'AMEX'		
	AND vw_mdr_12.categoria_especiales IS NOT NULL		
	AND vw_mdr_12.emsr_gestion_fixed!='EXTRANJERAS'
	AND vw_mdr_12.emsr_gestion_fixed IS NOT NULL
LEFT JOIN sdx_ti_mdr.ic_mastercard_debito_20220408 ic_mastercard_debito
	ON vw_mdr_12.medio_pago_pucon_fixed = 5		
	AND vw_mdr_12.categoria_final = ic_mastercard_debito.merchant_categories		
	AND vw_mdr_12.criterio = 'MC'	
	AND vw_mdr_12.emsr_gestion_fixed!='EXTRANJERAS'
	AND vw_mdr_12.emsr_gestion_fixed IS NOT NULL
	AND vw_mdr_12.dsc_marca_fixed = 'Maestro'
LEFT JOIN sdx_ti_mdr.ic_mastercard_credito_20220408 ic_mastercard_credito
	ON vw_mdr_12.medio_pago_pucon_fixed = 4		
	AND vw_mdr_12.categoria_final = ic_mastercard_credito.merchant_categories		
	AND vw_mdr_12.ti_product = ic_mastercard_credito.producto		
	AND vw_mdr_12.criterio = 'MC'	
	AND vw_mdr_12.emsr_gestion_fixed!='EXTRANJERAS'
	AND vw_mdr_12.emsr_gestion_fixed IS NOT NULL
LEFT JOIN sdx_ti_mdr.ic_mastercard_debito_dm_20220408 ic_mastercard_debito_dm
	ON vw_mdr_12.medio_pago_pucon_fixed = 5		
	AND vw_mdr_12.categoria_final = ic_mastercard_debito_dm.merchant_categories		
	AND vw_mdr_12.ti_product = ic_mastercard_debito_dm.producto		
	AND vw_mdr_12.criterio = 'MC'	
	AND vw_mdr_12.emsr_gestion_fixed!='EXTRANJERAS'
	AND vw_mdr_12.emsr_gestion_fixed IS NOT NULL
	AND vw_mdr_12.dsc_marca_fixed != 'Maestro'
LEFT JOIN sdx_ti_mdr.ic_mastercard_prepago_20220408 ic_mastercard_prepago
	ON vw_mdr_12.medio_pago_pucon_fixed = 6		
	AND vw_mdr_12.categoria_final = ic_mastercard_prepago.merchant_categories		
	AND vw_mdr_12.criterio = 'MC'	
	AND vw_mdr_12.emsr_gestion_fixed!='EXTRANJERAS'
	AND vw_mdr_12.emsr_gestion_fixed IS NOT NULL;