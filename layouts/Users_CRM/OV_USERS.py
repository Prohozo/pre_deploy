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

def gen_layout():

    title = 'SỐ LƯỢNG NHÂN VIÊN'
    color = 'linear-gradient(50deg, rgba(44,199,190,1) 0%, rgba(80,118,255,1) 100%)'
    icon = 'user_crm(1).svg'
    layout = create_card(title,'ov_user',color,icon)
           
    return layout

@app_UsersCRM.callback(
    Output("ov_user","children"),
    [Input('date-picker-range','start_date'),
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

def UPDATE_OV_USER(start_date,end_date,ddl_account,ddl_user_assign,ddl_dept,salesorder,task_created,task_finished,ac_withoutactivity,ac_task_delay,ac_activity_detail,ac_without_login,data_withoutactivity,data_task_delay,data_activity_detail,data_without_login):
    ctx = dash.callback_context
    datatable = {'user_without_activity': data_withoutactivity, 
                'user_task_delay': data_task_delay,
                'user_activity_detail':data_activity_detail,
                'user_without_login':data_without_login
                }
    label, value = GParams_UsersCRM.Get_Value(ctx,datatable)
    df = DB_Users_CRM.GET_USERSCRM(('ov_user',start_date,end_date,ddl_account,ddl_user_assign,ddl_dept,label,value))
    return df['Tổng số lượng nhân viên'].values[0]



