import dash
import dash_core_components as dcc
import dash_html_components as html
from dash_html_components.Br import Br
from dash_html_components.Div import Div
from utils import GParams_UsersCRM
from DB import DB_Users_CRM
from datetime import date
import datetime
from layouts.Users_CRM import DDL_TIMETYPE,DDL_DATE_RANGE
from app import app_UsersCRM
from dash.dependencies import Input, Output, State

def gen_ddl(id_ddl,placeholder,className):
    data = DB_Users_CRM.GET_DDL_USERSCRM((id_ddl,None,None,None))
    if id_ddl in ("ddl_account","ddl_dept","ddl_user_assign"):
        options = [{'value': data.values[i][0], 'label': data.values[i][1], 'title': data.values[i][1]} for i in range(data.shape[0])]
    else:
        options = [{'value': data.values[i][0], 'label': data.values[i][0], 'title': data.values[i][0]} for i in range(data.shape[0])]
    return  html.Div([
                dcc.Dropdown(
                    id=id_ddl,
                    options = options,
                    placeholder=placeholder,
                    style ={'height':'55px'}                 
                ),
            ], className=className)    

def gen_layout():
    now = datetime.datetime.today().strftime('%Y-%m-%d')
    layout = html.Div([
                html.Div([
                            dcc.DatePickerRange(
                            id = 'date-picker-range',
                            start_date = date(2011,1,1),
                            end_date = now,
                            min_date_allowed = date(2011,1,1),
                            max_date_allowed = now,
                            day_size = 40,
                            clearable=True,
                            display_format = 'DD/MM/YYYY'),   
                        ],className="col-sm-12 col-md-6 col-lg-4 mb-3"),
                        DDL_DATE_RANGE.gen_layout(),
                        gen_ddl('ddl_account',"Chọn khách hàng",'col-sm-12 col-md-6 col-lg-2 mb-3'),
                        gen_ddl('ddl_dept',"Chọn phòng ban","col-sm-12 col-md-6 col-lg-2 mb-3"),
                        gen_ddl('ddl_user_assign',"Chọn nhân viên được phân công","col-sm-12 col-md-6 col-lg-2 mb-3"),
                    ],className="row")
            
    return layout

@app_UsersCRM.callback(
    Output("ddl_user_assign","options"),
    [
    Input('ddl_account','value'),
    Input('ddl_dept','value'),
    
    ],
    

)
def UPDATE_DDL_USER_ASSIGN(id_account,id_dept):
    data = DB_Users_CRM.GET_DDL_USERSCRM(('ddl_user_assign',id_account,id_dept,None))
    return [{'value': data.values[i][0], 'label': data.values[i][1], 'title': data.values[i][1]} for i in range(data.shape[0])]


@app_UsersCRM.callback(
    Output("ddl_dept","options"),
    [
    Input('ddl_account','value'),
    Input('ddl_user_assign','value'),
    
    ],

)
def UPDATE_DDL_DEPT(id_account,id_user):
    data = DB_Users_CRM.GET_DDL_USERSCRM(('ddl_dept',id_account,None,id_user))
    return [{'value': data.values[i][0], 'label': data.values[i][1], 'title': data.values[i][1]} for i in range(data.shape[0])]


@app_UsersCRM.callback(
    Output("ddl_account","options"),
    [
    Input('ddl_dept','value'),
    Input('ddl_user_assign','value'),
    
    ],

)
def UPDATE_DDL_ACCOUNT(id_dept,id_user):
    data = DB_Users_CRM.GET_DDL_USERSCRM(('ddl_account',None,id_dept,id_user))
    return [{'value': data.values[i][0], 'label': data.values[i][1], 'title': data.values[i][1]} for i in range(data.shape[0])]