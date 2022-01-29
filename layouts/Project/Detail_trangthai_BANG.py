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
                                html.Div("BẢNG CHI TIẾT TRẠNG THÁI DỰ ÁN", style={'width':'100%','background': '#60B664'}),
                                html.A(
                                    children=[
                                        html.I(className="fas fa-download")
                                    ],
                                    id='download_detail_trangthai',
                                    download='trangthai.csv',
                                    target="_blank",
                                    href = '',
                                    className='btn btn-primary',
                                    style={'position':'absolute','top':'0','right':'0','paddingTop':'0','paddingBottom':'0','height': '100%','display': 'inline-grid','alignItems': 'center'}
                                ),
                            ], style={'height': '10%','width':'100%','background': '#60B664','textAlign':'center','display':'inline-grid','alignItems':'center','position':'relative'}),
                            dash_table.DataTable(
                                id='detail_chitiet_trangthai',
                                columns=[

                                    {
                                        'name': 'Tên dự án', 
                                        'id': 'name'
                                    },
                                    {
                                        'name': 'Trạng thái', 
                                        'id': 'LoaiHinh'
                                        
                                    },
                                    {
                                        'name': 'Số ngày còn lại', 
                                        'id': 'SoNgay'
                                        
                                    },
                                    {
                                        'name': 'PM', 
                                        'id': 'PM'
                                        
                                    },
                                    {
                                        'name': 'Ngày bắt đầu', 
                                        'id': 'begin'
                                        
                                    },
                                    {
                                        'name': 'Ngày kết thúc', 
                                        'id': 'end'
                                        
                                    },
                                   
                                    {
                                        'name': 'Số người tham gia', 
                                        'id': 'SoNguoi'
                                        
                                    },
                                    {
                                        'name': 'Số Task', 
                                        'id': 'SoTask'
                                        
                                    },
                                    
                                 
                                ],
                                style_cell_conditional=[

                                    {
                                        'if': {'column_id': 'name'},
                                        'width': '25%',
                                        'textAlign': 'left',
                                        'padding-left': '15px'
                                    },
                                    {
                                        'if': {'column_id': 'LoaiHinh'},
                                        'width': '15%',
                                        
                                    },
                                    
                                    {
                                        'if': {'column_id': 'SoNgay'},
                                        'width': '10%'
                                    },
                                    {
                                        'if': {'column_id': 'PM'},
                                        'width': '10%',
                                        
                                    },
                                    {
                                        'if': {'column_id': 'begin'},
                                        'width': '10%',
                                        
                                    },
                                    {
                                        'if': {'column_id': 'end'},
                                        'width': '10%',
                                        
                                    },
                                    {
                                        
                                        'if': {'column_id': 'SoNguoi'},
                                        'width': '10%'
                                    },
                                    {
                                        
                                        'if': {'column_id': 'SoTask'},
                                        'width': '10%'
                                    }
                             
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
                    ], className="col-lg-8 m-b-15 graph_kt")

    return layout


@app_DuAn.callback(
    [Output("detail_chitiet_trangthai", "data"),
     Output("detail_chitiet_trangthai", "style_data_conditional")],
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
     Input('detail_chitiet_duan', 'active_cell'),
     Input('detail_tiendo_duan', 'active_cell')],
    [State("SoDuAn_dept", "data"),
     State("detail_chitiet_duan", "data"),
     State("detail_tiendo_duan", "data"),
    ]
)   
     

def update_chitiet_trangthai(name, dept, start_act,end_act,TL_DA_dept, status_DA, action_TG_month, action_TG_day, action_TG_year, AC_DA_dept, AC_chitiet, AC_td, DT_DA_dept, DT_chitiet, DT_td):
    ctx = dash.callback_context
    data_in_dt = {'SoDuAn_dept': DT_DA_dept,
                  'detail_chitiet_duan': DT_chitiet,
                  'detail_tiendo_duan': DT_td,}
    label, value = GParams_PJ_Multile.Get_Value(ctx, data_in_dt)
    if label in ('action_month', 'action_day', 'action_year'):
        label = label.split('_')[0]

    if start_act is None or end_act is None:
        start_act, end_act = None, None 
    df = DB_DuAn.GET_detail_trangthai_bang((name, dept, start_act,end_act, label, value))
    sdc =   (
                [{
                    'if': {'row_index': 'even'},
                    'backgroundColor': '#f9f9f9'
                }]+
                [{
                    'if': {
                        'filter_query': '{LoaiHinh} = "closed"',
                        'column_id': 'name'
                    },
                    'backgroundColor': 'rgb(204, 0, 0)'
                }]
            )
    return [df.to_dict(orient='records'), sdc]

@app_DuAn.callback(
     Output('download_detail_trangthai', 'href'),
    [Input('download_detail_trangthai','n_clicks'),
     Input('detail_chitiet_trangthai','data')]
)

def UPDATE_DOWNLOAD(click,data):
    df = pd.DataFrame.from_dict(data)
    if df.shape[0] == 0:
        return '#'
    csv_string = df.to_csv(index=False, encoding='utf-8',header=['Tên dự án','Trạng thái','Số ngày còn lại','PM', 'Ngày bắt đầu', 'Ngày kết thúc','Số người tham gia','Số Task'])
    csv_string = "data:text/csv;charset=utf-8,%EF%BB%BF" + urllib.parse.quote(csv_string)
    return csv_string