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
                            html.Div([
                                html.B(html.Div("SỐ LƯỢNG TASK THEO STORY", style={'width': '100%', 'background': '#60B664', 'color': 'white', 'text-align': 'center'})),
                                html.A(
                                    children=[
                                        html.I(
                                            className="fas fa-file-download")
                                    ],
                                    id='download_task_bystory',
                                    download='TASK_THEO_STORY.csv',
                                    target="_blank",
                                    href='',
                                    className='btn btn-primary',
                                    style={'position': 'absolute', 'top': '0', 'right': '0', 'paddingTop': '0', 'background': '#60B664', 'border-color': '#60B664',
                                           'paddingBottom': '0', 'height': '100%',  'alignItems': 'center'}
                                )
                            ], style={'height': '7%', 'width': '100%', 'background': '#60B664', 'textAlign': 'center',  'alignItems': 'center', 'position': 'relative'}),

                           dash_table.DataTable(
                                id='detail_task_bystory',
                                columns=[
                                    {
                                        'name': 'Story', 
                                        'id': 's.title'
                                    },
                                    {
                                        'name': 'Số lượng task',
                                        'id': 'num_task'
                                    }
                                ],
                                style_cell_conditional=[
                                    {
                                        'if': {'column_id': 's.title'},
                                        'width': '60%',
                                        'textAlign': 'left',
                                        'padding-left': '15px'
                                    },
                                    {
                                        'if': {'column_id': 'num_task'},
                                        'width': '40%',
                                        'type' : 'numeric',
                                        'padding-left': '15px'
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
                                filter_action='native',
                                style_table={'height': '92%', 'width': '100%'},
                                sort_action="native",
                                )
                        ], className="au-card",style={'height':'100%'})
                    ], className="col-sm-12 col-md-12 col-lg-4 mb-3",style={'height':'100%'})
    return layout

@app_Task.callback(
    Output("detail_task_bystory", "data"),

    # Lấy dữ liệu từ dropdown list
    Input('date_filter', 'start_date'),
    Input('date_filter', 'end_date'),
    Input('ddl_task_project', 'value'),
    Input('ddl_task_user', 'value'),
    Input('ddl_task_story', 'value'),
    Input('ddl_task_dept', 'value'),

    # col, val filter
    Input('detail_task_delay', 'active_cell'),
    Input('detail_task_byproject', 'active_cell'),
    Input('task_num_pri', 'clickData'),
    Input('num_task_bydept', 'selectedData'),

    # data of dataTable
    State('detail_task_delay', 'data'),
    State('detail_task_byproject', 'data')
)
def UPDATE_detail_task_bystory(start_date, end_date, project_id, user, story, dept, ac_task_delay, ac_task_byproject, ac_task_numpri, ac_dept, data_task_delay, data_task_byproject):
    ctx = dash.callback_context 
    datatable = {'detail_task_delay': data_task_delay,
                 'detail_task_byproject': data_task_byproject,
                 }
    label, value = GParams_Task.Get_Value(ctx, datatable)
    df = DB_Task.Get_task(('num_task_bystory', start_date, end_date,project_id, user, story, dept, label, value, None, None, None, None))
    return df.to_dict(orient='records')

@app_Task.callback(
    Output('download_task_bystory', 'href'),
    [Input('download_task_bystory', 'n_clicks'),
     Input('detail_task_bystory', 'data')]
)
def UPDATE_DOWNLOAD(click, data):
    df = pd.DataFrame.from_dict(data)
    if df.empty:
        csv_string = df.to_csv(index=False, encoding='utf-8',header=[])
    else:
        csv_string = df.to_csv(index=False, encoding='utf-8',header=['Story', 'Số lượng task'])
    csv_string = "data:text/csv;charset=utf-8,%EF%BB%BF" + urllib.parse.quote(csv_string)
    return csv_string
