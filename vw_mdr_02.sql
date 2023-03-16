




CREATE OR REPLACE VIEW sdx_ti_mdr.vw_mdr_02_tp AS
WITH ULTIMO_DIA_HABIL_MES_AJUSTE as (select to_date(parametro) ULTIMO_DIA_HABIL_MES_AJUSTE from sdx_ti_mdr.parametros_ajuste where nombre_parametro='ULTIMO_DIA_HABIL_MES_AJUSTE')
SELECT vw_mdr_01.id_proceso
	, vw_mdr_01.tms_ingesta
	, vw_mdr_01.tms_extraccion_fuente
	, vw_mdr_01.lnin_sec
	, vw_mdr_01.fch_transaccion
	, vw_mdr_01.sid_tx_secuencia
	, vw_mdr_01.cdg_comercio
	, vw_mdr_01.mto_transaccion
	, vw_mdr_01.mto_comision
	, vw_mdr_01.mto_vuelto
	, vw_mdr_01.num_bin_ext
	, vw_mdr_01.cdg_producto_canal_contratado
	, vw_mdr_01.cdg_tipo_transaccion
	, vw_mdr_01.cdg_medio_pago
	, vw_mdr_01.ttx_cod_moneda_tr cdg_moneda_iso
	, vw_mdr_01.fch_procesamiento
	, vw_mdr_01.fch_cambio_uf
	, vw_mdr_01.fch_cambio_dolar
	, vw_mdr_01.num_periodo_gestion
	, vw_mdr_01.val_uf
	, vw_mdr_01.val_dolar
	, vw_mdr_01.mto_transaccion_clp
	, vw_mdr_01.mto_transaccion_uf
	, vw_mdr_01.mto_transaccion_usd
	, vw_mdr_01.mto_comision_uf
	, vw_mdr_01.mto_vuelto_uf
	, vw_mdr_01.ttx_tipo_flujo
	, vw_mdr_01.ttx_cod_rubro
	, vw_mdr_01.ttx_cod_moneda_tr
	, vw_mdr_01.ttx_monto_orig
	, vw_mdr_01.ttx_fecha
	, vw_mdr_01.ttx_tipo_tx
	, vw_mdr_01.ttx_tipo_tran
	, vw_mdr_01.ttx_nac_o_ext
	, vw_mdr_01.ttx_marca_bin
	, vw_mdr_01.ttx_tipo_contrato
	, vw_mdr_01.ttx_tipo_tarjeta
	, vw_mdr_01.ttx_medio_pago
	, cast(vw_mdr_01.ttx_emisor AS INT) ttx_emisor
	, vw_mdr_01.ttx_iva_comision
	, vw_mdr_01.lnin_sec_ant
	, vw_mdr_01.identificador_producto
	, vw_mdr_01.partition_year
	, vw_mdr_01.partition_month
	, vw_mdr_01.partition_day
	, vw_mdr_01.flg_surcharge
	, vw_mdr_01.cod_mod_ti
	, nvl(vw_mdr_01.mto_transaccion, 0)-nvl(vw_mdr_01.mto_vuelto,0) mto_transaccion_sin_vuelto
	, nvl(vw_mdr_01.mto_transaccion_uf, 0)-nvl(vw_mdr_01.mto_vuelto_uf,0) mto_transaccion_sin_vuelto_uf
	, CASE WHEN e1.cod_cred IS NULL THEN e2.cod_cred ELSE e1.cod_cred END AS cod_cred
	, case when cdg_tipo_transaccion=1 THEN 1 ELSE -1 END as count_trx
	, CASE when e1.rut is not null then e1.rut else e2.rut end as rut
	, case when e1.tipo_conexion is not null then e1.tipo_conexion else e2.tipo_conexion end as tipo_conexion
	, case when e1.cod_rubro is not null then cast(e1.cod_rubro AS INT) else cast(e2.cod_rubro AS INT) end as cod_rubro
	, substr(vw_mdr_01.num_bin_ext, 0, 6) bin
	, CASE 
		WHEN vw_mdr_01.ttx_tipo_contrato <> '03'
			THEN CASE 
					WHEN vw_mdr_01.ttx_marca_bin NOT IN (
							'CE'
							, 'PR'
							, 'TC'
							, 'TR'
							, 'TE'
							, 'TM'
							)
						THEN 4
					ELSE 7
					END
		ELSE CASE 
				WHEN vw_mdr_01.cdg_medio_pago = 'P' OR vw_mdr_01.identificador_producto IN ('VPI','MPI')
					THEN 6
				ELSE 5
				END
		END AS MEDIO_PAGO_PUCON
	, CASE 
		WHEN substr(vw_mdr_01.num_bin_ext, 0, 6) IN (
				'522181'
				, '541320'
				, '543200'
				, '568009'
				)
			AND cast(vw_mdr_01.ttx_emisor AS INT) = 69
			THEN 69
		WHEN substr(vw_mdr_01.num_bin_ext, 0, 6) IN (
				'410886'
				, '435718'
				)
			AND cast(vw_mdr_01.ttx_emisor AS INT) = 68
			THEN 58
		WHEN substr(vw_mdr_01.num_bin_ext, 0, 6) IN ('505780')
			AND cast(vw_mdr_01.ttx_emisor AS INT) = 68
			THEN 83
		WHEN vw_mdr_01.ttx_tipo_contrato = '03'
			AND vw_mdr_01.cdg_medio_pago != 'P'
			AND cast(vw_mdr_01.ttx_emisor AS INT) = 25
			THEN 32
		WHEN vw_mdr_01.ttx_tipo_contrato = '03'
			AND vw_mdr_01.cdg_medio_pago != 'P'
			AND cast(vw_mdr_01.ttx_emisor AS INT) = 45
			THEN 31
		ELSE cast(vw_mdr_01.ttx_emisor AS INT)
		END AS emisor_fixed
	, CASE 
		WHEN vw_mdr_01.ttx_medio_pago IS NULL
			THEN vw_mdr_01.ttx_marca_bin
		ELSE vw_mdr_01.ttx_medio_pago
		END AS marca_fixed
FROM sdx_ti_mdr.vw_mdr_01_tp vw_mdr_01, ULTIMO_DIA_HABIL_MES_AJUSTE
LEFT JOIN sdx_ti_mdr.establecimientos_oct_2022 e1
ON e1.part_tms_extraccion_fuente=ULTIMO_DIA_HABIL_MES_AJUSTE.ULTIMO_DIA_HABIL_MES_AJUSTE
AND regexp_replace(vw_mdr_01.cdg_comercio,"^0+","")=regexp_replace(e1.cod_cred,"^0+","")
LEFT JOIN sdx_ti_mdr.establecimientos_oct_2022 e2 
ON e2.part_tms_extraccion_fuente=ULTIMO_DIA_HABIL_MES_AJUSTE.ULTIMO_DIA_HABIL_MES_AJUSTE
AND regexp_replace(vw_mdr_01.cdg_comercio,"^0+","")=regexp_replace(e2.cod_dolar,"^0+","");
