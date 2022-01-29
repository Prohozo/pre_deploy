import dash
import dash_core_components as dcc
import dash_html_components as html
from layouts.Task.DETAIL_task_assign import gen_layout as assign
from layouts.Task.DETAIL_task_finish import gen_layout as finish
from layouts.Task.DETAIL_task_open import gen_layout as open
from dash.dependencies import Input, Output, State
from layouts.Task.GEN_BUTTON import create_button
from app import app_Task
from utils import Graph_Task, GParams_Task
from DB import DB_Task
import pandas as pd


def gen_layout():
    tab_style = {
        'borderBottom': '1px solid #d6d6d6',
        'color': 'black',
        'background-color': 'white',
        'border-left': '1px solid #E5E5E5',
        'text-align': 'center',
        'padding': '9px 25px'
    }

    tab_selected_style = {
        'borderTop': '1px solid #60B664',
        'borderBottom': '1px solid #60B664',
        'backgroundColor': '#60B664',
        'color': 'white',
        'fontWeight': 'bold',
        'text-align': 'center',
        'padding': '9px 25px'
        
    }
    layout = html.Div([
        html.Div([
            dcc.Tabs([
                dcc.Tab(
                    label='ĐƯỢC TẠO CHI TIẾT',
                    children=[open()],
                    style=tab_style, selected_style=tab_selected_style, className='col-4'
                ),
                dcc.Tab(
                    label='HOÀN THÀNH CHI TIẾT',
                    children=[finish()],
                    style=tab_style, selected_style=tab_selected_style, className='col-4'
                ),
                dcc.Tab(
                    label='ĐÃ GIAO CHI TIẾT',
                    children=[assign()],
                    style=tab_style, selected_style=tab_selected_style, className='col-4'
                ),
            ], style={'height': '5vh', 'align-items': 'center'}, className='row')
        ], className='au-card', style={'width': '100%', 'height': '100%'})
    ], className="col-sm-12 col-md-12 col-lg-12 mb-3", style={'height': '100%'})

    return layout
