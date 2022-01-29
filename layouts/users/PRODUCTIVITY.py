import dash
import dash_core_components as dcc
import dash_html_components as html
from DB import DB_User
from dash.dependencies import Input, Output, State
from utils import GParams_User as GParams
from utils import Graph_User as Graph
from app import app_User

def gen_layout():

    layout = html.Div([
                html.Div([
                    dcc.Graph(id="grh_line_productivity", style={'width': '100%', 'height': '100%'})
                ],className='au-card' ,style={'width': '100%', 'height': '100%'})
            ],className="col-sm-12 col-md-12 col-lg-6 mb-3",style={'height':'45vh'})
           
    return layout

@app_User.callback(
    Output("grh_line_productivity","figure"),
    [Input('date-picker-range','start_date'),
    Input('date-picker-range','end_date'),
    Input('ddl_project','value'),
    Input('ddl_user','value'),
    Input('ddl_dept','value'),
    Input('grh_bar_taskopened','selectedData'),
    Input('grh_bar_taskdone','selectedData'),
    Input('grh_bar_project','selectedData'),  
    Input('grh_bar_taskstarted','selectedData'),
    Input('grh_bar_project_task','selectedData'),
    Input('detail_PROJECT','active_cell'),
    Input('user_0_task','active_cell'),
    Input('user_0_login','active_cell'),
    Input('detail_project_task','active_cell'),
    Input('detail_user_workload','active_cell'),
    ],
    [State('detail_PROJECT','data'),
    State('user_0_task','data'),
    State('user_0_login','data'),
    State('detail_project_task','data'),
    State('detail_user_workload','data'),],
)

def UPDATE_SL_TASKDONE(start_date,end_date,ddl_project,ddl_user,ddl_dept,user_opened,user_done,user_project,user_started,user_project_task,ac_project,ac_user,ac_log,ac_project_task,ac_workload,data_project, data_user,data_log,data_project_task,data_workload):
    ctx = dash.callback_context
    datatable = {'detail_PROJECT':data_project,
                 'user_0_task': data_user,
                 'user_0_login': data_log,
                 'detail_project_task':data_project_task,
                 'detail_user_workload':data_workload}
    label, value = GParams.Get_Value(ctx,datatable)
    df = DB_User.GET_USER(('line_productivity',start_date,end_date,ddl_project,ddl_user,ddl_dept,label,value,None,None,None,None))
   
    return  Graph.grh_LineChart(df['Thời gian'],df['Năng suất'],mode='lines+markers',title='NĂNG SUẤT CỦA NHÂN VIÊN THEO NGÀY (%)',margin = [40, 115, 35, 35],color ='#FFD45D')


