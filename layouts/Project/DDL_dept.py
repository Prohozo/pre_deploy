import dash
import dash_core_components as dcc
import dash_html_components as html
from utils import GParams_PJ
from DB import DB_DuAn
from dash.exceptions import PreventUpdate
import datetime as dt

def gen_ddl(id_ddl, placeholder):
    data = DB_DuAn.GET_DDL_dept(('ddl_dept',))
    options = [{'value': data.values[i][0], 'label': data.values[i][1]} for i in range(data.shape[0])]
    # value = options[0]['value'] if id_ddl[4:] == 'VT' else None
    return dcc.Dropdown(
                id=id_ddl,
                options = options,
                placeholder=placeholder
            )

def gen_layout():
    layout =html.Div([
                html.Div([
                    gen_ddl("ddl_dept", "Chọn bộ phận"),
                ],className="col-6"),
                
            ],className="row m-b-15")
    return layout