import dash
import dash_core_components as dcc
import dash_html_components as html
from dash.dependencies import Input, Output, State
from app import app_Task
from utils import Graph_Task, GParams_Task
from DB import DB_Task

def gen_layout():

    layout = html.Div([
                html.Div([
                    html.Div([
                                html.B(html.Div("SỐ LƯỢNG TASK ĐÃ HOÀN THÀNH THEO NHÂN VIÊN", style={'width': '100%', 'background': '#60B664', 'color': 'white', 'text-align': 'center'}))
                            ], style={'height': '5%', 'width': '100%', 'background': '#60B664', 'textAlign': 'center',  'alignItems': 'center', 'position': 'relative'}),
                    dcc.Graph(id="bar_taskdone", style={'width': '100%', 'height': '100%'})
                ],className='au-card' ,style={'width': '100%', 'height': '100%'})
            ], className="col-sm-12 col-md-6 col-lg-6 mb-3" , style={'height':'100%'})
           
    return layout

@app_Task.callback(
    Output("bar_taskdone","figure"),

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

    # data of dataTable
    State('detail_task_delay', 'data'),
    State('detail_task_byproject', 'data'),
    State('detail_task_bystory', 'data'),

)

def update_task_done_bar(start_date, end_date, project_id, user, story, dept, ac_task_delay, ac_task_byproject, ac_task_bystory,ac_task_numpri, ac_dept, data_task_delay, data_task_byproject, data_task_bystory):
    ctx = dash.callback_context
    datatable = {'detail_task_delay': data_task_delay,
                 'detail_task_byproject': data_task_byproject,
                 'detail_task_bystory': data_task_bystory
                 }
    label, value = GParams_Task.Get_Value(ctx, datatable)
    df = DB_Task.Get_task(('bar_taskdone', start_date, end_date, project_id, user, story, dept, label, value, None, None, None, None))
   
    return  Graph_Task.grh_BarChart(df['t.finishedBy'],df['So_luong_task_hoan_thanh'],marker_color=['#60B664','#60B664'],margin = [35, 150, 35, 35])
