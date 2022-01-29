import dash
import dash_core_components as dcc
import dash_html_components as html
from dash_html_components.Br import Br
from dash_html_components.Div import Div
from utils import GParams_UsersCRM
from DB import DB_Users_CRM



def gen_layout():
    
    layout = html.Div([
                dcc.Dropdown(
                    id='ddl_timetype',
                    options=[
                        {'label': 'Ngày tạo', 'value': 0},
                        {'label': 'Ngày chỉnh sửa', 'value': 1},
                    ],
                    value = 0,
                    placeholder='Chọn loại thời gian',
                    style={'height':'55px','width': '99%'},
                    )
                ],className="col-9",style={'width': '100%','padding':'0'})
 
    return layout


