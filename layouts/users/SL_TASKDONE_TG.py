import dash
import dash_core_components as dcc
import dash_html_components as html
from DB import DB_User
from dash.dependencies import Input, Output, State
from utils import GParams_User as GParams
from utils import Graph_User as Graph
from app import app_User


def gen_layout():
    tab_style = {'borderTop': '1px solid #22E3AC',
                'borderLeft': '1px solid #22E3AC',
                'borderRight': '1px solid #22E3AC',
                'borderBottom': '1px solid  #22E3AC',
                'backgroundColor':'#22E3AC',
                'color':'black',
                'fontWeight': 'bold',
                'text-align': 'center',
                'align-items': 'center',
                'padding':'9px 25px'}

    tab_selected_style= {'borderTop': '1px solid #1AB085',
                        'borderLeft': '1px solid #1AB085',
                        'borderRight': '1px solid #1AB085',
                        'borderBottom': '1px solid  #1AB085',
                        'backgroundColor':'#1AB085',
                        'color':'white',
                        'padding':'9px 25px'}
    layout = html.Div([
                html.Div([
                    dcc.Tabs(value='month',
                        children =[
                            dcc.Tab(label='Ngày',
                                    value='day',
                                    children = [
                                        dcc.Graph(id='task_done_day',style={'width': '100%', 'height': '100%'}),
                                    ],
                                    style=tab_style,
                                    selected_style=tab_selected_style, className = 'col-3'),
                            dcc.Tab(label='Tháng',
                                    value='month',
                                    children = [
                                        dcc.Graph(id='task_done_month',style={'width': '100%', 'height': '100%'}),
                                    ],                            
                                    style=tab_style,
                                    selected_style=tab_selected_style, className = 'col-3'),
                            dcc.Tab(label='Quý',
                                    value='quarter',
                                    children = [
                                        dcc.Graph(id='task_done_quarter',style={'width': '100%', 'height': '100%'}),
                                    ], 
                                    style=tab_style,
                                    selected_style=tab_selected_style, className = 'col-3'),
                            dcc.Tab(label='Năm',
                                    value='year',
                                    children = [
                                        dcc.Graph(id='task_done_year',style={'width': '100%', 'height': '100%'}),
                                    ], 
                                    style=tab_style,
                                    selected_style=tab_selected_style, className = 'col-3'),
                        ],style={'height':'6vh'},className='row'),
                ],className='au-card' ,style={'width': '100%', 'height': '100%'})
            ],className="col-sm-12 col-md-12 col-lg-6 mb-3")

    return layout

@app_User.callback(
    Output("task_done_year","figure"),
    Output("task_done_month","figure"),
    Output("task_done_quarter","figure"),
    Output("task_done_day","figure"),
    [Input('date-picker-range','start_date'),
    Input('date-picker-range','end_date'),
    Input('ddl_project','value'),
    Input('ddl_user','value'),
    Input('ddl_dept','value'),
    Input('grh_bar_taskopened','selectedData'),
    Input('grh_bar_taskdone','selectedData'),
    Input('grh_pie_taskdone','clickData'),
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

def UPDATE_SL_TASKDONE_TG(start_date,end_date,ddl_project,ddl_user,ddl_dept,user_opened,user_done,taskdone_status,user_project,user_started,user_project_task,ac_project,ac_user,ac_log,ac_project_task,ac_workload,data_project, data_user,data_log,data_project_task,data_workload):
    ctx = dash.callback_context
    datatable = {'detail_PROJECT':data_project,
                 'user_0_task': data_user,
                 'user_0_login': data_log,
                 'detail_project_task':data_project_task,
                 'detail_user_workload':data_workload}
    label, value = GParams.Get_Value(ctx,datatable)

    df1 = DB_User.GET_USER(('line_taskdone',start_date,end_date,ddl_project,ddl_user,ddl_dept,label,value,1,None,None,None))
    figure1 = Graph.grh_LineChart(df1['Thời gian'],df1['Số lượng Task'],mode='lines+markers',title='SỐ LƯỢNG TASK ĐÃ HOÀN THÀNH THEO NĂM',margin = [40, 90, 35, 35],color='#22E3AC')
    df2 = DB_User.GET_USER(('line_taskdone',start_date,end_date,ddl_project,ddl_user,ddl_dept,label,value,None,1,None,None))
    figure2 = Graph.grh_LineChart(df2['Thời gian'],df2['Số lượng Task'],mode='lines+markers',title='SỐ LƯỢNG TASK ĐÃ HOÀN THÀNH THEO THÁNG',margin = [40, 90, 35, 35],color='#22E3AC') 

    df3 = DB_User.GET_USER(('line_taskdone',start_date,end_date,ddl_project,ddl_user,ddl_dept,label,value,None,None,None,1))
    figure3 = Graph.grh_LineChart(df3['Thời gian'],df3['Số lượng Task'],mode='lines+markers',title='SỐ LƯỢNG TASK ĐÃ HOÀN THÀNH THEO QUÝ',margin = [40, 90, 35, 35],color='#22E3AC') 

    df4 = DB_User.GET_USER(('line_taskdone',start_date,end_date,ddl_project,ddl_user,ddl_dept,label,value,None,None,1,None))
    figure4 = Graph.grh_LineChart(df4['Thời gian'],df4['Số lượng Task'],mode='lines+markers',title='SỐ LƯỢNG TASK ĐÃ HOÀN THÀNH THEO NGÀY',margin = [40, 115, 35, 35],color='#22E3AC') 
    return figure1,figure2,figure3,figure4


































