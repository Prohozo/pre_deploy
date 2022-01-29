import dash
from dash import dcc
from dash import html
from dash.html import Br
from dash.html import Div
from utils import GParams_Accounts
from datetime import date
import datetime
from DB import DB_Accounts
from layouts.Accounts import DDL_TIMETYPE, DDL_DATE_RANGE
from app import app_Accounts
from dash.dependencies import Input, Output, State
from utils import GParams_Accounts


def gen_ddl(id_ddl, placeholder, className):
    data = DB_Accounts.GET_DDL_ACCOUNTS(
        (id_ddl, None, None, None, None, None, None, None))
    if id_ddl in ("ddl_account", "ddl_dept", "ddl_user_assign", "ddl_user_marketing", "ddl_user_service"):
        options = [{'value': data.values[i][0], 'label': data.values[i]
                    [1], 'title': data.values[i][1]} for i in range(data.shape[0])]
    else:
        options = [{'value': data.values[i][0], 'label': data.values[i]
                    [0], 'title': data.values[i][0]} for i in range(data.shape[0])]
    return html.Div([
        dcc.Dropdown(
                    id=id_ddl,
                    options=options,
                    placeholder=placeholder,
                    style={'height': '55px'}
                    ),
    ], className=className)


def gen_layout():
    now = datetime.datetime.today().strftime('%Y-%m-%d')
    layout = html.Div([
        html.Div([
            DDL_TIMETYPE.gen_layout(),
            DDL_DATE_RANGE.gen_layout(),
            gen_ddl('ddl_account', "Chọn khách hàng",
                    'col-sm-12 col-md-6 col-lg-2 mb-3'),
            gen_ddl('ddl_leadsource', "Chọn nguồn",
                    "col-sm-12 col-md-6 col-lg-2 mb-3"),
            gen_ddl('ddl_industry', "Chọn lĩnh vực",
                    "col-sm-12 col-md-6 col-lg-2 mb-3"),
        ], className="row ml-2", style={'width': '100%', 'flexWrap': 'wrap'}),

        html.Div([
            html.Div([
                dcc.DatePickerRange(
                    id='date-picker-range',
                    start_date=date(2016, 9, 15),
                    end_date=now,
                    min_date_allowed=date(2019, 7, 13),
                    max_date_allowed=now,
                    day_size=40,
                    clearable=True,
                    display_format='DD/MM/YYYY'),
            ], className="col-sm-12 col-md-6 col-lg-3 mb-3"),
            gen_ddl('ddl_dept', "Chọn phòng ban",
                    "col-sm-12 col-md-6 col-lg-2 mb-3"),
            gen_ddl('ddl_user_assign', "Chọn nhân viên được phân công",
                    'col-sm-12 col-md-6 col-lg-2 mb-3'),
            # gen_ddl('ddl_user_marketing', "Chọn nhân viên marketing",
            #         'col-sm-12 col-md-6 col-lg-2 mb-3'),
            # gen_ddl('ddl_user_service', "Chọn nhân viên giới thiệu",
            #         'col-sm-12 col-md-6 col-lg-2 mb-3'),
        ], className="row ml-2", style={'width': '100%', 'flexWrap': 'wrap'})

    ], className="row", style={'width': '100%', 'flexWrap': 'wrap'})
    return layout


@app_Accounts.callback(
    Output("ddl_account", "options"),
    [
        Input('ddl_leadsource', 'value'),
        Input('ddl_industry', 'value'),
        Input('ddl_dept', 'value'),
        Input('ddl_user_assign', 'value'),
        Input('ddl_user_marketing', 'value'),
        Input('ddl_user_service', 'value'),
    ]
)
def UPDATE_DDL_ACCOUNT(id_leadsource, id_industry, id_dept, id_user_assign, id_user_marketing, id_user_service):
    data = DB_Accounts.GET_DDL_ACCOUNTS(
        ('ddl_account', None, id_leadsource, id_industry, id_dept, id_user_assign, id_user_marketing, id_user_service))
    return [{'value': data.values[i][0], 'label': data.values[i][1], 'title': data.values[i][1]} for i in range(data.shape[0])]


@app_Accounts.callback(
    Output("ddl_leadsource", "options"),
    [
        Input('ddl_account', 'value'),
        Input('ddl_industry', 'value'),
        Input('ddl_dept', 'value'),
        Input('ddl_user_assign', 'value'),
        Input('ddl_user_marketing', 'value'),
        Input('ddl_user_service', 'value'),
    ]
)
def UPDATE_DDL_LEADSOURCE(id_account, id_industry, id_dept, id_user_assign, id_user_marketing, id_user_service):
    data = DB_Accounts.GET_DDL_ACCOUNTS(
        ('ddl_leadsource', id_account, None, id_industry, id_dept, id_user_assign, id_user_marketing, id_user_service))
    return [{'value': data.values[i][0], 'label': data.values[i][0], 'title': data.values[i][0]} for i in range(data.shape[0])]


