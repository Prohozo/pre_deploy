import dash
import dash_core_components as dcc
import dash_html_components as html
from DB import DB_User
from dash.dependencies import Input, Output, State
from utils import GParams_User as GParams
from static.system_dashboard.css import css_define as css
import pandas as pd
from layouts.users.GEN_OVERVIEW import create_card
from app import app_User
from layouts.users.DDL_DATE_RANGE_LAST import last_time

def gen_layout():

    title = 'SỐ LƯỢNG TASK ĐÃ TẠO'
    color = '#FF938B'
    icon = 'ov_taskopened3.svg'
    layout = create_card(title,'ov-taskopened',color,icon)
           
    return layout

@app_User.callback(
    Output("ov-taskopened","children"),
    Output("ov-taskopened_diff","children"),
    [Input('ddl_time_range','value'),
    Input('date-picker-range','start_date'),
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

def UPDATE_OV_TASK(date_value,start_date,end_date,ddl_project,ddl_user,ddl_dept,user_opened,user_done,taskdone_status,user_project,user_started,user_project_task,ac_project,ac_user,ac_log,ac_project_task,ac_workload,data_project, data_user,data_log,data_project_task,data_workload):
    ctx = dash.callback_context
    datatable = {'detail_PROJECT':data_project,
                 'user_0_task': data_user,
                 'user_0_login': data_log,
                 'detail_project_task':data_project_task,
                 'detail_user_workload':data_workload}
    label, value = GParams.Get_Value(ctx,datatable)
    df = DB_User.GET_USER(('ov_taskopened',start_date,end_date,ddl_project,ddl_user,ddl_dept,label,value,None,None,None,None))

    if date_value is not None:
        start_date_last,end_date_last = last_time(date_value)
        df2 = DB_User.GET_USER(('ov_taskopened',start_date_last,end_date_last,ddl_project,ddl_user,ddl_dept,label,value,None,None,None,None))

        end_value = df['Tổng số lượng task'].values[0]
        start_value  = df2['Tổng số lượng task'].values[0]

        if (end_value - start_value) > 0:
            return end_value, '▲' + str(round((end_value-start_value)/start_value*100, 1)) + '%'
        elif (end_value - start_value) < 0:
            return end_value, '▼' + str(round((start_value-end_value)/start_value*100, 1)) + '%'
        else: 
            return end_value, '0%'
    else: 
        return df['Tổng số lượng task'].values[0], '-'

   


