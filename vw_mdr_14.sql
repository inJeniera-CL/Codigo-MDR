CREATE OR REPLACE VIEW sdx_ti_mdr.vw_mdr_14_tp AS
SELECT
   	 vw_mdr_13.id_proceso
	, vw_mdr_13.tms_ingesta
	, vw_mdr_13.tms_extraccion_fuente
	, vw_mdr_13.lnin_sec
	, vw_mdr_13.fch_transaccion
	, vw_mdr_13.sid_tx_secuencia
	, vw_mdr_13.cdg_comercio
	, vw_mdr_13.mto_transaccion
	, vw_mdr_13.mto_comision
	, vw_mdr_13.mto_vuelto
	, vw_mdr_13.num_bin_ext
	, vw_mdr_13.cdg_producto_canal_contratado
	, vw_mdr_13.cdg_tipo_transaccion
	, vw_mdr_13.cdg_medio_pago
	, vw_mdr_13.ttx_cod_moneda_tr cdg_moneda_iso
	, vw_mdr_13.fch_procesamiento
	, vw_mdr_13.fch_cambio_uf
	, vw_mdr_13.fch_cambio_dolar
	, vw_mdr_13.num_periodo_gestion
	, vw_mdr_13.val_uf
	, vw_mdr_13.val_dolar
	, vw_mdr_13.mto_transaccion_clp
	, vw_mdr_13.mto_transaccion_uf
	, vw_mdr_13.mto_transaccion_usd
	, vw_mdr_13.mto_comision_uf
	, vw_mdr_13.mto_vuelto_uf
	, vw_mdr_13.ttx_tipo_flujo
	, vw_mdr_13.ttx_cod_rubro
	, vw_mdr_13.ttx_cod_moneda_tr
	, vw_mdr_13.ttx_monto_orig
	, vw_mdr_13.ttx_fecha
	, vw_mdr_13.ttx_tipo_tx
	, vw_mdr_13.ttx_tipo_tran
	, vw_mdr_13.ttx_nac_o_ext
	, vw_mdr_13.ttx_marca_bin
	, vw_mdr_13.ttx_tipo_contrato
	, vw_mdr_13.ttx_tipo_tarjeta
	, vw_mdr_13.ttx_medio_pago
	, vw_mdr_13.ttx_emisor
	, vw_mdr_13.ttx_iva_comision
	, vw_mdr_13.lnin_sec_ant
	, vw_mdr_13.identificador_producto
	, vw_mdr_13.partition_year
	, vw_mdr_13.partition_month
	, vw_mdr_13.partition_day
	, mto_transaccion_sin_vuelto
	, mto_transaccion_sin_vuelto_uf
	, cod_cred
	, count_trx
	, vw_mdr_13.rut
	, vw_mdr_13.tipo_conexion
	, vw_mdr_13.cod_rubro
	, vw_mdr_13.emisor_fixed
	, vw_mdr_13.bin
	, vw_mdr_13.medio_pago_pucon
	, vw_mdr_13.marca_fixed
	, vw_mdr_13.emsr_gestion_fixed
	, vw_mdr_13.dsc_marca
	, vw_mdr_13.medio_pago_pucon_fixed
	, CASE
		WHEN vw_mdr_13.medio_pago_pucon_fixed = 4
			THEN 'Credito'
		WHEN vw_mdr_13.medio_pago_pucon_fixed = 5
			THEN 'Debito'
		WHEN vw_mdr_13.medio_pago_pucon_fixed = 6
			THEN 'Prepago'
		ELSE vw_mdr_13.medio_pago_pucon_fixed
	  END as medio_pago_pucon_fixed_informe
	, vw_mdr_13.modalidad
	, vw_mdr_13.dsc_marca_fixed
	, CASE 
		WHEN vw_mdr_13.dsc_marca_fixed = 'Visa Debito' or vw_mdr_13.dsc_marca_fixed = 'Electron'
			THEN 'Visa'
	    WHEN vw_mdr_13.dsc_marca_fixed = 'Maestro'
			THEN 'Master Card'
		WHEN vw_mdr_13.dsc_marca_fixed = 'MasterDebit'
			THEN 'Master Card'
		ELSE vw_mdr_13.dsc_marca_fixed
	   END AS dsc_marca_fixed_informe
    , vw_mdr_13.product
    , vw_mdr_13.banco
    , vw_mdr_13.criterio
    , vw_mdr_13.mcc	
	, vw_mdr_13.ti_product
	, vw_mdr_13.categoria
    , vw_mdr_13.categoria_especiales	
    , vw_mdr_13.categoria_final
    , vw_mdr_13.medio_pago_marca	
	, vw_mdr_13.tasa
	, emisor_normalizado.emisor_informe
	, emisor_normalizado.id_informe
	, emisor_normalizado.nombre_informe
	, emisor_normalizado.emisor_informe_finanzas
    , emisor_normalizado.rut_informe_finanzas
	, vw_mdr_13.flg_cliente_especial	
	, vw_mdr_13.mto_transaccion_sin_vuelto_uf*vw_mdr_13.tasa AS monto_tasa
	, vw_mdr_13.tasa as ti
	, vw_mdr_13.flg_surcharge
	, vw_mdr_13.cod_mod_ti
FROM sdx_ti_mdr.vw_mdr_13_tp vw_mdr_13
LEFT JOIN sdx_ti_mdr.emisor_normalizado ON emsr_gestion_fixed=emisor_gestion;