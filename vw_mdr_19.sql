CREATE or replace VIEW sdx_ti_mdr.vw_mdr_19_tp AS
select
	vw_mdr_18.grupo, 
	vw_mdr_18.mcc ,
	vw_mdr_18.medio_pago_marca ,
    vw_mdr_18.psp ,
	vw_mdr_18.grupo_negativo,
	count(1) as cnt_trx ,
    sum(CASE WHEN ttx_cod_moneda_tr=152 then mto_comision else mto_comision*val_dolar end)/sum(CASE WHEN ttx_cod_moneda_tr=152 then mto_transaccion_sin_vuelto else mto_transaccion_sin_vuelto*val_dolar end) tasa_estimada_comision,
    sum(vw_mdr_18.mto_transaccion_sin_vuelto_uf) as mto_transaccion_sin_vuelto_uf ,
    sum(vw_mdr_18.monto_tasa) as monto_tasa_intercambio_uf ,
    sum(vw_mdr_18.membresia_uf) as monto_membresia_uf ,
    sum(vw_mdr_18.switch_uf_promedio) as monto_switch_uf ,
	sum(vw_mdr_18.membresia_uf_nacional) as monto_membresia_uf_nacional ,
    sum(vw_mdr_18.switch_uf_promedio_nacional_3p) as switch_uf_nacional_3p ,
    sum(vw_mdr_18.membresia_uf_nacional_redcompra) membresia_uf_nacional_redcompra,
    sum(vw_mdr_18.monto_ma_ajustado) as monto_ma_uf ,
    sum(vw_mdr_18.membresia_uf) + sum(vw_mdr_18.switch_uf_promedio) + sum(vw_mdr_18.monto_tasa) + sum(vw_mdr_18.monto_ma_ajustado) as monto_mdr_real_uf ,
    round((sum(vw_mdr_18.membresia_uf) + sum(vw_mdr_18.switch_uf_promedio) + sum(vw_mdr_18.monto_tasa) + sum(vw_mdr_18.monto_ma_ajustado))/ sum(vw_mdr_18.mto_transaccion_sin_vuelto_uf),
    4) as tasa_mdr_real,
	round((sum(vw_mdr_18.membresia_uf) + sum(vw_mdr_18.switch_uf_promedio) + sum(vw_mdr_18.monto_tasa) + sum(vw_mdr_18.monto_ma_ajustado)-nvl(sum(vw_mdr_18.switch_uf_promedio_nacional_3p),0)-nvl(sum(vw_mdr_18.membresia_uf_nacional_redcompra),0))/ sum(vw_mdr_18.mto_transaccion_sin_vuelto_uf),
    4) as tasa_mdr_real_sin_costo_marca,
	(sum(vw_mdr_18.membresia_uf) + sum(vw_mdr_18.switch_uf_promedio) + sum(vw_mdr_18.monto_tasa) + sum(vw_mdr_18.monto_ma_ajustado)-nvl(sum(vw_mdr_18.switch_uf_promedio_nacional_3p),0)-nvl(sum(vw_mdr_18.membresia_uf_nacional_redcompra),0))/ sum(vw_mdr_18.mto_transaccion_sin_vuelto_uf) as tasa_mdr_real_no_redondeada,
	flg_mc
from
    sdx_ti_mdr.proceso_202210_tp vw_mdr_18
	where vw_mdr_18.flg_franquicia = 1
group by
    vw_mdr_18.grupo, 
	vw_mdr_18.mcc ,
	vw_mdr_18.medio_pago_marca ,
    vw_mdr_18.psp,
	vw_mdr_18.grupo_negativo,
	flg_mc
;