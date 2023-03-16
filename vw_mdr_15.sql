create or replace view sdx_ti_mdr.vw_mdr_15_tp as
SELECT
      vw_mdr_14.id_proceso
	, vw_mdr_14.tms_ingesta
	, vw_mdr_14.tms_extraccion_fuente
	, vw_mdr_14.lnin_sec
	, vw_mdr_14.fch_transaccion
	, vw_mdr_14.sid_tx_secuencia
	, vw_mdr_14.cdg_comercio
	, vw_mdr_14.mto_transaccion
	, vw_mdr_14.mto_comision
	, vw_mdr_14.mto_vuelto
	, vw_mdr_14.num_bin_ext
	, vw_mdr_14.cdg_producto_canal_contratado
	, vw_mdr_14.cdg_tipo_transaccion
	, vw_mdr_14.cdg_medio_pago
	, vw_mdr_14.cdg_moneda_iso
	, vw_mdr_14.fch_procesamiento
	, vw_mdr_14.fch_cambio_uf
	, vw_mdr_14.fch_cambio_dolar
	, vw_mdr_14.num_periodo_gestion
	, vw_mdr_14.val_uf
	, vw_mdr_14.val_dolar
	, vw_mdr_14.mto_transaccion_clp
	, vw_mdr_14.mto_transaccion_uf
	, vw_mdr_14.mto_transaccion_usd
	, vw_mdr_14.mto_comision_uf
	, vw_mdr_14.mto_vuelto_uf
	, vw_mdr_14.ttx_tipo_flujo
	, vw_mdr_14.ttx_cod_rubro
	, vw_mdr_14.ttx_cod_moneda_tr
	, vw_mdr_14.ttx_monto_orig
	, vw_mdr_14.ttx_fecha
	, vw_mdr_14.ttx_tipo_tx
	, vw_mdr_14.ttx_tipo_tran
	, vw_mdr_14.ttx_nac_o_ext
	, vw_mdr_14.ttx_marca_bin
	, vw_mdr_14.ttx_tipo_contrato
	, vw_mdr_14.ttx_tipo_tarjeta
	, vw_mdr_14.ttx_medio_pago
	, vw_mdr_14.ttx_emisor
	, vw_mdr_14.ttx_iva_comision
	, vw_mdr_14.lnin_sec_ant
	, vw_mdr_14.identificador_producto
	, vw_mdr_14.partition_year
	, vw_mdr_14.partition_month
	, vw_mdr_14.partition_day
	, vw_mdr_14.flg_surcharge
	, vw_mdr_14.cod_mod_ti
	, vw_mdr_14.mto_transaccion_sin_vuelto
	, vw_mdr_14.mto_transaccion_sin_vuelto_uf
	, vw_mdr_14.cod_cred
	, vw_mdr_14.count_trx
	, vw_mdr_14.rut
	, vw_mdr_14.tipo_conexion
	, vw_mdr_14.cod_rubro
	, vw_mdr_14.emisor_fixed
	, vw_mdr_14.bin
	, vw_mdr_14.medio_pago_pucon
	, vw_mdr_14.marca_fixed
	, vw_mdr_14.emsr_gestion_fixed
	, vw_mdr_14.dsc_marca
	, vw_mdr_14.medio_pago_pucon_fixed
	, vw_mdr_14.medio_pago_pucon_fixed_informe
	, vw_mdr_14.modalidad
	, vw_mdr_14.dsc_marca_fixed
	, vw_mdr_14.dsc_marca_fixed_informe
	, vw_mdr_14.product
	, vw_mdr_14.banco
	, vw_mdr_14.criterio
	, vw_mdr_14.mcc
	, vw_mdr_14.ti_product
	, vw_mdr_14.categoria
	, vw_mdr_14.categoria_especiales
	, vw_mdr_14.categoria_final
	, vw_mdr_14.medio_pago_marca
	, vw_mdr_14.tasa
	, vw_mdr_14.emisor_informe
	, vw_mdr_14.id_informe
	, vw_mdr_14.nombre_informe
	, vw_mdr_14.emisor_informe_finanzas
	, vw_mdr_14.rut_informe_finanzas
	, vw_mdr_14.monto_tasa
	, vw_mdr_14.ti
	, CASE 
	WHEN vw_mdr_14.criterio='AMEX' AND MCC IN ('4900','9311','4814') THEN '0'
	WHEN ((vw_mdr_14.emsr_gestion_fixed!='EXTRANJERAS' AND vw_mdr_14.emsr_gestion_fixed IS NOT NULL) OR NVL(vw_mdr_14.flg_surcharge,0)=1) AND vw_mdr_14.criterio='MC' AND (vw_mdr_14.medio_pago_pucon_fixed=6 or dsc_marca_fixed = 'MasterDebit' or dsc_marca_fixed = 'Redcompra') and vw_mdr_14.medio_pago_marca= 5 THEN '0.00036'/('1'-'0.3')
	WHEN ((vw_mdr_14.emsr_gestion_fixed!='EXTRANJERAS' AND vw_mdr_14.emsr_gestion_fixed IS NOT NULL) OR NVL(vw_mdr_14.flg_surcharge,0)=1) AND vw_mdr_14.criterio='MC' AND vw_mdr_14.medio_pago_pucon_fixed!=6 and dsc_marca_fixed = 'Maestro' and vw_mdr_14.medio_pago_marca= 5 THEN '0.00045'/('1'-'0.3')
	WHEN ((vw_mdr_14.emsr_gestion_fixed!='EXTRANJERAS' AND vw_mdr_14.emsr_gestion_fixed IS NOT NULL) OR NVL(vw_mdr_14.flg_surcharge,0)=1) AND vw_mdr_14.criterio='MC' AND vw_mdr_14.medio_pago_marca=4 THEN '0.001'/('1'-'0.3')
	WHEN ((vw_mdr_14.emsr_gestion_fixed!='EXTRANJERAS' AND vw_mdr_14.emsr_gestion_fixed IS NOT NULL) OR NVL(vw_mdr_14.flg_surcharge,0)=1) AND vw_mdr_14.criterio='VISA' AND vw_mdr_14.medio_pago_marca=4 THEN '0.00090'/('1'-'0.3')
	WHEN ((vw_mdr_14.emsr_gestion_fixed!='EXTRANJERAS' AND vw_mdr_14.emsr_gestion_fixed IS NOT NULL) OR NVL(vw_mdr_14.flg_surcharge,0)=1) AND vw_mdr_14.criterio='VISA' AND vw_mdr_14.medio_pago_marca=5 THEN '0.00020'/('1'-'0.3')
	WHEN MCC NOT IN ('4900','9311','4814') AND ((vw_mdr_14.emsr_gestion_fixed!='EXTRANJERAS' AND vw_mdr_14.emsr_gestion_fixed IS NOT NULL) OR NVL(vw_mdr_14.flg_surcharge,0)=1) AND vw_mdr_14.criterio='AMEX' AND vw_mdr_14.medio_pago_marca=5 THEN '0.0014'
	WHEN MCC NOT IN ('4900','9311','4814') AND ((vw_mdr_14.emsr_gestion_fixed!='EXTRANJERAS' AND vw_mdr_14.emsr_gestion_fixed IS NOT NULL) OR NVL(vw_mdr_14.flg_surcharge,0)=1) AND vw_mdr_14.criterio='AMEX' AND vw_mdr_14.medio_pago_marca=4 THEN '0.0014'
	WHEN (vw_mdr_14.emsr_gestion_fixed='EXTRANJERAS' OR vw_mdr_14.emsr_gestion_fixed IS NULL) AND NVL(vw_mdr_14.flg_surcharge,0)!=1 AND vw_mdr_14.criterio='MC' AND vw_mdr_14.ttx_cod_moneda_tr=152 THEN '0.007'/('1'-'0.3')
	WHEN (vw_mdr_14.emsr_gestion_fixed='EXTRANJERAS' OR vw_mdr_14.emsr_gestion_fixed IS NULL) AND NVL(vw_mdr_14.flg_surcharge,0)!=1 AND vw_mdr_14.criterio='MC' AND vw_mdr_14.ttx_cod_moneda_tr=840 THEN '0.0145'/('1'-'0.3')
	WHEN (vw_mdr_14.emsr_gestion_fixed='EXTRANJERAS' OR vw_mdr_14.emsr_gestion_fixed IS NULL) AND NVL(vw_mdr_14.flg_surcharge,0)!=1 AND vw_mdr_14.criterio='VISA' AND vw_mdr_14.ttx_cod_moneda_tr=152 THEN '0.0065'/('1'-'0.3')
	WHEN (vw_mdr_14.emsr_gestion_fixed='EXTRANJERAS' OR vw_mdr_14.emsr_gestion_fixed IS NULL) AND NVL(vw_mdr_14.flg_surcharge,0)!=1 AND vw_mdr_14.criterio='VISA' AND vw_mdr_14.ttx_cod_moneda_tr=840 AND vw_mdr_14.modalidad='PRESENCIAL' THEN '0.0095'/('1'-'0.3')
	WHEN (vw_mdr_14.emsr_gestion_fixed='EXTRANJERAS' OR vw_mdr_14.emsr_gestion_fixed IS NULL) AND NVL(vw_mdr_14.flg_surcharge,0)!=1 AND vw_mdr_14.criterio='VISA' AND vw_mdr_14.ttx_cod_moneda_tr=840 AND vw_mdr_14.modalidad!='PRESENCIAL' THEN '0.01'/('1'-'0.3')
	WHEN MCC NOT IN ('4900','9311','4814') AND (vw_mdr_14.emsr_gestion_fixed='EXTRANJERAS' OR vw_mdr_14.emsr_gestion_fixed IS NULL) AND NVL(vw_mdr_14.flg_surcharge,0)!=1 AND vw_mdr_14.criterio='AMEX' AND vw_mdr_14.ttx_cod_moneda_tr=152 THEN '0.002'
	WHEN MCC NOT IN ('4900','9311','4814') AND (vw_mdr_14.emsr_gestion_fixed='EXTRANJERAS' OR vw_mdr_14.emsr_gestion_fixed IS NULL) AND NVL(vw_mdr_14.flg_surcharge,0)!=1 AND vw_mdr_14.criterio='AMEX' AND vw_mdr_14.ttx_cod_moneda_tr=840 THEN '0.002'
	else null END AS membresia
	,CASE
	WHEN vw_mdr_14.criterio='AMEX' AND MCC IN ('4900','9311','4814') THEN '0'
	WHEN ((vw_mdr_14.emsr_gestion_fixed!='EXTRANJERAS' AND vw_mdr_14.emsr_gestion_fixed IS NOT NULL) OR NVL(vw_mdr_14.flg_surcharge,0)=1) AND vw_mdr_14.criterio='VISA' THEN '0.0075' / ('1'-'0.35')
	WHEN ((vw_mdr_14.emsr_gestion_fixed!='EXTRANJERAS' AND vw_mdr_14.emsr_gestion_fixed IS NOT NULL) OR NVL(vw_mdr_14.flg_surcharge,0)=1) AND MCC NOT IN ('4900','9311','4814') AND vw_mdr_14.criterio='AMEX' THEN '0'
	WHEN ((vw_mdr_14.emsr_gestion_fixed!='EXTRANJERAS' AND vw_mdr_14.emsr_gestion_fixed IS NOT NULL) OR NVL(vw_mdr_14.flg_surcharge,0)=1) AND vw_mdr_14.criterio='MC' AND dsc_marca_fixed!='Maestro' THEN -- '0.007128'/('1'-'0.35')
	 (case
	when (case when ttx_cod_moneda_tr = 152 then mto_transaccion_sin_vuelto/val_dolar when ttx_cod_moneda_tr = 840 then mto_transaccion_sin_vuelto end) >= '25.01' then ('0.032' + '0.0000034') / ('1' - '0.35')
		 + (CASE WHEN modalidad = 'NO PRESENCIAL' THEN LEAST((((mto_transaccion_sin_vuelto/val_dolar) * '0.00025') / ('1'-'0.35')) , ('3' / ('1'-'0.35'))) ELSE '0' END)
	when (case when ttx_cod_moneda_tr = 152 then mto_transaccion_sin_vuelto/val_dolar when ttx_cod_moneda_tr = 840 then mto_transaccion_sin_vuelto end) >= '10.01' then ('0.02' + '0.0000034') / ('1' - '0.35')
		 + (CASE WHEN modalidad = 'NO PRESENCIAL' THEN LEAST((((mto_transaccion_sin_vuelto/val_dolar) * '0.00025') / ('1'-'0.35')) , ('3' / ('1'-'0.35'))) ELSE '0' END)
	when (case when ttx_cod_moneda_tr = 152 then mto_transaccion_sin_vuelto/val_dolar when ttx_cod_moneda_tr = 840 then mto_transaccion_sin_vuelto end) >= '5.01' then ('0.0115' + '0.0000034') / ('1' - '0.35')
		 + (CASE WHEN modalidad = 'NO PRESENCIAL' THEN LEAST((((mto_transaccion_sin_vuelto/val_dolar) * '0.00025') / ('1'-'0.35')) , ('3' / ('1'-'0.35'))) ELSE '0' END)
	when (case when ttx_cod_moneda_tr = 152 then mto_transaccion_sin_vuelto/val_dolar when ttx_cod_moneda_tr = 840 then mto_transaccion_sin_vuelto end) >= '1.01' then ('0.00225' + '0.0000034') / ('1' - '0.35')
		 + (CASE WHEN modalidad = 'NO PRESENCIAL' THEN LEAST((((mto_transaccion_sin_vuelto/val_dolar) * '0.00025') / ('1'-'0.35')) , ('3' / ('1'-'0.35'))) ELSE '0' END)
	when (case when ttx_cod_moneda_tr = 152 then mto_transaccion_sin_vuelto/val_dolar when ttx_cod_moneda_tr = 840 then mto_transaccion_sin_vuelto end) >= '0' then ('0.0005' + '0.0000034') / ('1' - '0.35')
		+ (CASE WHEN modalidad = 'NO PRESENCIAL' THEN LEAST((((mto_transaccion_sin_vuelto/val_dolar) * '0.00025') / ('1'-'0.35')) , ('3' / ('1'-'0.35'))) ELSE '0' END)
	end)
	WHEN ((vw_mdr_14.emsr_gestion_fixed!='EXTRANJERAS' AND vw_mdr_14.emsr_gestion_fixed IS NOT NULL) OR NVL(vw_mdr_14.flg_surcharge,0)=1) AND vw_mdr_14.criterio='MC' AND dsc_marca_fixed='Maestro' THEN ('0.008' + '0.0007') / ('1'-'0.35')
	+ (CASE WHEN modalidad = 'NO PRESENCIAL' THEN LEAST((((mto_transaccion_sin_vuelto/val_dolar) * '0.00025') / ('1'-'0.35')) , ('3' / ('1'-'0.35'))) ELSE '0' END)
	WHEN (vw_mdr_14.emsr_gestion_fixed='EXTRANJERAS' OR vw_mdr_14.emsr_gestion_fixed IS NULL) AND NVL(vw_mdr_14.flg_surcharge,0)!=1 AND vw_mdr_14.criterio='VISA' THEN '0.25'/('1'-'0.35')
	WHEN (vw_mdr_14.emsr_gestion_fixed='EXTRANJERAS' OR vw_mdr_14.emsr_gestion_fixed IS NULL) AND NVL(vw_mdr_14.flg_surcharge,0)!=1 AND MCC NOT IN ('4900','9311','4814') AND vw_mdr_14.criterio='AMEX' THEN '0'
	WHEN (vw_mdr_14.emsr_gestion_fixed='EXTRANJERAS' OR vw_mdr_14.emsr_gestion_fixed IS NULL) AND NVL(vw_mdr_14.flg_surcharge,0)!=1 AND vw_mdr_14.criterio='MC' AND dsc_marca_fixed = 'Maestro' THEN ('0.2'+CASE WHEN modalidad != 'PRESENCIAL' THEN '0' ELSE '0' END)/('1'-'0.35')
	+ (CASE WHEN modalidad = 'NO PRESENCIAL' THEN LEAST((((mto_transaccion_sin_vuelto/val_dolar) * '0.00025') / ('1'-'0.35')) , ('3' / ('1'-'0.35'))) ELSE '0' END)
	WHEN (vw_mdr_14.emsr_gestion_fixed='EXTRANJERAS' OR vw_mdr_14.emsr_gestion_fixed IS NULL) AND NVL(vw_mdr_14.flg_surcharge,0)!=1 AND vw_mdr_14.criterio='MC' AND dsc_marca_fixed != 'Maestro' THEN 
	 (case
	when (case when ttx_cod_moneda_tr = 152 then mto_transaccion_sin_vuelto/val_dolar when ttx_cod_moneda_tr = 840 then mto_transaccion_sin_vuelto end) > '25' then ('0.14' + '0.14' + '0.0000034'+ CASE WHEN modalidad != 'PRESENCIAL' THEN '0' ELSE '0' END) / ('1' - '0.35')
		 + (CASE WHEN modalidad = 'NO PRESENCIAL' THEN LEAST((((mto_transaccion_sin_vuelto/val_dolar) * '0.00025') / ('1'-'0.35')) , ('3' / ('1'-'0.35'))) ELSE '0' END)
	when (case when ttx_cod_moneda_tr = 152 then mto_transaccion_sin_vuelto/val_dolar when ttx_cod_moneda_tr = 840 then mto_transaccion_sin_vuelto end) >= '5' then ('0.1' + '0.1' + '0.0000034'+ CASE WHEN modalidad != 'PRESENCIAL' THEN '0' ELSE '0' END) / ('1' - '0.35')
		 + (CASE WHEN modalidad = 'NO PRESENCIAL' THEN LEAST((((mto_transaccion_sin_vuelto/val_dolar) * '0.00025') / ('1'-'0.35')) , ('3' / ('1'-'0.35'))) ELSE '0' END)
	ELSE ('0.06' + '0.06' + '0.0000034' + CASE WHEN modalidad != 'PRESENCIAL' THEN '0' ELSE '0' END) / ('1' - '0.35')
		 + (CASE WHEN modalidad = 'NO PRESENCIAL' THEN LEAST((((mto_transaccion_sin_vuelto/val_dolar) * '0.00025') / ('1'-'0.35')) , ('3' / ('1'-'0.35'))) ELSE '0' END)
	end)
	ELSE NULL END AS switch_usd
	, CASE
	WHEN vw_mdr_14.criterio='AMEX' AND MCC IN ('4900','9311','4814') THEN '0'
	WHEN ((vw_mdr_14.emsr_gestion_fixed!='EXTRANJERAS' AND vw_mdr_14.emsr_gestion_fixed IS NOT NULL) OR NVL(vw_mdr_14.flg_surcharge,0)=1) AND vw_mdr_14.criterio='VISA' THEN '0.0075' / ('1'-'0.35')
	WHEN ((vw_mdr_14.emsr_gestion_fixed!='EXTRANJERAS' AND vw_mdr_14.emsr_gestion_fixed IS NOT NULL) OR NVL(vw_mdr_14.flg_surcharge,0)=1) AND MCC NOT IN ('4900','9311','4814') AND vw_mdr_14.criterio='AMEX' THEN '0'
	WHEN ((vw_mdr_14.emsr_gestion_fixed!='EXTRANJERAS' AND vw_mdr_14.emsr_gestion_fixed IS NOT NULL) OR NVL(vw_mdr_14.flg_surcharge,0)=1) AND vw_mdr_14.criterio='MC' AND dsc_marca_fixed!='Maestro' THEN -- '0.007128'/('1'-'0.35')
	 (case
	when (case when ttx_cod_moneda_tr = 152 then mto_transaccion_sin_vuelto/val_dolar when ttx_cod_moneda_tr = 840 then mto_transaccion_sin_vuelto end) >= '25.01' then ('0.032' + '0.0000034') / ('1' - '0.35')
		 + (CASE WHEN modalidad = 'NO PRESENCIAL' THEN LEAST((((mto_transaccion_sin_vuelto/val_dolar) * '0.00025') / ('1'-'0.35')) , ('3' / ('1'-'0.35'))) ELSE '0' END)
	when (case when ttx_cod_moneda_tr = 152 then mto_transaccion_sin_vuelto/val_dolar when ttx_cod_moneda_tr = 840 then mto_transaccion_sin_vuelto end) >= '10.01' then ('0.02' + '0.0000034') / ('1' - '0.35')
		 + (CASE WHEN modalidad = 'NO PRESENCIAL' THEN LEAST((((mto_transaccion_sin_vuelto/val_dolar) * '0.00025') / ('1'-'0.35')) , ('3' / ('1'-'0.35'))) ELSE '0' END)
	when (case when ttx_cod_moneda_tr = 152 then mto_transaccion_sin_vuelto/val_dolar when ttx_cod_moneda_tr = 840 then mto_transaccion_sin_vuelto end) >= '5.01' then ('0.0115' + '0.0000034') / ('1' - '0.35')
		 + (CASE WHEN modalidad = 'NO PRESENCIAL' THEN LEAST((((mto_transaccion_sin_vuelto/val_dolar) * '0.00025') / ('1'-'0.35')) , ('3' / ('1'-'0.35'))) ELSE '0' END)
	when (case when ttx_cod_moneda_tr = 152 then mto_transaccion_sin_vuelto/val_dolar when ttx_cod_moneda_tr = 840 then mto_transaccion_sin_vuelto end) >= '1.01' then ('0.00225' + '0.0000034') / ('1' - '0.35')
		 + (CASE WHEN modalidad = 'NO PRESENCIAL' THEN LEAST((((mto_transaccion_sin_vuelto/val_dolar) * '0.00025') / ('1'-'0.35')) , ('3' / ('1'-'0.35'))) ELSE '0' END)
	when (case when ttx_cod_moneda_tr = 152 then mto_transaccion_sin_vuelto/val_dolar when ttx_cod_moneda_tr = 840 then mto_transaccion_sin_vuelto end) >= '0' then ('0.0005' + '0.0000034') / ('1' - '0.35')
		+ (CASE WHEN modalidad = 'NO PRESENCIAL' THEN LEAST((((mto_transaccion_sin_vuelto/val_dolar) * '0.00025') / ('1'-'0.35')) , ('3' / ('1'-'0.35'))) ELSE '0' END)
	end)
	WHEN ((vw_mdr_14.emsr_gestion_fixed!='EXTRANJERAS' AND vw_mdr_14.emsr_gestion_fixed IS NOT NULL) OR NVL(vw_mdr_14.flg_surcharge,0)=1) AND vw_mdr_14.criterio='MC' AND dsc_marca_fixed='Maestro' THEN ('0.008' + '0.0007') / ('1'-'0.35')
		+ (CASE WHEN modalidad = 'NO PRESENCIAL' THEN LEAST((((mto_transaccion_sin_vuelto/val_dolar) * '0.00025') / ('1'-'0.35')) , ('3' / ('1'-'0.35'))) ELSE '0' END)
	WHEN (vw_mdr_14.emsr_gestion_fixed='EXTRANJERAS' OR vw_mdr_14.emsr_gestion_fixed IS NULL) AND NVL(vw_mdr_14.flg_surcharge,0)!=1 AND vw_mdr_14.criterio='VISA' THEN '0.25'/('1'-'0.35')
	WHEN (vw_mdr_14.emsr_gestion_fixed='EXTRANJERAS' OR vw_mdr_14.emsr_gestion_fixed IS NULL) AND NVL(vw_mdr_14.flg_surcharge,0)!=1 AND MCC NOT IN ('4900','9311','4814') AND vw_mdr_14.criterio='AMEX' THEN '0'
	WHEN (vw_mdr_14.emsr_gestion_fixed='EXTRANJERAS' OR vw_mdr_14.emsr_gestion_fixed IS NULL) AND NVL(vw_mdr_14.flg_surcharge,0)!=1 AND vw_mdr_14.criterio='MC' AND dsc_marca_fixed = 'Maestro' THEN ('0.2'+CASE WHEN modalidad != 'PRESENCIAL' THEN '0' ELSE '0' END)/('1'-'0.35')
		+ (CASE WHEN modalidad = 'NO PRESENCIAL' THEN LEAST((((mto_transaccion_sin_vuelto/val_dolar) * '0.00025') / ('1'-'0.35')) , ('3' / ('1'-'0.35'))) ELSE '0' END)
	WHEN (vw_mdr_14.emsr_gestion_fixed='EXTRANJERAS' OR vw_mdr_14.emsr_gestion_fixed IS NULL) AND NVL(vw_mdr_14.flg_surcharge,0)!=1 AND vw_mdr_14.criterio='MC' AND dsc_marca_fixed != 'Maestro' THEN 
	 (case
	when (case when ttx_cod_moneda_tr = 152 then mto_transaccion_sin_vuelto/val_dolar when ttx_cod_moneda_tr = 840 then mto_transaccion_sin_vuelto end) > '25' then ('0.14' + '0.14' + '0.0000034'+ CASE WHEN modalidad != 'PRESENCIAL' THEN '0' ELSE '0' END) / ('1' - '0.35')
		+ (CASE WHEN modalidad = 'NO PRESENCIAL' THEN LEAST((((mto_transaccion_sin_vuelto/val_dolar) * '0.00025') / ('1'-'0.35')) , ('3' / ('1'-'0.35'))) ELSE '0' END)
	when (case when ttx_cod_moneda_tr = 152 then mto_transaccion_sin_vuelto/val_dolar when ttx_cod_moneda_tr = 840 then mto_transaccion_sin_vuelto end) >= '5' then ('0.1' + '0.1' + '0.0000034'+ CASE WHEN modalidad != 'PRESENCIAL' THEN '0' ELSE '0' END) / ('1' - '0.35')
		+ (CASE WHEN modalidad = 'NO PRESENCIAL' THEN LEAST((((mto_transaccion_sin_vuelto/val_dolar) * '0.00025') / ('1'-'0.35')) , ('3' / ('1'-'0.35'))) ELSE '0' END)
	ELSE ('0.06' + '0.06' + '0.0000034' + CASE WHEN modalidad != 'PRESENCIAL' THEN '0' ELSE '0' END) / ('1' - '0.35')
		+ (CASE WHEN modalidad = 'NO PRESENCIAL' THEN LEAST((((mto_transaccion_sin_vuelto/val_dolar) * '0.00025') / ('1'-'0.35')) , ('3' / ('1'-'0.35'))) ELSE '0' END)
	end)
	else null END AS  switch_usd_promedio
	,CASE 
	WHEN vw_franquicia.grupo is not null then vw_franquicia.grupo
	WHEN vw_mdr_14.cod_rubro =501 OR vw_mdr_14.cod_rubro =509 OR vw_mdr_14.cod_rubro=521 then 'COPEC'
	ELSE vw_mdr_14.rut
	END AS grupo,
 CASE WHEN vw_mdr_14.rut IN ('76150312K',
								'770053293',
								'767637314',
								'770187656',
								'771019285',
								'770093279',
								'76516950K',
								'766931421',
								'76584147K',
								'774276513',
								'763897788',
								'767723792',
								'76804564K',
								'768139636',
								'767882823',
								'768300143',
								'995846608',
								'764166590',
								'774102159',
								'769237836',
								'762489236',
								'773677964',
								'760791814',
								'767976755',
								'764781112',
								'76123174K',
								'995607107',
								'767955618')
 THEN 1
