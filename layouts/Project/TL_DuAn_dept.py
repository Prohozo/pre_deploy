import dash
import dash_core_components as dcc
import dash_html_components as html
from dash.dependencies import Input, Output, State 
from app import app_DuAn
from static.system_dashboard.css import css_define as css
from utils import GParams_PJ_Multile, Graph
from DB import DB_DuAn
import pandas as pd
# import datetime

def gen_layout():
    layout = html.Div([
                    html.Div([
                        dcc.Graph(id='grh_TL_DA_dept',style={'width':'100%','height':'100%'})
                    ],className='au-card',style={'width':'100%','height':'100%'})
                ],className='col-lg-8 col-md-6 col-xs-12 m-b-15 graph_kt') 

    return layout

@app_DuAn.callback(
    Output("grh_TL_DA_dept", "figure"),
    [Input('ddl_name', 'value'),
     Input('ddl_dept', 'value'),
     Input('filter_date', 'start_date'),
     Input('filter_date', 'end_date'),
     Input('grh_status_duan_tron', 'clickData'),
     Input('grh_action_TG_month', 'selectedData'),
     Input('grh_action_TG_day', 'selectedData'),
     Input('grh_action_TG_year', 'selectedData'),
     Input('SoDuAn_dept', 'active_cell'),
     Input('detail_chitiet_duan', 'active_cell'),
     Input('detail_chitiet_trangthai', 'active_cell'),
     Input('detail_tiendo_duan', 'active_cell')],
    [State("SoDuAn_dept", "data"),
     State("detail_chitiet_duan", "data"),
     State("detail_chitiet_trangthai", "data"),
     State("detail_tiendo_duan", "data"),
    ]

)

def update_TL_DA_dept(name, dept, start_act,end_act, status_DA, action_TG_month, action_TG_day, action_TG_year, AC_DA_dept, AC_chitiet,AC_chitiet_tt, AC_td, DT_DA_dept, DT_chitiet, DT_chitiet_tt, DT_td):
    ctx = dash.callback_context
    data_in_dt = {'SoDuAn_dept': DT_DA_dept,
                  'detail_chitiet_duan': DT_chitiet,
                  'detail_chitiet_trangthai': DT_chitiet_tt,
                  'detail_tiendo_duan': DT_td,}
    label, value = GParams_PJ_Multile.Get_Value(ctx, data_in_dt)
    if label in ('action_month', 'action_day', 'action_year'):
        label = label.split('_')[0]

    if start_act is None or end_act is None:
        start_act, end_act = None, None 
    df = DB_DuAn.GET_TL_DA_dept((name, dept, start_act, end_act, label, value))
    return Graph.grh_BarChart(df['TiLe'],df['dept'],text=df['text_tile'],margin=[50,50,30,30],title=f'TỶ LỆ DỰ ÁN THEO TỪNG BỘ PHẬN ',marker_color=['color','#72A8FC'])
