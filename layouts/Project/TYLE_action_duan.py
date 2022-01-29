import dash
import dash_core_components as dcc
import dash_html_components as html
from dash.dependencies import Input, Output, State
from app import app_DuAn
from static.system_dashboard.css import css_define as css
from utils import GParams_PJ, Graph
from DB import DB_DuAn
import pandas as pd

def gen_layout():
    layout = html.Div([
                html.Div([
                    html.Div([
                            html.Button(html.I(className='fas fa-sync-alt'),
                                        id='btn_R_action',
                                        className='btn_in_title btn btn-primary col-1',)
                    ],style={'height': '8%','width':'100%','backgroundColor':'#E5ECF6','display':'flex','justifyContent':'end'}),
                    dcc.Graph(id='grh_action_duan_tron',style={'width':'100%','height':'100%'})
                ],className='au-card',style={'width':'100%','height':'100%'})
            ],className='col-lg-6 col-md-6 col-xs-12 m-b-15 graph_kt')
    return layout

@app_DuAn.callback(
    Output("grh_action_duan_tron", "figure"),
    [Input('ddl_name', 'value'),
     Input('detail_chitiet_duan', 'active_cell'),
     Input('detail_mucdott_duan', 'active_cell'),
     Input('detail_chitiet_trangthai', 'active_cell')],
    [State("detail_chitiet_duan", "data"),
     State("detail_mucdott_duan", "data"),
     State("detail_chitiet_trangthai", "data"),
    
    ]  
)


def update_action_duan_tron(name, AC_chitiet,AC_tt, AC_chitiet_tt, DT_chitiet, DT_tt, DT_chitiet_tt):
    #tu_ngay = None if den_ngay is None else tu_ngay
    ctx = dash.callback_context
    data_in_dt = {'detail_chitiet_duan': DT_chitiet,
                  'detail_mucdott_duan': DT_tt,
                  'detail_chitiet_trangthai': DT_chitiet_tt,}
    label, value = GParams_PJ.Get_Value(ctx, data_in_dt)
    df = DB_DuAn.GET_action_duan_tron((name,label, value, 'ty_le'))
    return Graph.grh_DonutChart(df['Soluot'],df['action'],margin=[50,50,30,30],title=f'TỶ LỆ TRẠNG THÁI DỰ ÁN')

@app_DuAn.callback(
     Output("grh_action_duan_tron", "clickData"),
    [Input('btn_R_action', 'n_clicks')]
)
def reset_dt_ac(rs):
    return None