import dash
from dash import dcc
from dash import html
from DB import DB_Accounts
from dash.dependencies import Input, Output, State
from utils import Graph_Accounts, GParams_Accounts
from static.system_dashboard.css import css_define as css
import pandas as pd
from app import app_Accounts


def gen_layout():

    layout = html.Div([
        html.Div([
            dcc.Graph(id="grh_bar_status", style={
                      'width': '100%', 'height': '100%'})
        ], className='au-card', style={'width': '100%', 'height': '100%'})
    ], className="col-sm-12 col-md-6 col-lg-6 mb-3", style={'height': '55vh'})

    return layout


@app_Accounts.callback(
    Output("grh_bar_status", "figure"),
    [Input('ddl_timetype', 'value'),
     Input('date-picker-range', 'start_date'),
     Input('date-picker-range', 'end_date'),
     Input('ddl_leadsource', 'value'),
     Input('ddl_industry', 'value'),
     Input('ddl_account', 'value'),
     Input('ddl_user_assign', 'value'),
     # Input('ddl_user_marketing', 'value'),
     # Input('ddl_user_service', 'value'),
     Input('ddl_dept', 'value'),
     Input('grh_bar_status', 'selectedData'),
     Input('grh_parento_industry', 'clickData'),
     Input('grh_bar_user_assign', 'selectedData'),
     Input('grh_bar_user_marketing', 'selectedData'),
     Input('grh_bar_user_service', 'selectedData'),
     Input('grh_map_city', 'clickData'),
     Input('user_detail', 'active_cell'),
     Input('account_detail', 'active_cell'),
     Input('city', 'active_cell')
     ],
    [State('user_detail', 'data'),
     State('account_detail', 'data'),
     State('city', 'data')]

)
def UPDATE_STATUS(ddl_timetype, start_date, end_date, ddl_leadsource, ddl_industry, ddl_account, ddl_user_assign, ddl_dept, status, industry, map_city, user_assign, user_marketing, user_service, ac_user_detail, ac_account_detail, ac_city, data_user_detail, data_account_detail, data_city):
    ctx = dash.callback_context
    datatable = {'user_detail': data_user_detail,
                 'account_detail': data_account_detail,
                 'city': data_city,
                 }
    label, value = GParams_Accounts.Get_Value(ctx, datatable)
    df = DB_Accounts.GET_ACCOUNTS(('bar_status', ddl_timetype, start_date, end_date, ddl_leadsource, ddl_industry,
                                  ddl_account, ddl_user_assign,  None, None,  ddl_dept, None, None, None, None, label, value))

    return Graph_Accounts.grh_BarChart(df['Tr???ng th??i'], df['S??? l?????ng kh??ch h??ng'], label_x='TR???NG TH??I', label_y='S??? L?????NG KH??CH H??NG', marker_color=['#FFDC7D', '#FFDC7D'], title='S??? L?????NG KH??CH H??NG THEO TR???NG TH??I', margin=[50, 150, 60, 35])
