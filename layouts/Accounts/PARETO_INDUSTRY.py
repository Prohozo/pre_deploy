import dash
from dash import dcc
from dash import html
from DB import DB_Accounts
from dash.dependencies import Input, Output, State
from utils import GParams_Accounts
from utils import Graph_Accounts
from static.system_dashboard.css import css_define as css
import pandas as pd
from app import app_Accounts


def gen_layout():

    layout = html.Div([
        html.Div([
            html.Div([
                html.Button(
                    html.I(className='fas fa-sync-alt'),
                    id='btn_R',
                    style={'paddingBottom': '0 !important', 'paddingTop': '0 !important', 'marginTop': '1%',
                           'marginLeft': '90%', 'backgroundColor': '#FFDC7D', 'borderColor': '#FFDC7D'},
                    className='btn_in_title btn btn-primary col-1')
            ], style={'height': '5%', 'width': '100%', 'backgroundColor': 'white', 'display': 'flex', 'justifyContent': 'end'}),
            dcc.Graph(id="grh_parento_industry", style={
                      'width': '100%', 'height': '100%'})
        ], className='au-card', style={'width': '100%', 'height': '100%'})
    ], className="col-sm-12 col-md-6 col-lg-6 mb-3", style={'height': '55vh'})

    return layout


@app_Accounts.callback(
    Output("grh_parento_industry", "clickData"),
    [Input('btn_R', 'n_clicks')]
)
def reset_dt_bp(rs):
    return None


@app_Accounts.callback(
    Output("grh_parento_industry", "figure"),
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
def UPDATE_INDUSTRY(ddl_timetype, start_date, end_date, ddl_leadsource, ddl_industry, ddl_account, ddl_user_assign, ddl_dept, status, industry, user_assign, user_marketing, user_service, map_city, ac_user_detail, ac_account_detail, ac_city, data_user_detail, data_account_detail, data_city):
    ctx = dash.callback_context
    datatable = {'user_detail': data_user_detail,
                 'account_detail': data_account_detail,
                 'city': data_city,
                 }
    label, value = GParams_Accounts.Get_Value(ctx, datatable)
    df = DB_Accounts.GET_ACCOUNTS(('industry', ddl_timetype, start_date, end_date, ddl_leadsource, ddl_industry, ddl_account,
                                  ddl_user_assign,  None, None,  ddl_dept, None, None, None, None, label, value))
    df['cumulative_sum'] = df['Số lượng khách hàng'].cumsum()
    df['cumulative_perc'] = round(
        df['cumulative_sum']/df['Số lượng khách hàng'].sum()*100, 2)

    if df.empty:
        df = pd.DataFrame({'Lĩnh vực': ['Không có giá trị'], 'Số lượng khách hàng': [
                          0], 'cumulative_sum': [0], 'cumulative_perc': [0]})
    return Graph_Accounts.grh_ParetoChart(df['Lĩnh vực'], df['Số lượng khách hàng'], df['Lĩnh vực'], df['cumulative_perc'], label_x='LĨNH VỰC', label_y='SỐ LƯỢNG KHÁCH HÀNG', marker_color=['#FFDC7D', '#FFDC7D'], color_line='#F2807D', mode='lines+markers', title='SỐ LƯỢNG KHÁCH HÀNG THEO LĨNH VỰC', margin=[50, 170, 52, 55], customdata=[i+1 for i in df.index.values])
