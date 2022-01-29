import dash
import dash_core_components as dcc
import dash_html_components as html
import dash_table
import urllib.parse
import pandas as pd
from static.system_dashboard.css import css_define as css
from dash_table.Format import Format, Scheme
from DB import DB_Users_CRM
from dash.dependencies import Input, Output, State
from utils import GParams_UsersCRM
from utils import Graph_UsersCRM
from app import app_UsersCRM


def gen_layout():

    layout =html.Div([
                        html.Div([
                            html.Div([
                                html.Div("NHÂN VIÊN KHÔNG LOGIN", style={'width':'100%','fontWeight': 'bold','background': '#E34A44','color':'white'}),
                                html.A(
                                    children=[
                                        html.I(className="fas fa-file-download")
                                    ],
                                    id='download_user_without_login',
                                    download="DETAIL_USERS_WITHOUT_LOGIN_CRM.csv",
                                    target="_blank",
                                    href = '',
                                    className='btn btn-primary',
                                    style={'position':'absolute','top':'0','right':'0','paddingTop':'0','paddingBottom':'0','marginTop': '2%','marginRight':'3%','height': '50%','display': 'inline-grid','alignItems': 'center','backgroundColor':'#E34A44','borderColor':'#E34A44'}),
                            ], style={'height': '10%','width':'100%','background': '#E34A44','textAlign':'center','display':'inline-grid','alignItems':'center','position':'relative'}),
                            dash_table.DataTable(
                                id='user_without_login',
                                columns=[
                                    {
                                        'name': 'Nhân viên', 
                                        'id': 'u.user_name',
                                    },
                                ],
                                style_cell_conditional=[
                                    {
                                        'if': {'column_id': 'u.user_name'},
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
                    ], className="col-sm-12 col-md-12 col-lg-3 mb-3",style={'height':'68vh'})

    return layout

@app_UsersCRM.callback(
    Output("user_without_login", "data"),
    [Input('date-picker-range','start_date'),
    Input('date-picker-range','end_date'),
    Input('ddl_account','value'),
    Input('ddl_user_assign','value'),
    Input('ddl_dept','value'),
    ],
    [
    State('user_without_login','data'),], 

)

def UPDATE_user_without_login(start_date,end_date,ddl_account,ddl_user_assign,ddl_dept,data_without_log):
    ctx = dash.callback_context
    datatable = {
                 'user_without_login': data_without_log}
    label, value = GParams_UsersCRM.Get_Value(ctx,datatable)
    df =DB_Users_CRM.GET_USERSCRM(('without_login',start_date,end_date,ddl_account,ddl_user_assign,ddl_dept,label,value))
    if df.empty:
        if start_date != end_date:
            dff = pd.DataFrame({'u.user_name':['Chỉ lọc theo từng ngày']})
            return dff.to_dict(orient='records')
        else: 
            dff = pd.DataFrame({'u.user_name':['Không có ai']})
            return dff.to_dict(orient='records')
    else:
        return df.to_dict(orient='records')

@app_UsersCRM.callback(
    Output('download_user_without_login', 'href'),
    [Input('download_user_without_login', 'n_clicks'),
     Input('user_without_login', 'data')]
)
def UPDATE_DOWNLOAD(click, data):
    df = pd.DataFrame.from_dict(data)

    csv_string = df.to_csv(index=False, encoding='utf-8', header=['Tên nhân viên'])
    csv_string = "data:text/csv;charset=utf-8,%EF%BB%BF" + urllib.parse.quote(csv_string)
    return csv_string