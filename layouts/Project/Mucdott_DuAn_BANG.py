import dash
import dash_core_components as dcc
import dash_html_components as html
import dash_table
import urllib.parse
from dash_table.Format import Format, Scheme
from dash.dependencies import Input, Output, State 
from app import app_DuAn
from static.system_dashboard.css import css_define as css
from utils import GParams_PJ, Graph
from DB import DB_DuAn
import pandas as pd
# import datetime
def gen_layout():


    layout =  html.Div([
                        html.Div([
                            html.Div([
                                html.Div("DỰ ÁN KHÔNG TƯƠNG TÁC", style={'width':'100%','background': '#60B664'}),
                            
                            ], style={'height': '10%','width':'100%','background': '#60B664','textAlign':'center','display':'inline-grid','alignItems':'center','position':'relative'}),
                            dash_table.DataTable(
                                id='detail_mucdott_duan',
                                columns=[

                                    {
                                        'name': 'Tên dự án', 
                                        'id': 'name'
                                    },
                                    {
                                        'name': 'Số ngày chưa tương tác', 
                                        'id': 'tt_date'
                                        
                                    },
                                    {
                                        'name': 'Trạng thái', 
                                        'id': 'LoaiHinh'
                                        
                                    },
                                    
                                 
                                ],
                                style_cell_conditional=[

                                    {
                                        'if': {'column_id': 'name'},
                                        'width': '50%',
                                        'textAlign': 'left',
                                        'padding-left': '15px'
                                    },
                                    {
                                        'if': {'column_id': 'tt_date'},
                                        'width': '25%',
                                        
                                    },
                                    {
                                        'if': {'column_id': 'LoaiHinh'},
                                        'width': '25%'
                                    },
                                    
                             
                                ],
                                css=[
                                        {
                                            'selector': '.dash-fixed-content',
                                            'rule': 'width: 100%;'
                                        }
                                    ],
                                fixed_rows={'headers': True},
                                style_header=css.style_header,
                                style_cell=css.style_cell,
                                page_action = 'none',
                                style_table={'height': '90%','width':'100%'},
                                sort_action="native",
                                # sort_mode="multi",
                                )
                        ], className="au-card",style={'height':'100%'})
                    ], className="col-lg-6 m-b-15 graph_kt")

    return layout


@app_DuAn.callback(
    [Output("detail_mucdott_duan", "data"),
     Output("detail_mucdott_duan", "style_data_conditional")],
    [Input('ddl_name', 'value'),
     Input('ddl_dept', 'value'),
     Input('grh_status_duan_tron', 'clickData'),
     Input('detail_chitiet_duan', 'active_cell'),
     Input('detail_chitiet_trangthai', 'active_cell')],
    [State("detail_chitiet_duan", "data"),
     State("detail_chitiet_trangthai", "data"),
    ]
)   
     
#      Input('grh_Chiphi_loai', 'selectedData'),
#      Input('grh_CHIPHI_THOIGIAN', 'selectedData'),
#      Input('detail_ChiPhiBH', 'active_cell'),
#      Input('detail_ChiPhiDV', 'active_cell')],
#     [State("detail_ChiPhiBH", "data"),
#      State("detail_ChiPhiDV", "data"),]
# )

def update_tt_duan(name, dept, status_DA, AC_chitiet,  AC_chitiet_tt,  DT_chitiet, DT_chitiet_tt):
    ctx = dash.callback_context
    data_in_dt = {'detail_chitiet_duan': DT_chitiet,
                  'detail_chitiet_trangthai': DT_chitiet_tt,}
    label, value = GParams_PJ.Get_Value(ctx, data_in_dt)
    df = DB_DuAn.GET_tt_duan_bang((name, dept, label, value))
    sdc =   (
                [{
                    'if': {'row_index': 'even'},
                    'backgroundColor': '#f9f9f9'
                }]+
                [{
                    'if': {
                        'filter_query': '{tenCP} contains "TỔNG : "',
                    },
                    'fontWeight': '900',
                }]
            )
    return [df.to_dict(orient='records'), sdc]

# @app_DuAn.callback(
#      Output('download_detail_CHIPHI', 'href'),
#     [Input('download_detail_CHIPHI','n_clicks'),
#      Input('detail_ChiPhi','data')]
# )

# def UPDATE_DOWNLOAD(click,data):
#     df = pd.DataFrame.from_dict(data)
#     if df.shape[0] == 0:
#         return '#'
#     csv_string = df.to_csv(index=False, encoding='utf-8',header=['Tài khoản','Loại chi phí','Cửa hàng','Giá trị'])
#     csv_string = "data:text/csv;charset=utf-8,%EF%BB%BF" + urllib.parse.quote(csv_string)
#     return csv_string