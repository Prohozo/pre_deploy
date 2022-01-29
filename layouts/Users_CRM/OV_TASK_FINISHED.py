import dash
import dash_core_components as dcc
import dash_html_components as html
from DB import DB_Users_CRM
from dash.dependencies import Input, Output, State
from utils import GParams_UsersCRM
from static.system_dashboard.css import css_define as css
import pandas as pd
from layouts.Users_CRM.GEN_OVERVIEW import create_card
from app import app_UsersCRM
from layouts.Users_CRM.DDL_DATE_RANGE_LAST import last_time

def gen_layout():

    title = 'SỐ LƯỢNG TASK HOÀN THÀNH'
    color = 'linear-gradient(50deg, rgba(63,94,251,1) 0%, rgba(252,70,70,1) 100%)'
    icon = 'ov_finished.svg'
    layout = create_card(title,'ov_task_finished',color,icon)
           
    return layout

@app_UsersCRM.callback(
    Output("ov_task_finished","children"),
    Output("ov_task_finished_diff","children"),
    [Input('ddl_time_range','value'),
    Input('date-picker-range','start_date'),
    Input('date-picker-range','end_date'),
    Input('ddl_account','value'),
    Input('ddl_user_assign','value'),
    Input('ddl_dept','value'),
    Input('grh_parento_salesorder','clickData'),
    Input('grh_bar_task_created','selectedData'),
    Input('grh_bar_task_finished','selectedData'),
    Input('user_without_activity','active_cell'),
    Input('user_task_delay','active_cell'),
    Input('user_activity_detail','active_cell'),
    Input('user_without_login','active_cell'),
    ],
    [State('user_without_activity','data'),
    State('user_task_delay','data'),
    State('user_activity_detail','data'),
    State('user_without_login','data'),
    ]

)

def UPDATE_OV_TASK_FINISHED(date_value,start_date,end_date,ddl_account,ddl_user_assign,ddl_dept,salesorder,task_created,task_finished,ac_withoutactivity,ac_task_delay,ac_activity_detail,ac_without_login,data_withoutactivity,data_task_delay,data_activity_detail,data_without_login):
    ctx = dash.callback_context
    datatable = {'user_without_activity': data_withoutactivity, 
                'user_task_delay': data_task_delay,
                'user_activity_detail':data_activity_detail,
                'user_without_login':data_without_login
                }
    label, value = GParams_UsersCRM.Get_Value(ctx,datatable)
    df = DB_Users_CRM.GET_USERSCRM(('ov_task_finished',start_date,end_date,ddl_account,ddl_user_assign,ddl_dept,label,value))
    
    if date_value is not None:
        start_date_last,end_date_last = last_time(date_value)
        df2 = DB_Users_CRM.GET_USERSCRM(('ov_task_finished',start_date_last,end_date_last,ddl_account,ddl_user_assign,ddl_dept,label,value))

        end_value = df['Tổng số lượng task hoàn thành'].values[0]
        start_value  = df2['Tổng số lượng task hoàn thành'].values[0]

        if (end_value - start_value) > 0:
            return end_value, '▲' + str(round((end_value-start_value)/start_value*100, 1)) + '%'
        elif (end_value - start_value) < 0:
            return end_value, '▼' + str(round((start_value-end_value)/start_value*100, 1)) + '%'
        else: 
            return end_value, '0%'
    else: 
        return df['Tổng số lượng task hoàn thành'].values[0], '-'




