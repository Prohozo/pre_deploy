import dash
import dash_core_components as dcc
import dash_html_components as html
# import dash_table
# import urllib.parse
# from dash_table.Format import Format, Scheme
from dash.dependencies import Input, Output, State 
from app import app_DuAn
from static.system_dashboard.css import css_define as css
from utils import GParams_PJ_Multile, Graph
from DB import DB_DuAn
import pandas as pd

def gen_layout():
    tab_style = {
        'borderBottom': '1px solid #d6d6d6',
        'color': 'black',
        'background-color': 'white',
        'border-left': '1px solid #E5E5E5',
        'text-align': 'center',
        'padding': '9px 25px',
    }

    tab_selected_style = {
        'borderTop': '1px solid #60B664',
        'borderBottom': '1px solid #60B664',
        'backgroundColor': '#60B664',
        'color': 'white',
        'fontWeight': 'bold',
        'text-align': 'center',
        'padding': '9px 25px'

    }

    layout = html.Div([
        html.Div([
            dcc.Tabs([
                dcc.Tab(
                    label='Tháng',
                    children=[            
                      dcc.Graph(id="grh_action_TG_month",
                      responsive=True,
                      style={'height':'100%','width':'100%'})
                    ],
                    style=tab_style, selected_style=tab_selected_style
                ),
                dcc.Tab(
                    label='Ngày',
                    children=[
                        dcc.Graph(id="grh_action_TG_day",
                        responsive=True,
                        style={'height':'100%','width':'100%'})
                    ],
                    style=tab_style, selected_style=tab_selected_style
                ),
                dcc.Tab(
                    label='Năm',
                    children=[
                        dcc.Graph(id="grh_action_TG_year",
                        responsive=True,
                        style={'height':'100%','width':'100%'})
                    ],
                    style=tab_style, selected_style=tab_selected_style
                ),
            ],style={'height':'10%','width':'100%'})
        ], className='au-card ', style={'height':'100%','width':'100%'})
    ], className='col-12 m-b-15 graph_kt')
    return layout

@app_DuAn.callback(
    [Output('grh_action_TG_month', 'figure'),
     Output('grh_action_TG_day', 'figure'),
     Output('grh_action_TG_year', 'figure')],
    [Input('filter_date', 'start_date'),
     Input('filter_date', 'end_date'),
     Input('ddl_name', 'value'),
     Input('ddl_dept', 'value'),
     Input('grh_status_duan_tron', 'clickData'),
     Input('grh_TL_DA_dept', 'selectedData'),
     Input('detail_chitiet_duan', 'active_cell'),
     Input('SoDuAn_dept', 'active_cell'),
     Input('detail_chitiet_trangthai', 'active_cell'),
     Input('detail_tiendo_duan', 'active_cell')],
    [State("detail_chitiet_duan", "data"),
     State("SoDuAn_dept", "data"),
     State("detail_chitiet_trangthai", "data"),
     State("detail_tiendo_duan", "data"),
    
     ]
)
def update_Action_TG(ngay_bd, ngay_kt, name, dept, status_DA, TL_DA_dept, AC_chitiet, AC_DA_dept, AC_chitiet_tt, AC_td,  DT_chitiet, DT_DA_dept, DT_chitiet_tt, DT_td):
    ctx = dash.callback_context
    data_in_dt = {'detail_chitiet_duan': DT_chitiet,
                  'SoDuAn_dept': DT_DA_dept,
                  'detail_chitiet_trangthai': DT_chitiet_tt,
                  'detail_tiendo_duan': DT_td,}
    label, value = GParams_PJ_Multile.Get_Value(ctx,data_in_dt)
    ngay_bd = ngay_bd if ngay_kt is not None else ngay_kt

    df_y = DB_DuAn.GET_countAction_multiline((name, dept, label, value, ngay_bd, ngay_kt, 'Y'))
    df_m = DB_DuAn.GET_countAction_multiline((name, dept, label, value, ngay_bd, ngay_kt, 'M'))
    df_d = DB_DuAn.GET_countAction_multiline((name, dept, label, value, ngay_bd, ngay_kt, 'D'))

    DB_DuAn.ACTION['grh_action_TG_year'] = df_y['action'].unique()
    DB_DuAn.ACTION['grh_action_TG_month'] = df_m['action'].unique()
    DB_DuAn.ACTION['grh_action_TG_day'] = df_d['action'].unique()


    if df_y.shape[0] > 0:
        return  [Graph.grh_Multi_Line(df_m, 'time', 'count', 'action',title = 'SỐ LƯỢNG HÀNH ĐỘNG THEO THÁNG', margin = [50, 230, 10, 10], time_labels='M'),
                 Graph.grh_Multi_Line(df_d, 'time', 'count', 'action',title = 'SỐ LƯỢNG HÀNH ĐỘNG THEO NGÀY', margin = [50, 230, 10, 10], time_labels='D'),
                 Graph.grh_Multi_Line(df_y, 'time', 'count', 'action',title = 'SỐ LƯỢNG HÀNH ĐỘNG THEO NĂM', margin = [50, 230, 10, 10], time_labels='Y')]
    else:
        return [Graph.grh_LineChart(df_d['time'], df_d['count'], None),Graph.grh_LineChart(df_d['time'], df_d['count'], None),Graph.grh_LineChart(df_d['time'], df_d['count'], None)]