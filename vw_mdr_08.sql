CREATE OR REPLACE VIEW sdx_ti_mdr.vw_mdr_08_tp AS 
SELECT
	  vw_mdr_07.id_proceso
	, vw_mdr_07.tms_ingesta
	, vw_mdr_07.tms_extraccion_fuente
	, vw_mdr_07.lnin_sec
	, vw_mdr_07.fch_transaccion
	, vw_mdr_07.sid_tx_secuencia
	, vw_mdr_07.cdg_comercio
	, vw_mdr_07.mto_transaccion
	, vw_mdr_07.mto_comision
	, vw_mdr_07.mto_vuelto
	, vw_mdr_07.num_bin_ext
	, vw_mdr_07.cdg_producto_canal_contratado
	, vw_mdr_07.cdg_tipo_transaccion
	, vw_mdr_07.cdg_medio_pago
	, vw_mdr_07.ttx_cod_moneda_tr cdg_moneda_iso
	, vw_mdr_07.fch_procesamiento
	, vw_mdr_07.fch_cambio_uf
	, vw_mdr_07.fch_cambio_dolar
	, vw_mdr_07.num_periodo_gestion
	, vw_mdr_07.val_uf
	, vw_mdr_07.val_dolar
	, vw_mdr_07.mto_transaccion_clp
	, vw_mdr_07.mto_transaccion_uf
	, vw_mdr_07.mto_transaccion_usd
	, vw_mdr_07.mto_comision_uf
	, vw_mdr_07.mto_vuelto_uf
	, vw_mdr_07.ttx_tipo_flujo
	, vw_mdr_07.ttx_cod_rubro
	, vw_mdr_07.ttx_cod_moneda_tr
	, vw_mdr_07.ttx_monto_orig
	, vw_mdr_07.ttx_fecha
	, vw_mdr_07.ttx_tipo_tx
	, vw_mdr_07.ttx_tipo_tran
	, vw_mdr_07.ttx_nac_o_ext
	, vw_mdr_07.ttx_marca_bin
	, vw_mdr_07.ttx_tipo_contrato
	, vw_mdr_07.ttx_tipo_tarjeta
	, vw_mdr_07.ttx_medio_pago
	, vw_mdr_07.ttx_emisor
	, vw_mdr_07.ttx_iva_comision
	, vw_mdr_07.lnin_sec_ant
	, vw_mdr_07.identificador_producto
	, vw_mdr_07.partition_year
	, vw_mdr_07.partition_month
	, vw_mdr_07.partition_day
	, vw_mdr_07.flg_surcharge
	, vw_mdr_07.cod_mod_ti
	, mto_transaccion_sin_vuelto
	, mto_transaccion_sin_vuelto_uf
	, cod_cred
	, count_trx
	, vw_mdr_07.rut
	, vw_mdr_07.tipo_conexion
	, vw_mdr_07.cod_rubro
	, vw_mdr_07.emisor_fixed
	, vw_mdr_07.bin
	, vw_mdr_07.medio_pago_pucon
	, vw_mdr_07.marca_fixed
	, vw_mdr_07.emsr_gestion_fixed
	, vw_mdr_07.dsc_marca
	, vw_mdr_07.medio_pago_pucon_fixed
	, vw_mdr_07.modalidad
	, vw_mdr_07.dsc_marca_fixed
    , vw_mdr_07.product
    , vw_mdr_07.banco
    , vw_mdr_07.criterio
    , vw_mdr_07.mcc
    , CASE 
	--WHEN vw_mdr_07.bin IN ('456865', '486445') THEN producto_tarjetas.ti_product
	WHEN vw_mdr_07.bin IN ('590101', '621996', '590102', '491098', '639229', '603142', '503441', '505780', '590202') THEN 'Standard'
	WHEN vw_mdr_07.criterio='MC' AND ti_product IS NULL AND vw_mdr_07.medio_pago_pucon_fixed=4 THEN 'Black'
	WHEN vw_mdr_07.criterio='MC' AND ti_product IS NULL AND vw_mdr_07.medio_pago_pucon_fixed!=4 THEN 'Standard'
	WHEN vw_mdr_07.criterio='VISA' AND producto_tarjetas.ti_product IS NULL AND vw_mdr_07.medio_pago_pucon_fixed=4 THEN 'Platinum' --OK
	WHEN vw_mdr_07.criterio='VISA' AND producto_tarjetas.ti_product IS NULL AND vw_mdr_07.dsc_marca_fixed NOT IN ('Redcompra','Electron') AND vw_mdr_07.medio_pago_pucon_fixed IN (5,6) THEN 'Standard'
	WHEN vw_mdr_07.criterio='VISA' AND producto_tarjetas.ti_product='Black' AND vw_mdr_07.dsc_marca_fixed NOT IN ('Redcompra','Electron') AND vw_mdr_07.medio_pago_pucon_fixed IN (5,6) THEN 'Comercial'
	WHEN vw_mdr_07.criterio='VISA' AND vw_mdr_07.dsc_marca_fixed IN ('Redcompra','Electron') AND vw_mdr_07.medio_pago_pucon_fixed IN (5,6) THEN 'Standard'
	ELSE producto_tarjetas.ti_product
    END AS ti_product
FROM
sdx_ti_mdr.vw_mdr_07_tp vw_mdr_07 
LEFT JOIN sdx_ti_mdr.producto_tarjetas ON
vw_mdr_07.product = producto_tarjetas.mktg_producto;

drop table sdx_ti_mdr.mdr_08_10_2022_tp;
create table sdx_ti_mdr.mdr_08_10_2022_tp
as select * from sdx_ti_mdr.vw_mdr_08_tp;