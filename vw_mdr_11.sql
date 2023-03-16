CREATE OR REPLACE VIEW sdx_ti_mdr.vw_mdr_11_tp AS
SELECT
   	  vw_mdr_10.id_proceso
	, vw_mdr_10.tms_ingesta
	, vw_mdr_10.tms_extraccion_fuente
	, vw_mdr_10.lnin_sec
	, vw_mdr_10.fch_transaccion
	, vw_mdr_10.sid_tx_secuencia
	, vw_mdr_10.cdg_comercio
	, vw_mdr_10.mto_transaccion
	, vw_mdr_10.mto_comision
	, vw_mdr_10.mto_vuelto
	, vw_mdr_10.num_bin_ext
	, vw_mdr_10.cdg_producto_canal_contratado
	, vw_mdr_10.cdg_tipo_transaccion
	, vw_mdr_10.cdg_medio_pago
	, vw_mdr_10.ttx_cod_moneda_tr cdg_moneda_iso
	, vw_mdr_10.fch_procesamiento
	, vw_mdr_10.fch_cambio_uf
	, vw_mdr_10.fch_cambio_dolar
	, vw_mdr_10.num_periodo_gestion
	, vw_mdr_10.val_uf
	, vw_mdr_10.val_dolar
	, vw_mdr_10.mto_transaccion_clp
	, vw_mdr_10.mto_transaccion_uf
	, vw_mdr_10.mto_transaccion_usd
	, vw_mdr_10.mto_comision_uf
	, vw_mdr_10.mto_vuelto_uf
	, vw_mdr_10.ttx_tipo_flujo
	, vw_mdr_10.ttx_cod_rubro
	, vw_mdr_10.ttx_cod_moneda_tr
	, vw_mdr_10.ttx_monto_orig
	, vw_mdr_10.ttx_fecha
	, vw_mdr_10.ttx_tipo_tx
	, vw_mdr_10.ttx_tipo_tran
	, vw_mdr_10.ttx_nac_o_ext
	, vw_mdr_10.ttx_marca_bin
	, vw_mdr_10.ttx_tipo_contrato
	, vw_mdr_10.ttx_tipo_tarjeta
	, vw_mdr_10.ttx_medio_pago
	, vw_mdr_10.ttx_emisor
	, vw_mdr_10.ttx_iva_comision
	, vw_mdr_10.lnin_sec_ant
	, vw_mdr_10.identificador_producto
	, vw_mdr_10.partition_year
	, vw_mdr_10.partition_month
	, vw_mdr_10.partition_day
	, vw_mdr_10.flg_surcharge
	, vw_mdr_10.cod_mod_ti
	, mto_transaccion_sin_vuelto
	, mto_transaccion_sin_vuelto_uf
	, cod_cred
	, count_trx
	, vw_mdr_10.rut
	, vw_mdr_10.tipo_conexion
	, vw_mdr_10.cod_rubro
	, vw_mdr_10.emisor_fixed
	, vw_mdr_10.bin
	, vw_mdr_10.medio_pago_pucon
	, vw_mdr_10.marca_fixed
	, vw_mdr_10.emsr_gestion_fixed
	, vw_mdr_10.dsc_marca
	, vw_mdr_10.medio_pago_pucon_fixed
	, vw_mdr_10.modalidad
	, vw_mdr_10.dsc_marca_fixed
    , vw_mdr_10.product
    , vw_mdr_10.banco
    , vw_mdr_10.criterio
    , vw_mdr_10.mcc	
	, vw_mdr_10.ti_product
	, vw_mdr_10.categoria
    , vw_mdr_10.categoria_especiales	
	, vw_mdr_10.flg_cliente_especial
    , CASE WHEN vw_mdr_10.categoria_especiales IS NOT NULL THEN vw_mdr_10.categoria_especiales		
    ELSE 		
    	CASE WHEN vw_mdr_10.categoria IS NOT NULL THEN vw_mdr_10.categoria	
    	WHEN vw_mdr_10.categoria IS NULL AND vw_mdr_10.criterio='VISA' AND vw_mdr_10.modalidad='PRESENCIAL' THEN 'Otros Presencial'	
    	WHEN vw_mdr_10.categoria IS NULL AND vw_mdr_10.criterio='VISA' AND vw_mdr_10.modalidad='NO PRESENCIAL' THEN 'Otros No Presencial'	
    	WHEN vw_mdr_10.categoria IS NULL AND vw_mdr_10.criterio='AMEX' THEN 'All Other'	
    	WHEN vw_mdr_10.categoria IS NULL AND vw_mdr_10.criterio='MC' THEN 'All Other'	
    	ELSE NULL END 
    END AS categoria_final		
FROM sdx_ti_mdr.vw_mdr_10_tp vw_mdr_10;