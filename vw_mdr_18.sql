CREATE OR REPLACE VIEW sdx_ti_mdr.vw_mdr_18_tp AS
SELECT
   	  vw_mdr_17.id_proceso
	, vw_mdr_17.tms_ingesta
	, vw_mdr_17.tms_extraccion_fuente
	, vw_mdr_17.lnin_sec
	, vw_mdr_17.fch_transaccion
	, vw_mdr_17.sid_tx_secuencia
	, vw_mdr_17.cdg_comercio
	, vw_mdr_17.mto_transaccion
	, vw_mdr_17.mto_comision
	, vw_mdr_17.mto_vuelto
	, vw_mdr_17.num_bin_ext
	, vw_mdr_17.cdg_producto_canal_contratado
	, vw_mdr_17.cdg_tipo_transaccion
	, vw_mdr_17.cdg_medio_pago
	, vw_mdr_17.cdg_moneda_iso
	, vw_mdr_17.fch_procesamiento
	, vw_mdr_17.fch_cambio_uf
	, vw_mdr_17.fch_cambio_dolar
	, vw_mdr_17.num_periodo_gestion
	, vw_mdr_17.val_uf
	, vw_mdr_17.val_dolar
	, vw_mdr_17.mto_transaccion_clp
	, vw_mdr_17.mto_transaccion_uf
	, vw_mdr_17.mto_transaccion_usd
	, vw_mdr_17.mto_comision_uf
	, vw_mdr_17.mto_vuelto_uf
	, vw_mdr_17.ttx_tipo_flujo
	, vw_mdr_17.ttx_cod_rubro
	, vw_mdr_17.ttx_cod_moneda_tr
	, vw_mdr_17.ttx_monto_orig
	, vw_mdr_17.ttx_fecha
	, vw_mdr_17.ttx_tipo_tx
	, vw_mdr_17.ttx_tipo_tran
	, vw_mdr_17.ttx_nac_o_ext
	, vw_mdr_17.ttx_marca_bin
	, vw_mdr_17.ttx_tipo_contrato
	, vw_mdr_17.ttx_tipo_tarjeta
	, vw_mdr_17.ttx_medio_pago
	, vw_mdr_17.ttx_emisor
	, vw_mdr_17.ttx_iva_comision
	, vw_mdr_17.lnin_sec_ant
	, vw_mdr_17.identificador_producto
	, vw_mdr_17.partition_year
	, vw_mdr_17.partition_month
	, vw_mdr_17.partition_day
	, vw_mdr_17.mto_transaccion_sin_vuelto
	, vw_mdr_17.mto_transaccion_sin_vuelto_uf
	, vw_mdr_17.cod_cred
	, vw_mdr_17.count_trx
	, vw_mdr_17.rut
	, vw_mdr_17.tipo_conexion
	, vw_mdr_17.cod_rubro
	, vw_mdr_17.emisor_fixed
	, vw_mdr_17.bin
	, vw_mdr_17.medio_pago_pucon
	, vw_mdr_17.marca_fixed
	, vw_mdr_17.emsr_gestion_fixed
	, vw_mdr_17.dsc_marca
	, vw_mdr_17.medio_pago_pucon_fixed
	, vw_mdr_17.medio_pago_pucon_fixed_informe
	, vw_mdr_17.modalidad
	, vw_mdr_17.dsc_marca_fixed
	, vw_mdr_17.dsc_marca_fixed_informe
	, vw_mdr_17.product
	, vw_mdr_17.banco
	, vw_mdr_17.criterio
	, vw_mdr_17.mcc
	, vw_mdr_17.ti_product
	, vw_mdr_17.categoria
	, vw_mdr_17.categoria_especiales
	, vw_mdr_17.categoria_final
	, vw_mdr_17.medio_pago_marca
	, vw_mdr_17.tasa
	, vw_mdr_17.emisor_informe
	, vw_mdr_17.id_informe
	, vw_mdr_17.nombre_informe
	, vw_mdr_17.emisor_informe_finanzas
	, vw_mdr_17.rut_informe_finanzas
	, vw_mdr_17.monto_tasa
	, vw_mdr_17.ti
	, vw_mdr_17.psp
	, flg_cap
	, vw_mdr_17.flg_surcharge
	, vw_mdr_17.cod_mod_ti
	, vw_mdr_17.membresia
	, vw_mdr_17.switch_usd
	, vw_mdr_17.switch_usd_promedio
	, vw_mdr_17.grupo
	, vw_mdr_17.membresia_uf
	, vw_mdr_17.switch_uf
	, vw_mdr_17.switch_uf_promedio
	, vw_mdr_17.costo_marca
	, case 
		when flg_franquicia = 0 then 
			(CASE
				when (vw_mdr_17.psp = 1 OR vw_mdr_17.flg_recaudadores = 1) AND vw_mdr_17.medio_pago_marca = 4 then 0.001594
				when (vw_mdr_17.psp = 1 OR vw_mdr_17.flg_recaudadores = 1) AND vw_mdr_17.medio_pago_marca = 5 then 0.001242
				when vw_mdr_17.psp = 0 and vw_mdr_17.medio_pago_marca = 4 then 0.002254
				when vw_mdr_17.psp = 0 AND vw_mdr_17.medio_pago_marca = 5 then 0.001770
			END) * (CASE WHEN cdg_tipo_transaccion!=1 THEN -1 ELSE 1 END) / mto_transaccion_sin_vuelto_uf
		ELSE
			vw_ma_01.tasa_ma END AS tasa_ma_ajustado
	, case 
		when flg_franquicia = 0 then 
			(CASE
				when (vw_mdr_17.psp = 1 OR vw_mdr_17.flg_recaudadores = 1) and vw_mdr_17.medio_pago_marca = 4 then 0.001594
				when (vw_mdr_17.psp = 1 OR vw_mdr_17.flg_recaudadores = 1) AND vw_mdr_17.medio_pago_marca = 5 then 0.001242
				when vw_mdr_17.psp = 0 and vw_mdr_17.medio_pago_marca = 4 then 0.002254
				when vw_mdr_17.psp = 0 AND vw_mdr_17.medio_pago_marca = 5 then 0.001770
			END) * (CASE WHEN cdg_tipo_transaccion!=1 THEN -1 ELSE 1 END)
		ELSE
			vw_ma_01.tasa_ma * mto_transaccion_sin_vuelto_uf END AS monto_ma_ajustado
	, CASE WHEN vw_mdr_17.emsr_gestion_fixed!='EXTRANJERAS' AND vw_mdr_17.emsr_gestion_fixed IS NOT NULL THEN vw_mdr_17.membresia_uf
	END AS membresia_uf_nacional
	, CASE WHEN bin in ('590202', '503441', '639229', '590101', '590102', '603142', '621996', '505780') THEN vw_mdr_17.switch_uf_promedio
			END AS switch_uf_nacional_3p 	
	, CASE WHEN bin in ('590202', '503441', '639229', '590101', '590102', '603142', '621996', '505780')	THEN vw_mdr_17.switch_uf
	END AS switch_uf_promedio_nacional_3p
	, CASE WHEN vw_mdr_17.emsr_gestion_fixed!='EXTRANJERAS' AND vw_mdr_17.emsr_gestion_fixed IS NOT NULL AND dsc_marca_fixed='Redcompra' THEN vw_mdr_17.membresia_uf
	END AS membresia_uf_nacional_redcompra
	, vw_ma_01.grupo_negativo
	, 0 as flg_mc
	, flg_franquicia
FROM sdx_ti_mdr.proceso_202210_previa_tp vw_mdr_17
LEFT JOIN sdx_ti_mdr.vw_ma_01 
	 ON vw_ma_01.grupo = vw_mdr_17.grupo 
	and vw_ma_01.psp = vw_mdr_17.psp
	and vw_ma_01.medio_pago_marca = vw_mdr_17.medio_pago_marca;

drop table sdx_ti_mdr.proceso_202210_tp;
create table sdx_ti_mdr.proceso_202210_tp
as select * from sdx_ti_mdr.vw_mdr_18_tp;