@app_Accounts.callback(
    Output("ddl_industry", "options"),
    [
        Input('ddl_account', 'value'),
        Input('ddl_leadsource', 'value'),
        Input('ddl_dept', 'value'),
        Input('ddl_user_assign', 'value'),
        Input('ddl_user_marketing', 'value'),
        Input('ddl_user_service', 'value'),
    ]
)
def UPDATE_DDL_INDUSTRY(id_account, id_leadsource, id_dept, id_user_assign, id_user_marketing, id_user_service):
    data = DB_Accounts.GET_DDL_ACCOUNTS(
        ('ddl_industry', id_account, id_leadsource, None, id_dept, id_user_assign, id_user_marketing, id_user_service))
    return [{'value': data.values[i][0], 'label': data.values[i][0], 'title': data.values[i][0]} for i in range(data.shape[0])]


@app_Accounts.callback(
    Output("ddl_dept", "options"),
    [
        Input('ddl_account', 'value'),
        Input('ddl_leadsource', 'value'),
        Input('ddl_industry', 'value'),
        Input('ddl_user_assign', 'value'),
        Input('ddl_user_marketing', 'value'),
        Input('ddl_user_service', 'value'),
    ]
)
def UPDATE_DDL_DEPT(id_account, id_leadsource, id_industry, id_user_assign, id_user_marketing, id_user_service):
    data = DB_Accounts.GET_DDL_ACCOUNTS(
        ('ddl_dept', id_account, id_leadsource, id_industry, None, id_user_assign, id_user_marketing, id_user_service))
    return [{'value': data.values[i][0], 'label': data.values[i][1], 'title': data.values[i][1]} for i in range(data.shape[0])]


@app_Accounts.callback(
    Output("ddl_user_assign", "options"),
    [
        Input('ddl_account', 'value'),
        Input('ddl_leadsource', 'value'),
        Input('ddl_industry', 'value'),
        Input('ddl_dept', 'value'),
        Input('ddl_user_marketing', 'value'),
        Input('ddl_user_service', 'value'),
    ]
)
def UPDATE_DDL_USER_ASSIGN(id_account, id_leadsource, id_industry, id_dept, id_user_marketing, id_user_service):
    data = DB_Accounts.GET_DDL_ACCOUNTS(
        ('ddl_user_assign', id_account, id_leadsource, id_industry, id_dept, None, id_user_marketing, id_user_service))
    return [{'value': data.values[i][0], 'label': data.values[i][1], 'title': data.values[i][1]} for i in range(data.shape[0])]


@app_Accounts.callback(
    Output("ddl_user_marketing", "options"),
    [
        Input('ddl_account', 'value'),
        Input('ddl_leadsource', 'value'),
        Input('ddl_industry', 'value'),
        Input('ddl_dept', 'value'),
        Input('ddl_user_assign', 'value'),
        Input('ddl_user_service', 'value'),
    ]
)
def UPDATE_DDL_USER_MARKETING(id_account, id_leadsource, id_industry, id_dept, id_user_assign, id_user_service):
    data = DB_Accounts.GET_DDL_ACCOUNTS(
        ('ddl_user_marketing', id_account, id_leadsource, id_industry, id_dept, id_user_assign, None, id_user_service))
    return [{'value': data.values[i][0], 'label': data.values[i][1], 'title': data.values[i][1]} for i in range(data.shape[0])]


@app_Accounts.callback(
    Output("ddl_user_service", "options"),
    [
        Input('ddl_account', 'value'),
        Input('ddl_leadsource', 'value'),
        Input('ddl_industry', 'value'),
        Input('ddl_dept', 'value'),
        Input('ddl_user_assign', 'value'),
        Input('ddl_user_marketing', 'value'),
    ]
)
def UPDATE_DDL_USER_SERVICE(id_account, id_leadsource, id_industry, id_dept, id_user_assign, id_user_marketing):
    data = DB_Accounts.GET_DDL_ACCOUNTS(
        ('ddl_user_service', id_account, id_leadsource, id_industry, id_dept, id_user_assign, id_user_marketing, None))
    return [{'value': data.values[i][0], 'label': data.values[i][1], 'title': data.values[i][1]} for i in range(data.shape[0])]