ELSE 0
END AS psp
,0 AS flg_cap
, flg_cliente_especial
, CASE 
	WHEN vw_franquicia.grupo is not null then 1
	WHEN vw_mdr_14.cod_rubro =501 OR vw_mdr_14.cod_rubro =509 OR vw_mdr_14.cod_rubro=521 then 1
	else 0 end as flg_franquicia
FROM sdx_ti_mdr.vw_mdr_14_tp vw_mdr_14
LEFT JOIN sdx_ti_mdr.vw_franquicia on regexp_replace(vw_mdr_14.rut,"^0+","")=regexp_replace(vw_franquicia.rut,"^0+","") and regexp_replace(vw_mdr_14.cod_rubro,"^0+","")=regexp_replace(vw_franquicia.rubro,"^0+","")
--LEFT JOIN sdx_ti_mdr.grupos on regexp_replace(vw_mdr_14.rut,"^0+","")=regexp_replace(grupos.rut,"^0+","") 
WHERE medio_pago_pucon_fixed!=7 AND cod_rubro NOT IN (85,88,89) AND cod_rubro!=0 and ttx_tipo_contrato is not null and ttx_tipo_contrato!='null' and (cdg_tipo_transaccion=1 or (cdg_tipo_transaccion in (2,3,9) and nvl(mto_comision,0)!=0)) and bin!=111111
;
 

drop table sdx_ti_mdr.mdr_15_10_2022_tp;
create table sdx_ti_mdr.mdr_15_10_2022_tp
as select * from sdx_ti_mdr.vw_mdr_15_tp;