CREATE OR REPLACE VIEW sdx_ti_mdr.vw_mdr_07_tp AS 
SELECT
      vw_mdr_06.id_proceso
	, vw_mdr_06.tms_ingesta
	, vw_mdr_06.tms_extraccion_fuente
	, vw_mdr_06.lnin_sec
	, vw_mdr_06.fch_transaccion
	, vw_mdr_06.sid_tx_secuencia
	, vw_mdr_06.cdg_comercio
	, vw_mdr_06.mto_transaccion
	, vw_mdr_06.mto_comision
	, vw_mdr_06.mto_vuelto
	, vw_mdr_06.num_bin_ext
	, vw_mdr_06.cdg_producto_canal_contratado
	, vw_mdr_06.cdg_tipo_transaccion
	, vw_mdr_06.cdg_medio_pago
	, vw_mdr_06.ttx_cod_moneda_tr cdg_moneda_iso
	, vw_mdr_06.fch_procesamiento
	, vw_mdr_06.fch_cambio_uf
	, vw_mdr_06.fch_cambio_dolar
	, vw_mdr_06.num_periodo_gestion
	, vw_mdr_06.val_uf
	, vw_mdr_06.val_dolar
	, vw_mdr_06.mto_transaccion_clp
	, vw_mdr_06.mto_transaccion_uf
	, vw_mdr_06.mto_transaccion_usd
	, vw_mdr_06.mto_comision_uf
	, vw_mdr_06.mto_vuelto_uf
	, vw_mdr_06.ttx_tipo_flujo
	, vw_mdr_06.ttx_cod_rubro
	, vw_mdr_06.ttx_cod_moneda_tr
	, vw_mdr_06.ttx_monto_orig
	, vw_mdr_06.ttx_fecha
	, vw_mdr_06.ttx_tipo_tx
	, vw_mdr_06.ttx_tipo_tran
	, vw_mdr_06.ttx_nac_o_ext
	, vw_mdr_06.ttx_marca_bin
	, vw_mdr_06.ttx_tipo_contrato
	, vw_mdr_06.ttx_tipo_tarjeta
	, vw_mdr_06.ttx_medio_pago
	, vw_mdr_06.ttx_emisor
	, vw_mdr_06.ttx_iva_comision
	, vw_mdr_06.lnin_sec_ant
	, vw_mdr_06.identificador_producto
	, vw_mdr_06.partition_year
	, vw_mdr_06.partition_month
	, vw_mdr_06.partition_day
	, vw_mdr_06.flg_surcharge
	, vw_mdr_06.cod_mod_ti
	, mto_transaccion_sin_vuelto
	, mto_transaccion_sin_vuelto_uf
	, cod_cred
	, count_trx
	, vw_mdr_06.rut
	, vw_mdr_06.tipo_conexion
	, vw_mdr_06.cod_rubro
	, vw_mdr_06.emisor_fixed
	, vw_mdr_06.bin
	, vw_mdr_06.medio_pago_pucon
	, vw_mdr_06.marca_fixed
	, CASE WHEN vw_mdr_06.emsr_gestion_fixed IS NULL THEN 'EXTRANJERAS' 
	ELSE vw_mdr_06.emsr_gestion_fixed 
	END AS emsr_gestion_fixed
	, vw_mdr_06.dsc_marca
	, vw_mdr_06.medio_pago_pucon_fixed
	, vw_mdr_06.modalidad
	, vw_mdr_06.dsc_marca_fixed
    , bin_mktg.product
    , bin_mktg.banco
    , CASE WHEN vw_mdr_06.bin in ('639229','603142','503441','590102') THEN 'MC'
	WHEN criterio_marca.criterio IS NULL THEN 'VISA'
	ELSE criterio_marca.criterio END AS criterio
    , mcc_arc.mcc
FROM
    sdx_ti_mdr.vw_mdr_06_tp vw_mdr_06
LEFT JOIN sdx_ti_mdr.bin_mktg ON
    vw_mdr_06.bin = bin_mktg.bin_number
LEFT JOIN sdx_ti_mdr.criterio_marca ON
    criterio_marca.marca = vw_mdr_06.dsc_marca_fixed
LEFT JOIN sdx_ti_mdr.mcc_arc ON
    vw_mdr_06.cod_rubro = mcc_arc.rubro_arc;