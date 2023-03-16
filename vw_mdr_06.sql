CREATE OR REPLACE VIEW sdx_ti_mdr.vw_mdr_06_tp AS 
SELECT
	 vw_mdr_05.id_proceso
	, vw_mdr_05.tms_ingesta
	, vw_mdr_05.tms_extraccion_fuente
	, vw_mdr_05.lnin_sec
	, vw_mdr_05.fch_transaccion
	, vw_mdr_05.sid_tx_secuencia
	, vw_mdr_05.cdg_comercio
	, vw_mdr_05.mto_transaccion
	, vw_mdr_05.mto_comision
	, vw_mdr_05.mto_vuelto
	, vw_mdr_05.num_bin_ext
	, vw_mdr_05.cdg_producto_canal_contratado
	, vw_mdr_05.cdg_tipo_transaccion
	, vw_mdr_05.cdg_medio_pago
	, vw_mdr_05.ttx_cod_moneda_tr cdg_moneda_iso
	, vw_mdr_05.fch_procesamiento
	, vw_mdr_05.fch_cambio_uf
	, vw_mdr_05.fch_cambio_dolar
	, vw_mdr_05.num_periodo_gestion
	, vw_mdr_05.val_uf
	, vw_mdr_05.val_dolar
	, vw_mdr_05.mto_transaccion_clp
	, vw_mdr_05.mto_transaccion_uf
	, vw_mdr_05.mto_transaccion_usd
	, vw_mdr_05.mto_comision_uf
	, vw_mdr_05.mto_vuelto_uf
	, vw_mdr_05.ttx_tipo_flujo
	, vw_mdr_05.ttx_cod_rubro
	, vw_mdr_05.ttx_cod_moneda_tr
	, vw_mdr_05.ttx_monto_orig
	, vw_mdr_05.ttx_fecha
	, vw_mdr_05.ttx_tipo_tx
	, vw_mdr_05.ttx_tipo_tran
	, vw_mdr_05.ttx_nac_o_ext
	, vw_mdr_05.ttx_marca_bin
	, vw_mdr_05.ttx_tipo_contrato
	, vw_mdr_05.ttx_tipo_tarjeta
	, vw_mdr_05.ttx_medio_pago
	, vw_mdr_05.ttx_emisor
	, vw_mdr_05.ttx_iva_comision
	, vw_mdr_05.lnin_sec_ant
	, vw_mdr_05.identificador_producto
	, vw_mdr_05.partition_year
	, vw_mdr_05.partition_month
	, vw_mdr_05.partition_day
	, vw_mdr_05.flg_surcharge
	, vw_mdr_05.cod_mod_ti
	, mto_transaccion_sin_vuelto
	, mto_transaccion_sin_vuelto_uf
	, cod_cred
	, count_trx
	, vw_mdr_05.rut
	, vw_mdr_05.tipo_conexion
	, vw_mdr_05.cod_rubro
	, vw_mdr_05.emisor_fixed
	, vw_mdr_05.bin
	, vw_mdr_05.medio_pago_pucon
	, vw_mdr_05.marca_fixed
	, vw_mdr_05.emsr_gestion_fixed
	, vw_mdr_05.dsc_marca
	, vw_mdr_05.medio_pago_pucon_fixed
	, vw_mdr_05.modalidad
	, CASE 
		WHEN vw_mdr_05.bin IN ('590101', '621996', '590102', '491098', '639229', '603142', '503441', '505780', '590202') THEN 'Redcompra'
		WHEN vw_mdr_05.bin IN ('377827', '377829', '377828', '377825', '377826', '376645') THEN 'Amex'
		WHEN vw_mdr_05.bin IN ('589738', '589691', '589710', '589693', '502976', '589688') THEN 'Maestro'
		WHEN vw_mdr_05.bin IN ('520079', '552300', '552595', '552665', '553405', '554940', '556083', '545646', '541944'
		  															  , '552813', '519741', '552635', '548569', '518850', '549451', '515658', '558727', '553656'
		  															  , '525731', '546039', '543563', '548480', '530250', '543565', '540491', '552561', '519716'
		  															  , '520387', '533225', '549162', '521892', '540477', '547369', '515547', '542412', '544630'
		  															  , '547184', '549289', '557806', '559045', '559542', '544568', '549070', '529885', '529881'
		  															  , '529883', '521408', '544623', '544916', '545415', '547196', '543696', '540937', '547551'
		  															  , '552252', '554904', '559800', '515460', '521312', '533013', '545196', '554610', '558347'
		  															  , '559801', '554926', '552559', '518532', '541678', '542663', '540523', '557861', '518472'
		  															  , '518497', '518536', '558984', '512269', '548740', '522468', '548742', '543564', '540476'
		  															  , '540782', '548652', '548653', '549163', '534129', '522832', '546689', '558685', '558840'
		  															  , '559202', '559205', '559207', '544938', '222690', '517980', '535851', '542714', '531663'
		  															  , '552273', '531216', '539032', '544088', '545153', '523250', '518286') THEN 'Master Card'
		   WHEN vw_mdr_05.bin IN ('508113', '559779', '533187', '524101', '524241', '525384', '531596', '542676') THEN 'MasterDebit'
		   WHEN vw_mdr_05.bin IN ('538759', '555912', '522416', '517608', '531926') THEN 'MasterDebit'
		   WHEN vw_mdr_05.bin IN ('485029', '456918', '442679', '467498', '493857', '450802', '410530', '476026', '450882'
		  															  , '446511', '493858', '421917', '493859', '450883', '490225', '426040', '489472', '421401'
		  															  , '496672', '423925', '450838', '435767', '450880', '406496', '435718', '410886', '415280'
		  															  , '496671', '485722', '442174', '415281', '450881', '457615', '478688', '449595', '417760'
		  															  , '419189', '476832', '456477', '456460', '456473', '438084', '445596', '467024', '467025'
		  															  , '479595', '480048', '404028', '460072', '499847', '465375', '409152', '415282', '415283'
		  															  , '450878', '469772', '476025', '492210', '496670', '498811', '422766', '434956', '446867'
		  															  , '448480', '459311', '475776', '480293', '480916', '480917', '489070', '425947', '463307'
		  															  , '409320', '423471', '451248', '424525', '425944', '424419', '403351', '414756', '454812'
		  															  , '496617', '448165', '422038', '448542', '450600', '454851', '454886', '496660', '480015'
		  															  , '416589', '456931', '494611') THEN 'Visa'
		   WHEN vw_mdr_05.bin IN ('493807', '467015', '491523', '498432', '401082') THEN 'Visa'
		   WHEN vw_mdr_05.bin IN ('462956', '402366', '402365', '451134', '440698', '409767', '421413', '434503'
								, '434561', '434560', '434559', '429954', '430271', '456865', '475775', '475777'
		  															  , '477041', '475774', '450638', '463306', '421767', '475778', '420861', '420862', '409674'
		  															  , '425943', '451368', '452427', '489644', '440612') THEN 'Visa Debito'
		   WHEN vw_mdr_05.bin IN ('412003') THEN 'Visa Debito'	
		   WHEN vw_mdr_05.bin='568009' THEN 'Magna'
		   WHEN vw_mdr_05.medio_pago_pucon_fixed=4 AND vw_mdr_05.dsc_marca IN ('Amex','Amex Cargo') THEN 'Amex'
		   WHEN vw_mdr_05.bin IN ('589701') THEN 'Redcompra'
		   WHEN vw_mdr_05.identificador_producto IN ('MDI', 'MDN', 'MPD', 'MPI') THEN 'MasterDebit'
		   WHEN vw_mdr_05.identificador_producto = 'VDN' THEN 'Visa Debito'
	  ELSE vw_mdr_05.dsc_marca END AS dsc_marca_fixed
FROM sdx_ti_mdr.vw_mdr_05_tp vw_mdr_05;