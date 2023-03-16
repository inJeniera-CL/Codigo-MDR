CREATE OR REPLACE VIEW sdx_ti_mdr.vw_mdr_05_tp 
AS SELECT
	  vw_mdr_04.id_proceso
	, vw_mdr_04.tms_ingesta
	, vw_mdr_04.tms_extraccion_fuente
	, vw_mdr_04.lnin_sec
	, vw_mdr_04.fch_transaccion
	, vw_mdr_04.sid_tx_secuencia
	, vw_mdr_04.cdg_comercio
	, vw_mdr_04.mto_transaccion
	, vw_mdr_04.mto_comision
	, vw_mdr_04.mto_vuelto
	, vw_mdr_04.num_bin_ext
	, vw_mdr_04.cdg_producto_canal_contratado
	, vw_mdr_04.cdg_tipo_transaccion
	, vw_mdr_04.cdg_medio_pago
	, vw_mdr_04.ttx_cod_moneda_tr cdg_moneda_iso
	, vw_mdr_04.fch_procesamiento
	, vw_mdr_04.fch_cambio_uf
	, vw_mdr_04.fch_cambio_dolar
	, vw_mdr_04.num_periodo_gestion
	, vw_mdr_04.val_uf
	, vw_mdr_04.val_dolar
	, vw_mdr_04.mto_transaccion_clp
	, vw_mdr_04.mto_transaccion_uf
	, vw_mdr_04.mto_transaccion_usd
	, vw_mdr_04.mto_comision_uf
	, vw_mdr_04.mto_vuelto_uf
	, vw_mdr_04.ttx_tipo_flujo
	, vw_mdr_04.ttx_cod_rubro
	, vw_mdr_04.ttx_cod_moneda_tr
	, vw_mdr_04.ttx_monto_orig
	, vw_mdr_04.ttx_fecha
	, vw_mdr_04.ttx_tipo_tx
	, vw_mdr_04.ttx_tipo_tran
	, vw_mdr_04.ttx_nac_o_ext
	, vw_mdr_04.ttx_marca_bin
	, vw_mdr_04.ttx_tipo_contrato
	, vw_mdr_04.ttx_tipo_tarjeta
	, vw_mdr_04.ttx_medio_pago
	, vw_mdr_04.ttx_emisor
	, vw_mdr_04.ttx_iva_comision
	, vw_mdr_04.lnin_sec_ant
	, vw_mdr_04.identificador_producto
	, vw_mdr_04.partition_year
	, vw_mdr_04.partition_month
	, vw_mdr_04.partition_day
	, vw_mdr_04.flg_surcharge
	, vw_mdr_04.cod_mod_ti
	, mto_transaccion_sin_vuelto
	, mto_transaccion_sin_vuelto_uf
	, cod_cred
	, count_trx
	, vw_mdr_04.rut
	, vw_mdr_04.tipo_conexion
	, vw_mdr_04.cod_rubro
	, vw_mdr_04.emisor_fixed
	, vw_mdr_04.bin
	, vw_mdr_04.medio_pago_pucon
	, vw_mdr_04.marca_fixed
	, vw_mdr_04.emsr_gestion_fixed
	, vw_mdr_04.dsc_marca
	, vw_mdr_04.medio_pago_pucon_fixed
	, CASE WHEN vw_mdr_04.cdg_comercio='27188249' THEN 'NO PRESENCIAL'
		   WHEN vw_mdr_04.tipo_conexion IN ('KCCT','LA','BTTN','WSCT','REC','ITM','NNB','PEXP','TNR','VPOS','TIMW','WSTM','KCCM','WSCM','BLOK','FALABELLA-INTERNET','QR') THEN 'NO PRESENCIAL'
		   WHEN vw_mdr_04.tipo_conexion IN ('POVA','IMP','PEA','RAAS','POS','MPOS','CELU','HOST','VTA','VTA1') THEN 'PRESENCIAL'
		   ELSE null 
	  END AS modalidad
FROM sdx_ti_mdr.vw_mdr_04_tp vw_mdr_04;