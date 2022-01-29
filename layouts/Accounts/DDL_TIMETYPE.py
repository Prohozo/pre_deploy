import dash
from dash import dcc
from dash import html
from dash.html import Br
from dash.html import Div
from utils import GParams_Accounts
from DB import DB_Accounts


def gen_layout():

    layout = html.Div([
        dcc.Dropdown(
            id='ddl_timetype',
            options=[
                {'label': 'Ngày tạo', 'value': 0},
                {'label': 'Ngày chỉnh sửa', 'value': 1},
            ],
            value=0,
            placeholder='Chọn loại thời gian',
            style={'height': '55px', 'width': '76%'},
        )
    ], className="col-sm-12 col-md-6 col-lg-3 mb-3", style={'width': '100%'})

    return layout
