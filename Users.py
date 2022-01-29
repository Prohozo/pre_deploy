from layouts.Accounts.BAR_STATUS import gen_layout
import dash
import dash_core_components as dcc
import dash_html_components as html
from dash_html_components.Div import Div
from app import app_User
import datetime
from datetime import date
from DB import DB_User
from index_string import index_str
from dash.dependencies import Input, Output, State
from layouts.users import DDL_USER, OV_NV, OV_TASK, OV_TASKDONE, SL_TASKOPENED, SL_TASKDONE, SL_TASKDONE_TT, SL_TASKOPENED_TG, SL_TASKDONE_TG, SL_PROJECT, DETAIL_PROJECT, PRODUCTIVITY, DDL_DATE_RANGE, OV_TASKDONE_PERCENTAGE, OV_TASKDONE_BYOPENEDBY, OV_TASKDONE_BYOTHERS, user_0_task, SL_TASKSTARTED, user_0_login, SL_PROJECT_TASK_BAR, DETAIL_PROJECT_TASK, DETAIL_USER_WORKLOAD


app_User.index_string = index_str


def render_layout():
    now = datetime.datetime.today().strftime('%Y-%m-%d')
    layout = layout = html.Div([

        DDL_USER.gen_layout(),

        html.Div([
            OV_NV.gen_layout(),
            OV_TASK.gen_layout(),
            OV_TASKDONE.gen_layout(),

        ], className='row ml-1'),

        html.Div([
            OV_TASKDONE_PERCENTAGE.gen_layout(),
            OV_TASKDONE_BYOPENEDBY.gen_layout(),
            OV_TASKDONE_BYOTHERS.gen_layout(),

        ], className='row ml-1'),

        html.Div([
            SL_PROJECT.gen_layout(),
            DETAIL_PROJECT.gen_layout(),


        ], className='row'),

        html.Div([
            SL_PROJECT_TASK_BAR.gen_layout(),
            DETAIL_PROJECT_TASK.gen_layout(),

        ], className='row'),

        html.Div([

            DETAIL_USER_WORKLOAD.gen_layout(),

        ], className='row'),
        html.Div([
            SL_TASKSTARTED.gen_layout(),
            user_0_task.gen_layout(),
            user_0_login.gen_layout(),

        ], className='row'),

        html.Div([
            SL_TASKOPENED.gen_layout(),
            SL_TASKDONE.gen_layout(),
        ], className='row'),


        html.Div([
            SL_TASKDONE_TT.gen_layout(),
            PRODUCTIVITY.gen_layout(),
        ], className='row'),

        html.Div([
            SL_TASKOPENED_TG.gen_layout(),
            SL_TASKDONE_TG.gen_layout(),
        ], className='row'),

    ], className="section__content--p30", style={'backgroundColor': '##E5E5E5'})

    return layout


app_User.layout = render_layout


if __name__ == '__main__':
    app_User.run_server(debug=True)
    # app_User.run_server(debug=True)
