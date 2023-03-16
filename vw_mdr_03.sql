CREATE OR REPLACE VIEW sdx_ti_mdr.vw_mdr_03_tp AS 
SELECT vw_mdr_02.id_proceso
	, vw_mdr_02.tms_ingesta
	, vw_mdr_02.tms_extraccion_fuente
	, vw_mdr_02.lnin_sec
	, vw_mdr_02.fch_transaccion
	, vw_mdr_02.sid_tx_secuencia
	, vw_mdr_02.cdg_comercio
	, vw_mdr_02.mto_transaccion
	, vw_mdr_02.mto_comision
	, vw_mdr_02.mto_vuelto
	, vw_mdr_02.num_bin_ext
	, vw_mdr_02.cdg_producto_canal_contratado
	, vw_mdr_02.cdg_tipo_transaccion
	, vw_mdr_02.cdg_medio_pago
	, vw_mdr_02.ttx_cod_moneda_tr cdg_moneda_iso
	, vw_mdr_02.fch_procesamiento
	, vw_mdr_02.fch_cambio_uf
	, vw_mdr_02.fch_cambio_dolar
	, vw_mdr_02.num_periodo_gestion
	, vw_mdr_02.val_uf
	, vw_mdr_02.val_dolar
	, vw_mdr_02.mto_transaccion_clp
	, vw_mdr_02.mto_transaccion_uf
	, vw_mdr_02.mto_transaccion_usd
	, vw_mdr_02.mto_comision_uf
	, vw_mdr_02.mto_vuelto_uf
	, vw_mdr_02.ttx_tipo_flujo
	, vw_mdr_02.ttx_cod_rubro
	, vw_mdr_02.ttx_cod_moneda_tr
	, vw_mdr_02.ttx_monto_orig
	, vw_mdr_02.ttx_fecha
	, vw_mdr_02.ttx_tipo_tx
	, vw_mdr_02.ttx_tipo_tran
	, vw_mdr_02.ttx_nac_o_ext
	, vw_mdr_02.ttx_marca_bin
	, vw_mdr_02.ttx_tipo_contrato
	, vw_mdr_02.ttx_tipo_tarjeta
	, vw_mdr_02.ttx_medio_pago
	, vw_mdr_02.ttx_emisor
	, vw_mdr_02.ttx_iva_comision
	, vw_mdr_02.lnin_sec_ant
	, vw_mdr_02.identificador_producto
	, vw_mdr_02.partition_year
	, vw_mdr_02.partition_month
	, vw_mdr_02.partition_day
	, vw_mdr_02.flg_surcharge
	, vw_mdr_02.cod_mod_ti
	, mto_transaccion_sin_vuelto
	, mto_transaccion_sin_vuelto_uf
	, cod_cred
	, count_trx
	, vw_mdr_02.rut
	, vw_mdr_02.tipo_conexion
	, CASE WHEN vw_mdr_02.cod_rubro IS NULL THEN 0 ELSE vw_mdr_02.cod_rubro END AS cod_rubro
    , vw_mdr_02.emisor_fixed
    , vw_mdr_02.bin
    , vw_mdr_02.medio_pago_pucon
    , vw_mdr_02.marca_fixed
    , CASE 
	  WHEN vw_mdr_02.bin in ('543563', '548480', '543565', '530250', '540491', '552561', '519716', '520387', '533225', '549162', '521892', '540477',
							 '525731', '546039', '589691', '589710', '538759', '559779', '450880', '494614', '377828', '377825', '377826', '376645',
							 '547369', '406496', '435718', '410886', '415280', '496671', '485722', '442174', '415281', '377827', '377829',	'515547',
							 '542412', '544630', '549289', '557806', '559045', '559542', '450881', '547184', '440612', '377937', '538765') THEN 'SANTANDER'
	  WHEN vw_mdr_02.bin IN ('416589','489644','505780') THEN 'BANCO CONSORCIO'
	  WHEN vw_mdr_02.bin IN ('438084') THEN 'CONSORCIO'
	  WHEN vw_mdr_02.bin IN ('544568', '549070') THEN 'RIPLEY-MASTER'
	  WHEN vw_mdr_02.bin IN ('517608') THEN 'TENPO'
      WHEN vw_mdr_02.bin IN ('412003', '422038', '448542', '450600', '454851', '454886', '496660', '480015', '222690', '517980', '535851', '542714', '531663', '552273', '451368', '521419', '545668', '553200', '498432',
							 '424419', '403351', '414756', '454812', '496617', '448165', '491523') THEN 'BCI'
      WHEN vw_mdr_02.bin IN ('524101', '531926', '518472', '518497', '518536', '503441', '524241') THEN 'COOPEUCH'
      WHEN vw_mdr_02.bin IN ('410027', '478688') THEN 'LA POLAR'
      WHEN vw_mdr_02.bin IN ('522416') THEN 'LOS ANDES'
      WHEN vw_mdr_02.bin IN ('555912') THEN 'LOS HEROES'
	  WHEN vw_mdr_02.bin IN ('489070', '559202', '559205', '559207') THEN 'CAT'
	  WHEN vw_mdr_02.bin IN ('531216', '539032', '544088', '545153', '589688', '510419') THEN 'BANCO INTERNACIONAL'
	  WHEN vw_mdr_02.bin IN ('449595', '417760', '419189', '589693', '543696', '540937', '547551', '552252', '554904', '559800','521312','533013','545196','554610','558347','559801', '521408', '544623', '544916','545415', '547196', '515460', '590102', '491098') THEN 'BANCO ITAU'
	  WHEN vw_mdr_02.bin IN ('520079', '552300', '552595', '552665', '553405', '554940', '556083', '589738') THEN 'SECURITY'
	  WHEN vw_mdr_02.bin IN ('445596', '467024', '467025', '479595', '480048', '404028', '460072', '499847', '465375', '409152') THEN 'CMR-VISA'
	  WHEN vw_mdr_02.bin IN ('558984', '512269', '548740', '522468', '548742') THEN 'CMR-MASTER'
	  WHEN vw_mdr_02.bin IN ('409767', '421413', '434503', '533187', '603142', '542676') THEN 'FALABELLA'
	  WHEN vw_mdr_02.bin IN ('529885', '529881', '529883') THEN 'PRESTO MASTERCARD'
	  WHEN vw_mdr_02.bin IN ('462956', '402366', '402365', '451134', '440698' , '442679', '467498', '493857', '450802', '410530', '476026', '450882', '446511', '493858', '421917'
	  						 , '493859', '450883', '490225', '426040', '489472', '421401', '545646', '541944', '552813', '519741', '552635', '496672', '423925', '450838', '435767', '548569', '518850', '549451', '515658', '558727'
	  						 , '553656', '590101') THEN 'SCOTIABANK'
	  WHEN vw_mdr_02.bin IN ('525384', '531596','544938', '639229', '234061') THEN 'BANCO RIPLEY'
	  WHEN vw_mdr_02.bin IN ('421767','463306','450638','475778', '420861', '409674', '420862', '425943', '425947', '463307', '409320', '423471', '451248', '424525', '425944', '590202') THEN 'BICE'
	  WHEN vw_mdr_02.bin IN ('456865', '422766', '475775', '475777', '477041', '475774', '434956', '446867', '448480', '459311', '475776'
	  					     , '480293', '480916', '480917', '540476', '540782', '548652', '548653', '549163', '534129', '522832', '546689', '558685', '558840'
	  						 , '508113', '589701', '415282', '415283', '543564', '450878', '469772', '476025', '492210', '496670', '498811', '493807', '467015', '412002', '423484', '518370') THEN 'CHILE'
	  WHEN vw_mdr_02.bin IN ('434561', '552559', '518532', '541678', '542663', '434560', '554926', '476832', '540523', '434559', '621996', '456477', '456460', '456473') THEN 'ESTADO'
	  WHEN vw_mdr_02.bin IN ('457615') THEN 'SALCOBRAND'
	  WHEN vw_mdr_02.bin IN ('502976', '496624') THEN 'CORPBANCA'
	  WHEN vw_mdr_02.bin IN ('557861') THEN 'CORONA'
	  WHEN vw_mdr_02.bin IN ('429954', '430271') THEN 'CITIBANK'
	  WHEN vw_mdr_02.bin IN ('568009') THEN 'BANEFE'
	  WHEN vw_mdr_02.bin IN ('452427') THEN 'BANCONDELL'
	  WHEN vw_mdr_02.bin IN ('456931', '494611') THEN 'CITIBANK'
	  WHEN vw_mdr_02.bin IN ('401082', '555505') THEN 'CRUZ VERDE'
	  WHEN vw_mdr_02.bin IN ('523250', '518286') THEN 'U-PAY'
	  WHEN vw_mdr_02.bin IN ('456918', '485029') THEN 'TRICOT'
	  WHEN vw_mdr_02.bin IN ('412669') THEN 'UNICARD S.A.'
	  WHEN substr(vw_mdr_02.num_bin_ext, 0, 9) = '408183000' THEN 'SALCOBRAND'
	  WHEN substr(vw_mdr_02.num_bin_ext, 0, 7) = '4670160'   THEN 'BANCO BICE'
	  WHEN substr(vw_mdr_02.num_bin_ext, 0, 7) = '4670170'   THEN 'BANCO ITAU'
	  WHEN substr(vw_mdr_02.num_bin_ext, 0, 8) in ('54473477', '51546404', '51549121', '51549347', '51553211', '52092875', '44846801', '53500404', '54283609', '54549439', '52483155')   THEN 'CHILE'
	  WHEN substr(vw_mdr_02.num_bin_ext, 0, 9) in ('477568712', '498468041', '408138444') THEN 'CHILE'
	  WHEN substr(vw_mdr_02.num_bin_ext, 0, 8) in ('55302679', '52143541', '51551343', '52625548', '54435387')  THEN 'SANTANDER'
	  WHEN substr(vw_mdr_02.num_bin_ext, 0, 8) in ('54563041', '54718849', '54806500', '55453970') THEN 'BANCO ITAU'
	  WHEN substr(vw_mdr_02.num_bin_ext, 0, 8) in ('46740400', '46740401', '46740500', '47959603', '47959605', '47959606', '47959612', '47959613', '47959622', '47959623', '53536555') THEN 'DOMESTICO NACIONAL'
	  WHEN substr(vw_mdr_02.num_bin_ext, 0, 9) in ('467404020', '467404021', '467404022', '467404023', '467404024', '467404025', '467404026', '467404027', '467404028'
	  										   , '467404029', '467404030', '467404031', '467404032', '467404033', '467404034', '467404035', '467404036', '467404037'
	  										   , '467404038', '467405010', '467405011', '467405012', '467405013', '467405014', '467405015', '467405016', '467405017'
	  										   , '467405018', '467405019', '467405020', '479596024', '479596025', '479596026', '479596027', '479596028', '479596029'
	  										   , '479596040', '479596041', '479596042', '479596043', '479596044', '479596045', '479596046', '479596047', '479596048'
	  										   , '479596049', '479596070', '479596071', '479596140', '479596141', '479596142', '479596143', '479596216', '479596217'
	  										   , '479596218', '479596219', '479596240', '479596241', '479596242', '479596243', '479596244', '479596245', '479596246'
	  										   , '479596247', '479596248', '479596249', '479596250', '479596251', '479596252', '491728632', '491728633', '491728634'
	  										   , '491728635', '491728636', '491728637', '491728638', '491728639') THEN 'DOMESTICO NACIONAL'
WHEN bin_flg_dom.num_bin_ext is not null THEN 'DOMESTICO NACIONAL'
ELSE instituciones_emisoras.emsr_gestion
END AS emsr_gestion_fixed
, marca.dsc_marca
FROM
sdx_ti_mdr.vw_mdr_02_tp vw_mdr_02
left join
sdx_ti_mdr.marca 
on marca.id_marca = vw_mdr_02.marca_fixed
left join 
sdx_ti_mdr.instituciones_emisoras
on 
vw_mdr_02.emisor_fixed = instituciones_emisoras.emsr_cod
left join
sdx_ti_mdr.bines_10_2022_flg_domestico as bin_flg_dom
on vw_mdr_02.num_bin_ext = bin_flg_dom.num_bin_ext;