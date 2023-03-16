CREATE OR REPLACE VIEW sdx_ti_mdr.vw_mdr_10_tp AS 
SELECT
   	  vw_mdr_09.id_proceso
	, vw_mdr_09.tms_ingesta
	, vw_mdr_09.tms_extraccion_fuente
	, vw_mdr_09.lnin_sec
	, vw_mdr_09.fch_transaccion
	, vw_mdr_09.sid_tx_secuencia
	, vw_mdr_09.cdg_comercio
	, vw_mdr_09.mto_transaccion
	, vw_mdr_09.mto_comision
	, vw_mdr_09.mto_vuelto
	, vw_mdr_09.num_bin_ext
	, vw_mdr_09.cdg_producto_canal_contratado
	, vw_mdr_09.cdg_tipo_transaccion
	, vw_mdr_09.cdg_medio_pago
	, vw_mdr_09.ttx_cod_moneda_tr cdg_moneda_iso
	, vw_mdr_09.fch_procesamiento
	, vw_mdr_09.fch_cambio_uf
	, vw_mdr_09.fch_cambio_dolar
	, vw_mdr_09.num_periodo_gestion
	, vw_mdr_09.val_uf
	, vw_mdr_09.val_dolar
	, vw_mdr_09.mto_transaccion_clp
	, vw_mdr_09.mto_transaccion_uf
	, vw_mdr_09.mto_transaccion_usd
	, vw_mdr_09.mto_comision_uf
	, vw_mdr_09.mto_vuelto_uf
	, vw_mdr_09.ttx_tipo_flujo
	, vw_mdr_09.ttx_cod_rubro
	, vw_mdr_09.ttx_cod_moneda_tr
	, vw_mdr_09.ttx_monto_orig
	, vw_mdr_09.ttx_fecha
	, vw_mdr_09.ttx_tipo_tx
	, vw_mdr_09.ttx_tipo_tran
	, vw_mdr_09.ttx_nac_o_ext
	, vw_mdr_09.ttx_marca_bin
	, vw_mdr_09.ttx_tipo_contrato
	, vw_mdr_09.ttx_tipo_tarjeta
	, vw_mdr_09.ttx_medio_pago
	, vw_mdr_09.ttx_emisor
	, vw_mdr_09.ttx_iva_comision
	, vw_mdr_09.lnin_sec_ant
	, vw_mdr_09.identificador_producto
	, vw_mdr_09.partition_year
	, vw_mdr_09.partition_month
	, vw_mdr_09.partition_day
	, vw_mdr_09.flg_surcharge
	, vw_mdr_09.cod_mod_ti
	, mto_transaccion_sin_vuelto
	, mto_transaccion_sin_vuelto_uf
	, vw_mdr_09.cod_cred
	, count_trx
	, vw_mdr_09.rut
	, vw_mdr_09.tipo_conexion
	, vw_mdr_09.cod_rubro
	, vw_mdr_09.emisor_fixed
	, vw_mdr_09.bin
	, vw_mdr_09.medio_pago_pucon
	, vw_mdr_09.marca_fixed
	, vw_mdr_09.emsr_gestion_fixed
	, vw_mdr_09.dsc_marca
	, vw_mdr_09.medio_pago_pucon_fixed
	, vw_mdr_09.modalidad
	, vw_mdr_09.dsc_marca_fixed
    , vw_mdr_09.product
    , vw_mdr_09.banco
    , vw_mdr_09.criterio
    , vw_mdr_09.mcc	
	, vw_mdr_09.ti_product
	, vw_mdr_09.categoria
    , CASE 	WHEN vw_mdr_09.criterio = 'AMEX' AND (vw_mdr_09.fch_transaccion >= cli_esp_amex_rut.fecha_inicio OR vw_mdr_09.fch_transaccion >= cli_esp_amex_codcred.fecha_inicio) 
				THEN nvl(cli_esp_amex_rut.categoria_especial, cli_esp_amex_codcred.categoria_especial)
			WHEN vw_mdr_09.criterio = 'VISA' AND (vw_mdr_09.fch_transaccion >= cli_esp_visa_rut.fecha_inicio OR vw_mdr_09.fch_transaccion >= cli_esp_visa_codcred.fecha_inicio)
				THEN nvl(cli_esp_visa_rut.categoria_especial, cli_esp_visa_codcred.categoria_especial)
			WHEN vw_mdr_09.criterio = 'MC' AND (vw_mdr_09.fch_transaccion >= cli_esp_mastercard_rut.fecha_inicio OR vw_mdr_09.fch_transaccion >= cli_esp_mastercard_codcred.fecha_inicio)
				THEN nvl(cli_esp_mastercard_rut.categoria_especial, cli_esp_mastercard_codcred.categoria_especial)
      ELSE NULL
	  END AS categoria_especiales
	, CASE 	WHEN vw_mdr_09.criterio = 'AMEX' AND (vw_mdr_09.fch_transaccion >= cli_esp_amex_rut.fecha_inicio OR vw_mdr_09.fch_transaccion >= cli_esp_amex_codcred.fecha_inicio) 
				THEN 1
			WHEN vw_mdr_09.criterio = 'VISA' AND (vw_mdr_09.fch_transaccion >= cli_esp_visa_rut.fecha_inicio OR vw_mdr_09.fch_transaccion >= cli_esp_visa_codcred.fecha_inicio)
				THEN 1
			WHEN vw_mdr_09.criterio = 'MC' AND (vw_mdr_09.fch_transaccion >= cli_esp_mastercard_rut.fecha_inicio OR vw_mdr_09.fch_transaccion >= cli_esp_mastercard_codcred.fecha_inicio)
				THEN 1
      ELSE 0
	  END AS flg_cliente_especial
