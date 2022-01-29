# FILE CHÍNH, tổng hợp các file layout của từng biểu đồ
from layouts.Accounts.DDL_TIMETYPE import gen_layout
import dash_core_components as dcc
import dash_html_components as html
import datetime

from dash_html_components.Div import Div
from app import app_UsersCRM
from index_string import index_str
from DB import Data_Users_CRM
import datetime
from datetime import date
from index_string import index_str
from dash.dependencies import Input, Output, State
from layouts.Users_CRM import DDL_TIMETYPE, DDL_ACCOUNTS, DDL_DATE_RANGE, OV_USERS, OV_SALESORDER, OV_ACTIVITY, OV_TASK_CREATED, OV_TASK_FINISHED, OV_TASK_DELAY, PARETO_SALESORDER, BAR_TASK_CREATED, BAR_TASK_FINISHED, LINE_ACTIVITY_TIME, TABLE_USER_WITHOUT_ACTIVITY, TABLE_USER_ACTIVITY_DETAIL, LINE_PRODUCTIVITY, TABLE_TASK_DELAY_DETAIL, TABLE_USER_WITHOUT_LOGIN


app_UsersCRM.index_string = index_str


def render_layout():
    now = datetime.datetime.today().strftime('%Y-%m-%d')
    layout = html.Div([
        DDL_ACCOUNTS.gen_layout(),

        html.Br(),

        # OVERVIEW
        html.Div([
            OV_USERS.gen_layout(),
            OV_SALESORDER.gen_layout(),
            OV_ACTIVITY.gen_layout(),
        ], style={}, className='row ml-1'),

        html.Div([
            OV_TASK_CREATED.gen_layout(),
            OV_TASK_FINISHED.gen_layout(),
            OV_TASK_DELAY.gen_layout(),
        ], style={}, className='row ml-1'),
        html.Br(),

        html.Div([
            PARETO_SALESORDER.gen_layout(),
            LINE_PRODUCTIVITY.gen_layout(),
        ], className='row'),

        html.Br(),
        html.Div([
            BAR_TASK_CREATED.gen_layout(),
            BAR_TASK_FINISHED.gen_layout(),
        ], className='row'),
        html.Br(),

        html.Div([
            LINE_ACTIVITY_TIME.gen_layout(),
        ], className='row'),
        html.Br(),

        html.Div([
            TABLE_TASK_DELAY_DETAIL.gen_layout(),
            TABLE_USER_WITHOUT_LOGIN.gen_layout(),
            TABLE_USER_WITHOUT_ACTIVITY.gen_layout(),
        ], className='row'),
        html.Br(),

        html.Div([
            TABLE_USER_ACTIVITY_DETAIL.gen_layout(),
        ], className='row'),
        html.Br(),

        html.Div([

        ], className='row'),



    ], className="section__content--p30", style={'backgroundColor': '##E5E5E5'})
    return layout


app_UsersCRM.layout = render_layout()


if __name__ == '__main__':
    app_UsersCRM.run_server(debug=True)
    # host = '192.168.1.234', port = '5555'
    # host = '192.168.1.234', port = '5555'
    # host='192.168.1.234', port='5000'
