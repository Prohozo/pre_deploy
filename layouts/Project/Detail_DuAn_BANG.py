import dash
import dash_core_components as dcc
import dash_html_components as html
import dash_table
import urllib.parse
from dash_table.Format import Format, Scheme
from dash.dependencies import Input, Output, State 
from app import app_DuAn
from static.system_dashboard.css import css_define as css
from utils import GParams_PJ_Multile, Graph
from DB import DB_DuAn
import pandas as pd
# import datetime
def gen_layout():

    layout =  html.Div([
                        html.Div([
                            html.Div([
                                html.Div("BẢNG THỐNG KÊ SỐ NGÀY KHÔNG TƯƠNG TÁC, SỐ LƯỢNG STORY CỦA  DỰ ÁN", style={'width':'100%','background': '#60B664'}),
                                html.A(
                                    children=[
                                        html.I(className="fas fa-download")
                                    ],
                                    id='download_detail_DuAn',
                                    download='Duan.csv',
                                    target="_blank",
                                    href = '',
                                    className='btn btn-primary',
                                    style={'position':'absolute','top':'0','right':'0','paddingTop':'0','paddingBottom':'0','height': '100%','display': 'inline-grid','alignItems': 'center'}
                                ),
                            ], style={'height': '10%','width':'100%','background': '#60B664','textAlign':'center','display':'inline-grid','alignItems':'center','position':'relative'}),
                            dash_table.DataTable(
                                id='detail_chitiet_duan',
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
                                        'name': 'Số lượng story', 
                                        'id': 'story_num'
                                        
                                    },
                                    {
                                        'name': 'Trạng thái', 
                                        'id': 'LoaiHinh'
                                        
                                    },
                                    
                                 
                                ],
                                style_cell_conditional=[

                                    {
                                        'if': {'column_id': 'name'},
                                        'width': '30%',
                                        'textAlign': 'left',
                                        'padding-left': '15px'
                                    },
                                    {
                                        'if': {'column_id': 'tt_date'},
                                        'width': '25%'
                                        
                                    },
                                    {
                                        'if': {'column_id': 'story_num'},
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
                                style_header= css.style_header,
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
    [Output("detail_chitiet_duan", "data"),
     Output("detail_chitiet_duan", "style_data_conditional")],
    [Input('ddl_name', 'value'),
     Input('ddl_dept', 'value'),
     Input('filter_date', 'start_date'),
     Input('filter_date', 'end_date'),
     Input('grh_TL_DA_dept', 'selectedData'),
     Input('grh_status_duan_tron', 'clickData'),
     Input('grh_action_TG_month', 'selectedData'),
     Input('grh_action_TG_day', 'selectedData'),
     Input('grh_action_TG_year', 'selectedData'),
     Input('SoDuAn_dept', 'active_cell'),
     Input('detail_chitiet_trangthai', 'active_cell'),
     Input('detail_tiendo_duan', 'active_cell')],
    [State("SoDuAn_dept", "data"),
     State("detail_chitiet_trangthai", "data"),
     State("detail_tiendo_duan", "data"),
    ]
)   
     

def update_chitiet_duan(name, dept, start_act,end_act, TL_DA_dept, status_DA, action_TG_month, action_TG_day, action_TG_year, AC_DA_dept, AC_chitiet_tt, AC_td, DT_DA_dept, DT_chitiet_tt, DT_td):
    ctx = dash.callback_context
    data_in_dt = {'SoDuAn_dept': DT_DA_dept,
                  'detail_chitiet_trangthai': DT_chitiet_tt,
                  'detail_tiendo_duan': DT_td,}
    label, value = GParams_PJ_Multile.Get_Value(ctx, data_in_dt)
    if label in ('action_month', 'action_day', 'action_year'):
        label = label.split('_')[0]

    if start_act is None or end_act is None:
        start_act, end_act = None, None 
    
    df = DB_DuAn.GET_detail_duan_bang((name,dept, start_act, end_act, label, value))
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
@app_DuAn.callback(
     Output('download_detail_DuAn', 'href'),
    [Input('download_detail_DuAn','n_clicks'),
     Input('detail_chitiet_duan','data')]
)

def UPDATE_DOWNLOAD(click,data):
    df = pd.DataFrame.from_dict(data)
    if df.shape[0] == 0:
        return '#'
    csv_string = df.to_csv(index=False, encoding='utf-8',header=['Tên dự án','Số ngày chưa tương tác','Số lượng story','Trạng thái'])
    csv_string = "data:text/csv;charset=utf-8,%EF%BB%BF" + urllib.parse.quote(csv_string)
    return csv_string
