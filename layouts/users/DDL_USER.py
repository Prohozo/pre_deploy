import dash
import dash_core_components as dcc
import dash_html_components as html
from dash_html_components.Div import Div
from utils import GParams_User as GParams
from DB import DB_User
from datetime import date
import datetime
from layouts.users import DDL_DATE_RANGE
from app import app_User
from dash.dependencies import Input, Output, State

def gen_ddl(id_ddl,placeholder,className):
    data = DB_User.GET_DDL_USER((id_ddl,None,None,None))
    options = [{'value': data.values[i][0], 'label': data.values[i][1], 'title': data.values[i][1]} for i in range(data.shape[0])]
    return  html.Div([
                dcc.Dropdown(
                    id=id_ddl,
                    options = options,
                    placeholder=placeholder,
                    style ={'height':'50px'}                 
                ),
            ], className=className)    

def gen_layout():
    now = datetime.datetime.today().strftime('%Y-%m-%d')
    layout = html.Div([
                    html.Div([                        
                        html.Div([
                            dcc.DatePickerRange(
                            id = 'date-picker-range',
                            start_date = date(2019,7,13),
                            end_date = now,
                            min_date_allowed = date(2019,7,13),
                            max_date_allowed = now,
                            day_size = 40,
                            clearable=True,
                            display_format = 'DD/MM/YYYY'),
                        ],className="col-sm-12 col-md-12 col-lg-4 mb-3"),
                        DDL_DATE_RANGE.gen_layout(),
                    ],className="row ml-1",style={'width':'100%','flexWrap':'wrap'}),

                    html.Div([
                        gen_ddl('ddl_project',"Chọn dự án","col-sm-12 col-md-12 col-lg-4 mb-3"),
                        gen_ddl('ddl_dept',"Chọn phòng ban","col-sm-12 col-md-12 col-lg-4 mb-3"),
                        gen_ddl('ddl_user',"Chọn nhân viên","col-sm-12 col-md-12 col-lg-4 mb-3"),
                    ],className="row ml-1",style={'width':'100%','flexWrap':'wrap'})
                    
                    
    ],className="row",style={'width':'100%','flexWrap':'wrap'})
    return layout


@app_User.callback(
    Output("ddl_user","options"),
    [
    Input('ddl_project','value'),
    Input('ddl_dept','value'),
    
    ],
    

)
def UPDATE_DDL_USER(id_project,id_dept):
    data = DB_User.GET_DDL_USER(('ddl_user',id_project,None,id_dept))
    return [{'value': data.values[i][0], 'label': data.values[i][1], 'title': data.values[i][1]} for i in range(data.shape[0])]


@app_User.callback(
    Output("ddl_dept","options"),
    [
    Input('ddl_project','value'),
    Input('ddl_user','value'),
    
    ],

)
def UPDATE_DDL_DEPT(id_project,id_user):
    data = DB_User.GET_DDL_USER(('ddl_dept',id_project,id_user,None))
    return [{'value': data.values[i][0], 'label': data.values[i][1], 'title': data.values[i][1]} for i in range(data.shape[0])]


@app_User.callback(
    Output("ddl_project","options"),
    [
    Input('ddl_dept','value'),
    Input('ddl_user','value'),
    
    ],

)
def UPDATE_DDL_PROJECT(id_dept,id_user):
    data = DB_User.GET_DDL_USER(('ddl_project',None,id_user,id_dept))
    return [{'value': data.values[i][0], 'label': data.values[i][1], 'title': data.values[i][1]} for i in range(data.shape[0])]