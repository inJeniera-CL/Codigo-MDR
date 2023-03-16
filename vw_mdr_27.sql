create or replace view sdx_ti_mdr.vw_mdr_27_tp as 
with ANIO_AJUSTE as (select parametro ANIO_AJUSTE from sdx_ti_mdr.parametros_ajuste where nombre_parametro='ANIO_AJUSTE'),
MES_AJUSTE as (select parametro MES_AJUSTE from sdx_ti_mdr.parametros_ajuste where nombre_parametro='MES_AJUSTE')
SELECT Rut AS RUT_ORGANIZACION
	,cod_cred AS CODIGO_COMERCIO
	,CASE 
		WHEN Medio_pago_pucon_fixed = '4'
			THEN 'Crédito'
		WHEN Medio_pago_pucon_fixed = '5'
			THEN 'Débito'
		WHEN Medio_pago_pucon_fixed = '6'
			THEN 'Prepago'
		END AS MEDIO_PAGO
	,'Detalle' AS TIPO_REGISTRO
	, MES_AJUSTE.MES_AJUSTE AS MES
	,ANIO_AJUSTE.ANIO_AJUSTE AS ANIO
	,CASE 
		WHEN ttx_cod_moneda_tr = '152' THEN mto_transaccion_sin_vuelto
		WHEN ttx_cod_moneda_tr = '840' THEN round(mto_transaccion_sin_vuelto * val_dolar,0)
	 END AS VENTA
	, null AS TASA_ESTIMADA
	, CASE 
		WHEN ttx_cod_moneda_tr = '152' THEN
			mto_comision + ttx_iva_comision 		    
		WHEN ttx_cod_moneda_tr = '840' THEN
			round(mto_comision* val_dolar,0)+round(ttx_iva_comision* val_dolar,0)
	  end as COMISION_BRUTA_ESTIMADA
	, CASE 
		WHEN ttx_cod_moneda_tr = '152' THEN	mto_comision
		WHEN ttx_cod_moneda_tr = '840' THEN	round(mto_comision * val_dolar,0)
	  end as COMISION_NETA_ESTIMADA
	, CASE 
		WHEN ttx_cod_moneda_tr = '152' THEN ttx_iva_comision 
		WHEN ttx_cod_moneda_tr = '840' THEN	round(ttx_iva_comision * val_dolar,0) 
	  end as IVA_COMISION_ESTIMADA
	, null AS TASA_REAL
	, CASE WHEN flg_franquicia=1 THEN	
		CASE 
			WHEN ttx_cod_moneda_tr = '152' THEN round(tasa_mdr_real * mto_transaccion_sin_vuelto,0) +round(round(tasa_mdr_real * mto_transaccion_sin_vuelto,0)*'0.19',0) 	
			ELSE round(tasa_mdr_real * mto_transaccion_sin_vuelto* val_dolar,0) +round(round(tasa_mdr_real * mto_transaccion_sin_vuelto* val_dolar,0)*'0.19',0) END
	ELSE 
		round((NVL(monto_ma_ajustado,0) + nvl(switch_uf,0) + nvl(membresia_uf,0) - nvl(membresia_uf_nacional_redcompra,0) - nvl(switch_uf_nacional_3p,0) + nvl(monto_tasa,0) )* val_uf,0) +
		round(round((NVL(monto_ma_ajustado,0) + nvl(switch_uf,0) + nvl(membresia_uf,0) - nvl(membresia_uf_nacional_redcompra,0) - nvl(switch_uf_nacional_3p,0) + nvl(monto_tasa,0) )* val_uf,0)*'0.19',0)
	END AS COMISION_BRUTA_REAL
	, CASE WHEN flg_franquicia=1 THEN	
		CASE 
			WHEN ttx_cod_moneda_tr = '152' THEN round(tasa_mdr_real * mto_transaccion_sin_vuelto,0)  	
			ELSE round(tasa_mdr_real * mto_transaccion_sin_vuelto* val_dolar,0)  END
	ELSE 
		round((NVL(monto_ma_ajustado,0) + nvl(switch_uf,0) + nvl(membresia_uf,0) - nvl(membresia_uf_nacional_redcompra,0) - nvl(switch_uf_nacional_3p,0) + nvl(monto_tasa,0) )* val_uf,0)
	END AS COMISION_NETA_REAL
	, CASE WHEN flg_franquicia=1 THEN	
		CASE 
			WHEN ttx_cod_moneda_tr = '152' THEN round(round(tasa_mdr_real * mto_transaccion_sin_vuelto,0)*'0.19',0) 	
			ELSE round(round(tasa_mdr_real * mto_transaccion_sin_vuelto* val_dolar,0)*'0.19',0) END
	ELSE 
		round(round((NVL(monto_ma_ajustado,0) + nvl(switch_uf,0) + nvl(membresia_uf,0) - nvl(membresia_uf_nacional_redcompra,0) - nvl(switch_uf_nacional_3p,0) + nvl(monto_tasa,0) )* val_uf,0)*'0.19',0)	
	END AS IVA_COMISION_REAL
	, cobrador
	, cod_mod_ti
	, sid_tx_secuencia
	, partition_year
	, partition_month
	, partition_day
	, psp
	, monto_ma_ajustado * val_uf  as mto_margen_adquirente
	,(nvl(switch_uf,0) + nvl(membresia_uf,0) - nvl(membresia_uf_nacional_redcompra,0) - nvl(switch_uf_nacional_3p,0)) * val_uf as mto_costo_marca
	, nvl(monto_tasa,0) * val_uf as mto_tasa_intercambio
	, round((NVL(monto_ma_ajustado,0) + nvl(switch_uf,0) + nvl(membresia_uf,0) - nvl(membresia_uf_nacional_redcompra,0) - nvl(switch_uf_nacional_3p,0) + nvl(monto_tasa,0) )* val_uf,0) as mto_mdr
	, 100*(round((NVL(monto_ma_ajustado,0) + nvl(switch_uf,0) + nvl(membresia_uf,0) - nvl(membresia_uf_nacional_redcompra,0) - nvl(switch_uf_nacional_3p,0) + nvl(monto_tasa,0) )* val_uf,0) / (CASE 
		WHEN ttx_cod_moneda_tr = '152' THEN mto_transaccion_sin_vuelto
		WHEN ttx_cod_moneda_tr = '840' THEN round(mto_transaccion_sin_vuelto * val_dolar,0)
	 END)) as prc_mdr
	,CASE
    WHEN cdg_tipo_transaccion = 1 then "VENTA"
     ELSE "ANULACION"
END AS tipo_transaccion,
fch_transaccion,
dsc_marca_fixed_informe as marca,
ti_product as categoria,
modalidad as canal,
CASE
    WHEN emsr_gestion_fixed = "EXTRANJERAS" THEN "INTERNACIONAL"
    ELSE "NACIONAL"
END AS origen,
cod_rubro,
mcc
FROM sdx_ti_mdr.ajuste_octubre_2022_4_tp vw_mdr_26, ANIO_AJUSTE, MES_AJUSTE
WHERE 
cobrador=0 
AND flg_ka=0
AND grupo_negativo=0
and (tasa_mes!=0 or psp = 1)
and cod_rubro not in ('501','509')
AND
vw_mdr_26.cod_cred not in (
'42344856',
'32976883',
'33414080',
'33438222'
);

drop table sdx_ti_mdr.ajuste_octubre_2022_5_tp;
create table sdx_ti_mdr.ajuste_octubre_2022_5_tp
as select * from sdx_ti_mdr.vw_mdr_27_tp;