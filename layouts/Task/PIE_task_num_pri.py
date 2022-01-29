import dash
import dash_core_components as dcc
import dash_html_components as html
from dash.dependencies import Input, Output, State
from layouts.Task.GEN_BUTTON import create_button
from app import app_Task
from utils import Graph_Task, GParams_Task
from DB import DB_Task


def gen_layout():
    layout = html.Div([
        html.Div([
            html.Div([
                html.Button(
                    html.I(className='fas fa-sync-alt'),
                    id='btn_R',
                    style={'paddingBottom': '0 !important', 'paddingTop': '0 !important'},className='btn_in_title btn btn-primary col-1')
            ], style={'height': '5%', 'width': '100%', 'backgroundColor': '#60B664', 'display': 'flex', 'justifyContent': 'end'}),
            dcc.Graph(id="task_num_pri", style={'width': '100%', 'height': '92%'}),
            
        ], className='au-card', style={'width': '100%', 'height': '100%'}),
        
    ], className="col-sm-12 col-md-12 col-lg-3 mb-3", style={'height': '60vh'})

    return layout


@app_Task.callback(
    Output("task_num_pri", "figure"),

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
    Input('num_task_bydept', 'selectedData'),

    # data of dataTable
    State('detail_task_delay', 'data'),
    State('detail_task_byproject', 'data'),
    State('detail_task_bystory', 'data')
)
def update_task_num_pri(start_date, end_date, project_id, user, story, dept, ac_task_delay, ac_task_byproject, ac_task_bystory, ac_dept, data_task_delay, data_task_byproject, data_task_bystory):
    ctx = dash.callback_context
    datatable = {'detail_task_delay': data_task_delay,
                 'detail_task_byproject': data_task_byproject,
                 'detail_task_bystory': data_task_bystory
                 }
    label, value = GParams_Task.Get_Value(ctx, datatable)
    df = DB_Task.Get_task(('num_pri', start_date, end_date, project_id, user, story, dept, label, value, None, None, None, None))
    return Graph_Task.grh_DonutChart(df['number'], df['t.pri'], title='<b>ĐỘ ƯU TIÊN CỦA TASK</b>', margin=[50, 10, 35, 35], colors=['#107a8b', '#2cb978', '#60B664', '#3b5441'])

@app_Task.callback(
    Output('task_num_pri', 'clickData'),
    Input('btn_R', 'n_clicks')
)
def refresh(click):
    return None
