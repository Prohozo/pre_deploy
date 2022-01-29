import dash
from dash import dcc
from dash import html
from DB import DB_Accounts
from dash.dependencies import Input, Output, State
from utils import GParams_Accounts
from utils import Graph_Accounts
from app import app_Accounts
from datetime import date, timedelta, datetime
from app import app_Accounts


def gen_layout():
    tab_style = {'borderTop': '1px solid #FEA57D',
                 'borderLeft': '1px solid #FEA57D',
                 'borderRight': '1px solid #FEA57D',
                 'borderBottom': '1px solid  #FEA57D',
                 'backgroundColor': '#FEA57D',
                 'color': 'black',
                 'fontWeight': 'bold',
                 'text-align': 'center',
                 'align-items': 'center',
                 'padding': '9px 25px',
                 }

    tab_selected_style = {'borderTop': '1px solid #F07E4F',
                          'borderLeft': '1px solid #F07E4F',
                          'borderRight': '1px solid #F07E4F',
                          'borderBottom': '1px solid  #F07E4F',
                          'backgroundColor': '#F07E4F',
                          'color': 'white',
                          'padding': '9px 25px',
                          }
    layout = html.Div([
        html.Div([
            dcc.Tabs(value='month',
                     children=[
                         dcc.Tab(label='Ngày',
                                 value='day',
                                 children=[
                                     dcc.Graph(id='account_day', style={
                                         'width': '100%', 'height': '100%'}),
                                 ],
                                 style=tab_style,
                                 selected_style=tab_selected_style, className='col-3'),
                         dcc.Tab(label='Tháng',
                                 value='month',
                                 children=[
                                     dcc.Graph(id='account_month', style={
                                         'width': '100%', 'height': '100%'}),
                                 ],
                                 style=tab_style,
                                 selected_style=tab_selected_style, className='col-3'),
                         dcc.Tab(label='Quý',
                                 value='quarter',
                                 children=[
                                     dcc.Graph(id='account_quarter', style={
                                         'width': '100%', 'height': '100%'}),
                                 ],
                                 style=tab_style,
                                 selected_style=tab_selected_style, className='col-3'),
                         dcc.Tab(label='Năm',
                                 value='year',
                                 children=[
                                     dcc.Graph(id='account_year', style={
                                         'width': '100%', 'height': '100%'}),
                                 ],
                                 style=tab_style,
                                 selected_style=tab_selected_style, className='col-3'),
                     ], style={'height': '6vh'}, className='row'),
        ], className='au-card', style={'width': '100%', 'height': '100%'})
    ], className="col-sm-12 col-md-12 col-lg-12 mb-3", style={'height': '63vh'})

    return layout


@app_Accounts.callback(
    Output("account_day", "figure"),
    Output("account_month", "figure"),
    Output("account_quarter", "figure"),
    Output("account_year", "figure"),
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
def UPDATE_OV_ACCOUNT(ddl_timetype, start_date, end_date, ddl_leadsource, ddl_industry, ddl_account, ddl_user_assign, ddl_dept, status, industry, user_assign, user_marketing, user_service, map_city, ac_user_detail, ac_account_detail, ac_city, data_user_detail, data_account_detail, data_city):
    ctx = dash.callback_context
    datatable = {'user_detail': data_user_detail,
                 'account_detail': data_account_detail,
                 'city': data_city,
                 }
    label, value = GParams_Accounts.Get_Value(ctx, datatable)

    df1 = DB_Accounts.GET_ACCOUNTS(('account_day', ddl_timetype, start_date, end_date, ddl_leadsource, ddl_industry,
                                   ddl_account, ddl_user_assign,  None, None,  ddl_dept, None, None, None, None, label, value))
    if ddl_timetype == 0 or ddl_timetype is None:
        figure1 = Graph_Accounts.grh_LineChart(df1['day'], df1['Số lượng khách hàng'], mode='lines+markers',
                                               title='SỐ LƯỢNG KHÁCH HÀNG ĐÃ TẠO THEO NGÀY', margin=[40, 150, 35, 35], color='#FEA57D')
    else:
        figure1 = Graph_Accounts.grh_LineChart(df1['day'], df1['Số lượng khách hàng'], mode='lines+markers',
                                               title='SỐ LƯỢNG KHÁCH HÀNG ĐÃ CHỈNH SỬA THEO NGÀY', margin=[40, 150, 35, 35], color='#FEA57D')

    df2 = DB_Accounts.GET_ACCOUNTS(('account_month', ddl_timetype, start_date, end_date, ddl_leadsource, ddl_industry,
                                   ddl_account, ddl_user_assign,  None, None,  ddl_dept, None, None, None, None, label, value))
    if ddl_timetype == 0 or ddl_timetype is None:
        figure2 = Graph_Accounts.grh_LineChart(df2['month'], df2['Số lượng khách hàng'], mode='lines+markers',
                                               title='SỐ LƯỢNG KHÁCH HÀNG ĐÃ TẠO THEO THÁNG', margin=[40, 150, 35, 35], color='#FEA57D')
    else:
        figure2 = Graph_Accounts.grh_LineChart(df2['month'], df2['Số lượng khách hàng'], mode='lines+markers',
                                               title='SỐ LƯỢNG KHÁCH HÀNG ĐÃ CHỈNH SỬA THEO THÁNG', margin=[40, 150, 35, 35], color='#FEA57D')

    df3 = DB_Accounts.GET_ACCOUNTS(('account_quarter', ddl_timetype, start_date, end_date, ddl_leadsource, ddl_industry,
                                   ddl_account, ddl_user_assign,  None, None,  ddl_dept, None, None, None, None, label, value))
    if ddl_timetype == 0 or ddl_timetype is None:
        figure3 = Graph_Accounts.grh_LineChart(df3['quarter'], df3['Số lượng khách hàng'], mode='lines+markers',
                                               title='SỐ LƯỢNG KHÁCH HÀNG ĐÃ TẠO THEO QUÝ', margin=[40, 150, 35, 35], color='#FEA57D')
    else:
        figure3 = Graph_Accounts.grh_LineChart(df3['quarter'], df3['Số lượng khách hàng'], mode='lines+markers',
                                               title='SỐ LƯỢNG KHÁCH HÀNG ĐÃ CHỈNH SỬA THEO QUÝ', margin=[40, 150, 35, 35], color='#FEA57D')

    df4 = DB_Accounts.GET_ACCOUNTS(('account_year', ddl_timetype, start_date, end_date, ddl_leadsource, ddl_industry,
                                   ddl_account, ddl_user_assign,  None, None,  ddl_dept, None, None, None, None, label, value))
    if ddl_timetype == 0 or ddl_timetype is None:
        figure4 = Graph_Accounts.grh_LineChart(df4['year'], df4['Số lượng khách hàng'], mode='lines+markers',
                                               title='SỐ LƯỢNG KHÁCH HÀNG ĐÃ TẠO THEO NĂM', margin=[40, 150, 35, 35], color='#FEA57D')
    else:
        figure4 = Graph_Accounts.grh_LineChart(df4['year'], df4['Số lượng khách hàng'], mode='lines+markers',
                                               title='SỐ LƯỢNG KHÁCH HÀNG ĐÃ CHỈNH SỬA THEO NĂM', margin=[40, 150, 35, 35], color='#FEA57D')

    return figure1, figure2, figure3, figure4
