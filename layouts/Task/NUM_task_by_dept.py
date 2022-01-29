import dash
import dash_core_components as dcc
import dash_html_components as html
from DB import DB_Task
from app import app_Task
from utils import GParams_Task, Graph_Task
from dash.dependencies import Input, Output, State
import pandas as pd
import plotly.express as px
import numpy as np 

data = DB_Task.Get_ddl_task(('ddl_task_dept'))

def gen_layout():
    layout = html.Div([
        html.Div([
            html.Div([
                    html.Div([
                        html.B(html.Div(id="a",children="SÔ GIỜ ƯỚC TÍNH, THỰC HIỆN THEO NHÂN VIÊN", style={'height': '100%', 'width': '100%', 'background': '#60B664', 'color': 'white', 'text-align': 'center'})),
                    ], style={'height': '7%', 'width': '100%', 'background': '#60B664', 'textAlign': 'center', 'display': 'inline-grid', 'alignItems': 'center', 'position': 'relative'}),
            
                    # Dropdown Department
                        html.Div([
                            dcc.Dropdown(
                                id = 'ddl_depts',
                                options = [{'value': data.values[i][1].split(' (')[0], 'label': data.values[i][1].split(' (')[0]} for i in range(data.shape[0])],
                                value=None,
                                style= {"margin-top": "15px"},
                                placeholder='Chọn các phòng ban',
                                multi=True
                            ),

                        ],className='col-12', style={'margin-top': '5px','margin-bottom': '5px', 'width': '100%', 'align-items':'center'}),

                    # # Filter submit Button
                    #     html.Button(
                    #         'So sánh', 
                    #         id='btn-filter', 
                    #         n_clicks=0, 
                    #         style={'position': 'absolute', 'top': '43px', 'right': '0', 'paddingTop': '0', 'margin-right': '4px', 'background': 'white', 
                    #                'paddingBottom': '0', 'height': '39px', 'display': 'inline-grid', 'alignItems': 'center', 'width':'10%', 'border-radius':'6px'}
                    #         ),

                ], style={'height': '13%', 'width': '100%', 'background': '#60B664', 'textAlign': 'center', 'display': 'inline-grid', 'alignItems': 'center', 'position': 'relative'}),
            

            dcc.Graph(id="num_task_bydept", style={'width': '100%', 'height': '100%'}),
        ], className='au-card', style={'width': '100%', 'height': '100%'}),
    ], className="col-sm-12 col-md-12 col-lg-12 mb-3", style={'height': '100%'})

    return layout

@app_Task.callback(
    Output("num_task_bydept", "figure"),

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
    Input('detail_task_bystory', 'active_cell'),
    Input('task_num_pri', 'clickData'),
    Input('num_task_bydept', 'selectedData'),

    # Submit
    Input('ddl_depts', 'value'),

    # data of dataTable
    State('detail_task_delay', 'data'),
    State('detail_task_byproject', 'data'),
    State('detail_task_bystory', 'data'),
    

)
def update_num_task_hour_byuser_dept(start_date, end_date, project_id, user, story, dept, ac_task_delay, ac_task_byproject, ac_task_bystory, ac_task_numpri, ac_dept, depts, data_task_delay, data_task_byproject, data_task_bystory):
    ctx = dash.callback_context
    datatable = {'detail_task_delay': data_task_delay,
                 'detail_task_byproject': data_task_byproject,
                 'detail_task_bystory': data_task_bystory
                }
    label, value = GParams_Task.Get_Value(ctx, datatable)
    
    if depts is None or depts == [] :
        n = 0
        df = DB_Task.Get_task(('dept_order', start_date, end_date, project_id, user, story, dept, label, value, None, None, None, None))
    elif len(depts)==1:
        n = 0
        df = DB_Task.Get_task(('dept_order', start_date, end_date, project_id, user, story, dept, label, value, None, None, None, None))
        df = df[df['group_'].isin(depts)]
    else:
        n = len(depts)
        df = DB_Task.Get_task(('dept', start_date, end_date, project_id, user, story, dept, label, value, None, None, None, None))
        df = df[df['group_'].isin(depts)]

    if df.empty:
        df = pd.DataFrame({'user_name': ['Không có giá trị'], 'value': [0], 'type': ['Không có giá trị'], 'group_': ['Không có giá trị']} )

    return Graph_Task.grh_GroupBarChart_cp(n_depts=n, data=df, x='user_name', y='value', color='type', custom_data=['group_'], color_discrete_map={'Thực hiện': '#60B664', 'Ước tính': '#FD413C'})

@app_Task.callback(
    Output('ddl_depts', 'value'),
    Input('ddl_task_dept', 'value'),
    State('ddl_task_dept', 'options')
)
def update_ddl_depts(dept_id, dept_options):
    dept_option = ''

    if dept_id is None:
        return None
    
    for option in dept_options:
        if dept_id == option['value']:
            dept_option = option['label']

    if dept_option is None or  dept_option == '':
        return None
    else:
        return [dept_option.split(' (')[0]]