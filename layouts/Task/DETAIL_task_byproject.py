import dash
import dash_core_components as dcc
import dash_html_components as html
import dash_table
import pandas as pd
import urllib.parse
from dash_table.Format import Format, Scheme
from dash.dependencies import Input, Output, State
from static.system_dashboard.css import css_define as css
from utils import GParams_Task, Graph_Task
from app import app_Task
from DB import DB_Task


def gen_layout():

    layout =html.Div([
                        html.Div([
                            # Tao tieu de in dam
                            
                            html.Div([
                                html.B(html.Div("SỐ LƯỢNG TASK THEO DỰ ÁN", style={'height': '100%', 'width': '100%', 'background': '#60B664', 'color': 'white', 'text-align': 'center'})),
                                html.A(
                                    children=[
                                        html.I(className="fas fa-file-download")
                                    ],
                                    id='download_task_byproject',
                                    download='TASK_THEO_DU_AN.csv',
                                    target="_blank",
                                    href='',
                                    className='btn btn-primary',
                                    style={'position': 'absolute', 'top': '0', 'right': '0', 'paddingTop': '0', 'background': '#60B664', 'border-color': '#60B664',
                                           'paddingBottom': '0', 'height': '100%',  'alignItems': 'center'}
                                )
                            ], style={'height': '7%', 'width': '100%', 'background': '#60B664', 'textAlign': 'center',  'alignItems': 'center', 'position': 'relative'}),

                           # Khoi tao bang 
                           dash_table.DataTable(
                                id='detail_task_byproject',
                                # Dinh dang lai ten cot tieng viet
                                columns=[
                                    {
                                        'name': 'Dự án', 
                                        'id': 'p.name'
                                    },
                                    {
                                        'name': 'SL task đã tạo',
                                        'id': 'num_task_open'
                                    },
                                    {
                                        'name': 'SL task đang làm',
                                        'id': 'num_task_doing',
                                    },
                                    {
                                        'name': 'SL task hoàn thành',
                                        'id': 'num_task_finish'
                                    },
                                    {
                                        'name': 'SL task bị hủy',
                                        'id': 'num_task_cancel'
                                    },
                                    {
                                        'name': 'SL task bị đóng',
                                        'id': 'num_task_close'
                                    },
                                ],
                                #  Chinh kich thuoc cot va canh le
                                style_cell_conditional=[
                                    {
                                        'if': {'column_id': 'p.name'},
                                        'width': '30%',
                                        'textAlign': 'left',
                                        'padding-left': '15px'
                                    },
                                    {
                                        'if': {'column_id': 'num_task_open'},
                                        'width': '14%',
                                        'type': 'numeric',
                                        'textAlign': 'center',
                                        'padding-left': '15px'
                                    },
                                    {
                                        'if': {'column_id': 'num_task_doing'},
                                        'width': '14%',
                                        'type': 'text',
                                        'textAlign': 'center',
                                        'padding-left': '15px'
                                    },
                                    {
                                        'if': {'column_id': 'num_task_finish'},
                                        'width': '14%',
                                        'type': 'numeric',
                                        'textAlign': 'center',
                                        'padding-left': '15px'
                                    },
                                    {
                                        'if': {'column_id': 'num_task_cancel'},
                                        'width': '14%',
                                        'type': 'numeric',
                                        'textAlign': 'center',
                                        'padding-left': '15px'
                                    },
                                    {
                                        'if': {'column_id': 'num_task_close'},
                                        'width': '14%',
                                        'type': 'numeric',
                                        'textAlign': 'center',
                                        'padding-left': '15px'
                                    }
                                ],
                                css=[
                                        {
                                            'selector': '.dash-fixed-content',
                                            'rule': 'width: 100%;'
                                        }
                                    ],
                                
                                # co dinh dong dau tien cua bang
                                fixed_rows={'headers': True},
                                # gan gile css cho header va cac o trong bang
                                style_header=css.style_header,
                                style_cell=css.style_cell,
                                # Tao filter va sap xep cho cac cot trong bang
                                page_action = 'none',
                                filter_action='native',
                                style_table={'height': '100%', 'width': '100%'},
                                sort_action="native",
                                )
                        ], className="au-card",style={'height':'100%'})
                    ], className="col-sm-12 col-md-12 col-lg-8 mb-3",style={'height':'100%','margin-right': 'auto','margin-left': 'auto'})
    return layout

@app_Task.callback(
    Output("detail_task_byproject", "data"),

    # Lấy dữ liệu từ dropdown list
    Input('date_filter', 'start_date'),
    Input('date_filter', 'end_date'),
    Input('ddl_task_project', 'value'),
    Input('ddl_task_user', 'value'),
    Input('ddl_task_story', 'value'),
    Input('ddl_task_dept', 'value'),

    # col, val filter
    Input('detail_task_delay', 'active_cell'),
    Input('detail_task_bystory', 'active_cell'),
    Input('task_num_pri', 'clickData'),
    Input('num_task_bydept', 'selectedData'),

    # data of dataTable
    State('detail_task_delay', 'data'),
    State('detail_task_bystory', 'data')
)
def UPDATE_detail_task_byproject(start_date, end_date, project_id, user, story, dept, ac_task_delay, ac_task_bystory, ac_task_numpri, ac_dept, data_task_delay, data_task_bystory):
    # Bắt tương tác
    ctx = dash.callback_context
    # Truyền dữ liệu của bảng tương tác vào dict
    datatable = {'detail_task_delay': data_task_delay,
                 'detail_task_bystory': data_task_bystory}
    # Lấy giá trị col, val vừa tương tác
    label, value = GParams_Task.Get_Value(ctx, datatable)
    # Trả kết quả của thủ tục về dataframe
    dff = DB_Task.Get_task(('num_task_byproject', start_date, end_date, project_id, user, story, dept, label, value, None, None, None, None))
    df = dff.drop(dff[(dff.num_task_open == 0) & (dff.num_task_doing == 0) & (dff.num_task_finish == 0) & (dff.num_task_cancel == 0) & (dff.num_task_close == 0)].index)
    
    df['num_task_doing'] = df['num_task_doing'].apply(str) +  ' (' + round(df['num_task_doing']/df['num_task_open']*100,1).apply(str) + '%)'
    df['num_task_finish'] = df['num_task_finish'].apply(str) +  ' (' + round(df['num_task_finish']/df['num_task_open']*100,1).apply(str) + '%)'
    df['num_task_cancel'] = df['num_task_cancel'].apply(str) +  ' (' + round(df['num_task_cancel']/df['num_task_open']*100,1).apply(str) + '%)'
    df['num_task_close'] = df['num_task_close'].apply(str) +  ' (' + round(df['num_task_close']/df['num_task_open']*100,1).apply(str) + '%)'
    return df.to_dict(orient='records')


@app_Task.callback(
    Output('download_task_byproject', 'href'),
    [Input('download_task_byproject', 'n_clicks'),
     Input('detail_task_byproject', 'data')]
)
def UPDATE_DOWNLOAD(click, data):
    df = pd.DataFrame.from_dict(data)
    if df.empty:
        csv_string = df.to_csv(index=False, encoding='utf-8', header=[])
    else:
        csv_string = df.to_csv(index=False, encoding='utf-8', header=['Dự án', 'SL task đã tạo', 'SL task đang làm', 'SL task hoàn thành', 'SL task bị hủy', 'SL task bị đóng'])
    csv_string = "data:text/csv;charset=utf-8,%EF%BB%BF" + urllib.parse.quote(csv_string)
    return csv_string
