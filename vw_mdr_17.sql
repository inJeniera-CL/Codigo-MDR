CREATE OR REPLACE VIEW sdx_ti_mdr.vw_mdr_17_tp AS
SELECT
	  CASE WHEN cdg_tipo_transaccion in (2,3,9) THEN -mto_transaccion ELSE mto_transaccion END AS mto_transaccion
	, CASE WHEN cdg_tipo_transaccion in (2,3,9) THEN -mto_comision ELSE mto_comision END AS mto_comision
	, CASE WHEN cdg_tipo_transaccion in (2,3,9) THEN -mto_vuelto ELSE mto_vuelto END AS mto_vuelto
	, CASE WHEN cdg_tipo_transaccion in (2,3,9) THEN -mto_transaccion_uf ELSE mto_transaccion_uf END AS mto_transaccion_uf
	, CASE WHEN cdg_tipo_transaccion in (2,3,9) THEN -mto_comision_uf ELSE mto_comision_uf END AS mto_comision_uf
	, CASE WHEN cdg_tipo_transaccion in (2,3,9) THEN -mto_vuelto_uf ELSE mto_vuelto_uf END AS mto_vuelto_uf
	, CASE WHEN cdg_tipo_transaccion in (2,3,9) THEN -`vw_mdr_16`.`ttx_iva_comision` ELSE `vw_mdr_16`.`ttx_iva_comision` END AS ttx_iva_comision
	, CASE WHEN cdg_tipo_transaccion in (2,3,9) THEN -mto_transaccion_sin_vuelto ELSE mto_transaccion_sin_vuelto END AS mto_transaccion_sin_vuelto
	, CASE WHEN cdg_tipo_transaccion in (2,3,9) THEN -mto_transaccion_sin_vuelto_uf ELSE mto_transaccion_sin_vuelto_uf END AS mto_transaccion_sin_vuelto_uf
    , vw_mdr_16.id_proceso
	, vw_mdr_16.tms_ingesta
	, vw_mdr_16.tms_extraccion_fuente
	, vw_mdr_16.lnin_sec
	, vw_mdr_16.fch_transaccion
	, vw_mdr_16.sid_tx_secuencia
	, vw_mdr_16.cdg_comercio
	, vw_mdr_16.num_bin_ext
	, vw_mdr_16.cdg_producto_canal_contratado
	, vw_mdr_16.cdg_tipo_transaccion
	, vw_mdr_16.cdg_medio_pago
	, vw_mdr_16.cdg_moneda_iso
	, vw_mdr_16.fch_procesamiento
	, vw_mdr_16.fch_cambio_uf
	, vw_mdr_16.fch_cambio_dolar
	, vw_mdr_16.num_periodo_gestion
	, vw_mdr_16.val_uf
	, vw_mdr_16.val_dolar
	, vw_mdr_16.mto_transaccion_clp
	, vw_mdr_16.mto_transaccion_usd
	, vw_mdr_16.ttx_tipo_flujo
	, vw_mdr_16.ttx_cod_rubro
	, vw_mdr_16.ttx_cod_moneda_tr
	, vw_mdr_16.ttx_monto_orig
	, vw_mdr_16.ttx_fecha
	, vw_mdr_16.ttx_tipo_tx
	, vw_mdr_16.ttx_tipo_tran
	, vw_mdr_16.ttx_nac_o_ext
	, vw_mdr_16.ttx_marca_bin
	, vw_mdr_16.ttx_tipo_contrato
	, vw_mdr_16.ttx_tipo_tarjeta
	, vw_mdr_16.ttx_medio_pago
	, vw_mdr_16.ttx_emisor
	, vw_mdr_16.lnin_sec_ant
	, vw_mdr_16.identificador_producto
	, vw_mdr_16.partition_year
	, vw_mdr_16.partition_month
	, vw_mdr_16.partition_day
	, vw_mdr_16.cod_cred
	, vw_mdr_16.count_trx
	, vw_mdr_16.rut
	, vw_mdr_16.tipo_conexion
	, vw_mdr_16.cod_rubro
	, vw_mdr_16.emisor_fixed
	, vw_mdr_16.bin
	, vw_mdr_16.medio_pago_pucon
	, vw_mdr_16.marca_fixed
	, vw_mdr_16.emsr_gestion_fixed
	, vw_mdr_16.dsc_marca
	, vw_mdr_16.medio_pago_pucon_fixed
	, vw_mdr_16.medio_pago_pucon_fixed_informe
	, vw_mdr_16.modalidad
	, vw_mdr_16.dsc_marca_fixed
	, vw_mdr_16.dsc_marca_fixed_informe
	, vw_mdr_16.product
	, vw_mdr_16.banco
	, vw_mdr_16.criterio
	, vw_mdr_16.mcc
	, vw_mdr_16.ti_product
	, vw_mdr_16.categoria
	, vw_mdr_16.categoria_especiales
	, vw_mdr_16.categoria_final
	, vw_mdr_16.medio_pago_marca
	, vw_mdr_16.tasa
	, vw_mdr_16.emisor_informe
	, vw_mdr_16.id_informe
	, vw_mdr_16.nombre_informe
	, vw_mdr_16.emisor_informe_finanzas
	, vw_mdr_16.rut_informe_finanzas
	, vw_mdr_16.ti
	, vw_mdr_16.psp
	, flg_cap
	,`vw_mdr_16`.`flg_surcharge`
	, vw_mdr_16.flg_franquicia
	, vw_mdr_16.cod_mod_ti
	, CASE WHEN cdg_tipo_transaccion in (2,3,9) THEN -monto_tasa ELSE monto_tasa END AS monto_tasa
	, CASE WHEN (`vw_mdr_16`.`mcc` IN (4900,9311,4814) AND `vw_mdr_16`.`criterio`='AMEX')
	THEN '0' ELSE `vw_mdr_16`.`membresia` END *(CASE WHEN cdg_tipo_transaccion in (2,3,9) THEN -1 ELSE 1 END) AS membresia
	, CASE WHEN (`vw_mdr_16`.`mcc` IN (4900,9311,4814) AND `vw_mdr_16`.`criterio`='AMEX')
	THEN '0' ELSE `vw_mdr_16`.`switch_usd` END *(CASE WHEN cdg_tipo_transaccion in (2,3,9) THEN -1 ELSE 1 END) AS switch_usd
	, CASE WHEN (`vw_mdr_16`.`mcc` IN (4900,9311,4814) AND `vw_mdr_16`.`criterio`='AMEX')
	THEN '0' ELSE `vw_mdr_16`.`switch_usd_promedio` END *(CASE WHEN cdg_tipo_transaccion in (2,3,9) THEN -1 ELSE 1 END) AS switch_usd_promedio
	, `vw_mdr_16`.`grupo`
	, CASE WHEN (`vw_mdr_16`.`mcc` IN (4900,9311,4814) AND `vw_mdr_16`.`criterio`='AMEX')
	THEN '0' ELSE `vw_mdr_16`.`membresia_uf` END *(CASE WHEN cdg_tipo_transaccion in (2,3,9) THEN -1 ELSE 1 END) AS membresia_uf
	, CASE WHEN (`vw_mdr_16`.`mcc` IN (4900,9311,4814) AND `vw_mdr_16`.`criterio`='AMEX')
	THEN '0' ELSE `vw_mdr_16`.`switch_uf` END *(CASE WHEN cdg_tipo_transaccion in (2,3,9) THEN -1 ELSE 1 END) AS switch_uf
	, CASE WHEN (`vw_mdr_16`.`mcc` IN (4900,9311,4814) AND `vw_mdr_16`.`criterio`='AMEX')
	THEN '0' ELSE `vw_mdr_16`.`switch_uf_promedio` END *(CASE WHEN cdg_tipo_transaccion in (2,3,9) THEN -1 ELSE 1 END) AS switch_uf_promedio
	, CASE WHEN (`vw_mdr_16`.`mcc` IN (4900,9311,4814) AND `vw_mdr_16`.`criterio`='AMEX')
	THEN '0' ELSE `vw_mdr_16`.`costo_marca` END *(CASE WHEN cdg_tipo_transaccion in (2,3,9) THEN -1 ELSE 1 END) AS costo_marca
	, CASE WHEN vw_mdr_16.mcc = '4900' and vw_mdr_16.rut in ('760636533','784655105', '762438135','769450033',
																  '765287510','780537906', '770055989') THEN 1 ELSE 0 END AS flg_recaudadores
	, '1' as prc_desc
FROM sdx_ti_mdr.vw_mdr_16_tp vw_mdr_16;


drop table sdx_ti_mdr.proceso_202210_previa_tp;
create table sdx_ti_mdr.proceso_202210_previa_tp
as select * from sdx_ti_mdr.vw_mdr_17_tp;