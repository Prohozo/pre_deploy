# FILE CHÍNH, tổng hợp các file layout của từng biểu đồ
from layouts.Accounts.DDL_TIMETYPE import gen_layout
from dash import dcc
from dash import html
import datetime

from dash.html import Div
from app import app_Accounts
from index_string import index_str
from DB import DB_Accounts
import datetime
from datetime import date
from index_string import index_str
from dash.dependencies import Input, Output, State
from layouts.Accounts import DDL_TIMETYPE, DDL_ACCOUNTS, DDL_DATE_RANGE, OV_ACCOUNT, OV_POTENTIAL, OV_CONTACT, OV_SALESORDER, BAR_STATUS, PARETO_INDUSTRY, BAR_USER, TABLE_USER_DETAIL, TABLE_ACCOUNT_DETAIL, TABLE_CITY, LINE_ACCOUNT_TIME, MAP_CITY


app_Accounts.index_string = index_str


def render_layout():

    layout = html.Div([

        DDL_ACCOUNTS.gen_layout(),

        # OVERVIEW
        html.Div([
            OV_ACCOUNT.gen_layout(),
            OV_POTENTIAL.gen_layout(),
            OV_SALESORDER.gen_layout(),
            OV_CONTACT.gen_layout(),

        ], className='row ml-1'),


        # html.Br(),
        # html.Div([

        #     BAR_STATUS.gen_layout(),
        #     PARETO_INDUSTRY.gen_layout(),

        # ], className='row'),

        # html.Div([
        #     BAR_USER.gen_layout(),
        #     TABLE_USER_DETAIL.gen_layout(),

        # ], className='row'),

        # html.Div([
        #     LINE_ACCOUNT_TIME.gen_layout(),

        # ], className='row'),


        # html.Div([
        #     MAP_CITY.gen_layout(),
        #     TABLE_CITY.gen_layout(),
        # ], className='row'),

        # html.Div([
        #     TABLE_ACCOUNT_DETAIL.gen_layout(),
        # ], className='row'),



    ], className="section__content--p30", style={'backgroundColor': '##E5E5E5'})
    return layout


app_Accounts.layout = render_layout()


if __name__ == '__main__':
    app_Accounts.run_server()
    # host = '192.168.1.239', port = ''
