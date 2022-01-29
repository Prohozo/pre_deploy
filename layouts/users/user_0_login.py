import dash
import dash_core_components as dcc
import dash_html_components as html
import dash_table
import urllib.parse
import pandas as pd
from static.system_dashboard.css import css_define as css
from dash_table.Format import Format, Scheme
from DB import DB_User
from dash.dependencies import Input, Output, State
from utils import GParams_User as GParams
from utils import Graph_User as Graph
from app import app_User


def gen_layout():

    layout =html.Div([
                        html.Div([
                            html.Div([
                                html.Div("NHÂN VIÊN KHÔNG LOGIN", style={'width':'100%','fontWeight': 'bold','background': '#FF938B'}),
                                html.A(
                                    children=[
                                        html.I(className="fas fa-file-download")
                                    ],
                                    id='download_user_withoutlog',
                                    download="DETAIL_USERS_WITHOUT_LOGIN.csv",
                                    target="_blank",
                                    href = '',
                                    className='btn btn-primary',
                                    style={'position':'absolute','top':'0','right':'0','paddingTop':'0','paddingBottom':'0','marginTop': '2%','marginRight':'3%','height': '50%','display': 'inline-grid','alignItems': 'center','backgroundColor':'#FF938B','borderColor':'#FF938B'}),
                            ], style={'height': '10%','width':'100%','background': '#FF938B','textAlign':'center','display':'inline-grid','alignItems':'center','position':'relative'}),
                            dash_table.DataTable(
                                id='user_0_login',
                                columns=[
                                    {
                                        'name': 'Nhân viên', 
                                        'id': 'u.account',
                                    },
                                ],
                                style_cell_conditional=[
                                    {
                                        'if': {'column_id': 'u.account'},
                                        'width': '20%',
                                        'vertical-align': 'text-top',

                                    },
                                ],
                                
                                css=[
                                        {
                                            'selector': '.dash-fixed-content',
                                            'rule': 'width: 100%;'
                                        }
                                    ],
                                fixed_rows={'headers': True},
                                style_header=css.style_header,
                                style_cell=css.style_cell,
                                page_action='none',
                                style_table={'height': '100%','width':'100%'},
                                sort_action="native",
                                # sort_mode="multi",
                            )
                        ], className="au-card",style={'height':'100%'})
                    ],className="col-sm-6 col-md-6 col-lg-3 mb-3",style={'height':'60vh'})

    return layout

@app_User.callback(
    Output("user_0_login", "data"),
    [Input('date-picker-range','start_date'),
    Input('date-picker-range','end_date'),
    Input('ddl_project','value'),
    Input('ddl_user','value'),
    Input('ddl_dept','value'),
    ],
    [
    State('user_0_login','data'),], 

)

def UPDATE_user_0_login(start_date,end_date,ddl_project,ddl_user,ddl_dept,data_nolog):
    ctx = dash.callback_context
    datatable = {
                 'user_0_login': data_nolog}
    label, value = GParams.Get_Value(ctx,datatable)
    df =DB_User.GET_USER(('user_0_login',start_date,end_date,ddl_project,ddl_user,ddl_dept,label,value,None,None,None,None))
    if df.empty:
        if start_date != end_date:
            dff = pd.DataFrame({'u.account':['Chỉ lọc theo từng ngày']})
            return dff.to_dict(orient='records')
        else: 
            dff = pd.DataFrame({'u.account':['Không có ai']})
            return dff.to_dict(orient='records')
    else:
        return df.to_dict(orient='records')

@app_User.callback(
    Output('download_user_withoutlog', 'href'),
    [Input('download_user_withoutlog', 'n_clicks'),
     Input('user_0_login', 'data')]
)
def UPDATE_DOWNLOAD(click, data):
    df = pd.DataFrame.from_dict(data)

    csv_string = df.to_csv(index=False, encoding='utf-8', header=['Tên nhân viên'])
    csv_string = "data:text/csv;charset=utf-8,%EF%BB%BF" + urllib.parse.quote(csv_string)
    return csv_string