FROM
sdx_ti_mdr.vw_mdr_09_tp vw_mdr_09
LEFT JOIN sdx_ti_mdr.clientes_especiales_amex_rut cli_esp_amex_rut ON
cli_esp_amex_rut.mcc = vw_mdr_09.mcc
AND vw_mdr_09.rut = regexp_replace(cli_esp_amex_rut.rut,"^0+","") 
AND vw_mdr_09.criterio = 'AMEX'
LEFT JOIN sdx_ti_mdr.clientes_especiales_mastercard_rut cli_esp_mastercard_rut ON
cli_esp_mastercard_rut.mcc = vw_mdr_09.mcc
AND vw_mdr_09.rut = regexp_replace(cli_esp_mastercard_rut.rut,"^0+","")
AND vw_mdr_09.criterio = 'MC'
LEFT JOIN sdx_ti_mdr.clientes_especiales_visa_rut cli_esp_visa_rut ON
cli_esp_visa_rut.mcc = vw_mdr_09.mcc
AND vw_mdr_09.rut = regexp_replace(cli_esp_visa_rut.rut,"^0+","")
AND vw_mdr_09.criterio = 'VISA'
LEFT JOIN sdx_ti_mdr.clientes_especiales_amex_codcred cli_esp_amex_codcred ON
cli_esp_amex_codcred.mcc = vw_mdr_09.mcc
AND vw_mdr_09.cod_cred = cli_esp_amex_codcred.cod_cred
AND vw_mdr_09.criterio = 'AMEX' and vw_mdr_09.medio_pago_pucon_fixed=cli_esp_amex_codcred.medio_pago
LEFT JOIN sdx_ti_mdr.clientes_especiales_mastercard_codcred cli_esp_mastercard_codcred ON
cli_esp_mastercard_codcred.mcc = vw_mdr_09.mcc
AND vw_mdr_09.cod_cred = cli_esp_mastercard_codcred.cod_cred
AND vw_mdr_09.criterio = 'MC' and vw_mdr_09.medio_pago_pucon_fixed=cli_esp_mastercard_codcred.medio_pago
LEFT JOIN sdx_ti_mdr.clientes_especiales_visa_codcred cli_esp_visa_codcred ON
cli_esp_visa_codcred.mcc = vw_mdr_09.mcc
AND vw_mdr_09.cod_cred = cli_esp_visa_codcred.cod_cred
AND vw_mdr_09.criterio = 'VISA' and vw_mdr_09.medio_pago_pucon_fixed=cli_esp_visa_codcred.medio_pago;