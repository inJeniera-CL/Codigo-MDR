CREATE OR REPLACE VIEW sdx_ti_mdr.vw_mdr_01_tp AS
with tmp_uf as
(
select
      tp.valor as valor_uf
    , tp.fecha as fecha_uf
from
    sdx_ti_mdr.tipo_cambio_oct_2022 tp
where tp.codigo_moneda = '12'
)
, tmp_dolar as
(
    select
          tp.valor as valor_dolar
        , tp.fecha as fecha_dolar
from
    sdx_ti_mdr.tipo_cambio_oct_2022 tp
where tp.codigo_moneda = '07'
)
SELECT id_proceso
	, tms_ingesta
	, tms_extraccion_fuente
	, lnin_sec
	, fch_transaccion
	, sid_tx_secuencia
	, cdg_comercio
	, mto_transaccion
	, mto_comision
	, mto_vuelto
	, num_bin_ext
	, cdg_producto_canal_contratado
	, cdg_tipo_transaccion
	, cdg_medio_pago
	, ttx_cod_moneda_tr cdg_moneda_iso
	, fch_procesamiento
	, fch_cambio_uf
	, fch_cambio_dolar
	, num_periodo_gestion
	, valor_uf as val_uf
	, valor_dolar as val_dolar
	, case 
		when ttx_cod_moneda_tr = '152' 
			then  mto_transaccion_clp
			else cast(mto_transaccion_usd * valor_dolar as DOUBLE)
		end as mto_transaccion_clp
	, case 
		when ttx_cod_moneda_tr = '152' 
			then  cast(mto_transaccion_clp / valor_uf as double)
			else cast((mto_transaccion_usd * valor_dolar) / valor_uf as double)
		end as mto_transaccion_uf
	, case 
		when ttx_cod_moneda_tr = '152' 
			then cast(mto_transaccion_clp / valor_dolar as double)
			else mto_transaccion_usd 
		end as mto_transaccion_usd
	, case 
		when ttx_cod_moneda_tr = '152' 
			then cast(mto_comision / valor_uf as double)
			else cast((mto_comision_usd * valor_dolar) / valor_uf as double)
		end as mto_comision_uf
	, case 
		when ttx_cod_moneda_tr = '152' 
			then cast(mto_vuelto / valor_uf as double)
			else cast((mto_comision_usd * valor_dolar) / valor_uf as double)
		end as mto_vuelto_uf
	, ttx_tipo_flujo
	, cast(id_rubro_tbk as int) ttx_cod_rubro
	, ttx_cod_moneda_tr
	, ttx_monto_orig
	, ttx_fecha
	, ttx_tipo_tx
	, ttx_tipo_tran
	, ttx_nac_o_ext
	, ttx_marca_bin
	, ttx_tipo_contrato
	, ttx_tipo_tarjeta
	, ttx_medio_pago
	, ttx_emisor
	, ttx_iva_comision
	, lnin_sec_ant
	, identificador_producto
	, partition_year
	, partition_month
	, partition_day
	, nvl(flg_surcharge, 0) as flg_surcharge
	, cod_mod_ti
FROM sdx_ti_mdr.transaccion_procesada_oct_2022
left join tmp_uf on
	concat(partition_year,'-', partition_month, '-', partition_day) = fecha_uf
left join tmp_dolar on
	concat(partition_year,'-', partition_month, '-', partition_day) = fecha_dolar
where cdg_tipo_transaccion in (1,2,3,9);