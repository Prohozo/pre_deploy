import dash
from dash import dcc
from dash import html
from DB import DB_Accounts
from dash.dependencies import Input, Output, State
from utils import GParams_Accounts
from utils import Graph_Accounts
from app import app_Accounts


def gen_layout():
    tab_style = {'borderTop': '1px solid #7DC383',
                 'borderLeft': '1px solid #7DC383',
                 'borderRight': '1px solid #7DC383',
                 'borderBottom': '1px solid  #7DC383',
                 'backgroundColor': '#7DC383',
                 'color': 'black',
                 'fontWeight': 'bold',
                 'text-align': 'center',
                 'align-items': 'center',
                 'padding': '9px 25px',
                 }

    tab_selected_style = {'borderTop': '1px solid #78BB7B',
                          'borderLeft': '1px solid #78BB7B',
                          'borderRight': '1px solid #78BB7B',
                          'borderBottom': '1px solid  #78BB7B',
                          'backgroundColor': '#78BB7B',
                          'color': 'white',
                          'padding': '9px 25px',
                          }
    layout = html.Div([
        html.Div([
            dcc.Tabs(value='assign',
                     children=[
                         dcc.Tab(label='NV phân công',
                                 value='assign',
                                 children=[
                                     dcc.Graph(id='grh_bar_user_assign', style={
                                         'width': '100%', 'height': '100%'}),
                                 ],
                                 style=tab_style,
                                 selected_style=tab_selected_style, className='col-12'),
                         #  dcc.Tab(label='NV marketing',
                         #          value='marketing',
                         #          children=[
                         #              dcc.Graph(id='grh_bar_user_marketing', style={
                         #                  'width': '100%', 'height': '100%'}),
                         #          ],
                         #          style=tab_style,
                         #          selected_style=tab_selected_style, className='col-4'),
                         #  dcc.Tab(label='NV giới thiệu',
                         #          value='service',
                         #          children=[
                         #              dcc.Graph(id='grh_bar_user_service', style={
                         #                  'width': '100%', 'height': '100%'}),
                         #          ],
                         #          style=tab_style,
                         #          selected_style=tab_selected_style, className='col-4'),
                     ], style={'height': '6vh'}, className='row'),
        ], className='au-card', style={'width': '100%', 'height': '100%'})
    ], className="col-sm-12 col-md-6 col-lg-6 mb-3", style={'height': '63vh'})

    return layout


@app_Accounts.callback(
    Output("grh_bar_user_assign", "figure"),
    Output("grh_bar_user_marketing", "figure"),
    Output("grh_bar_user_service", "figure"),
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
def UPDATE_USER(ddl_timetype, start_date, end_date, ddl_leadsource, ddl_industry, ddl_account, ddl_user_assign,  ddl_dept, status, industry, user_assign, user_marketing, user_service, map_city, ac_user_detail, ac_account_detail, ac_city, data_user_detail, data_account_detail, data_city):
    ctx = dash.callback_context
    datatable = {'user_detail': data_user_detail,
                 'account_detail': data_account_detail,
                 'city': data_city,
                 }
    label, value = GParams_Accounts.Get_Value(ctx, datatable)

    df1 = DB_Accounts.GET_ACCOUNTS(('user_assign', ddl_timetype, start_date, end_date, ddl_leadsource, ddl_industry,
                                   ddl_account, ddl_user_assign,  None, None,  ddl_dept, None, None, None, None, label, value))
    figure1 = Graph_Accounts.grh_BarChart(df1['Nhân viên'], df1['Số lượng khách hàng'], marker_color=[
                                          '#67F5B4', '#67F5B4'], title='SỐ LƯỢNG KHÁCH HÀNG THEO NHÂN VIÊN ĐƯỢC PHÂN CÔNG', height=600, margin=[30, 280, 35, 35], customdata=df1['c.smownerid'])

    # df2 = DB_Accounts.GET_ACCOUNTS(('user_marketing', ddl_timetype, start_date, end_date, ddl_leadsource, ddl_industry,
    #                                ddl_account, ddl_user_assign,  None, None,  ddl_dept, None, None, None, None, label, value))
    # figure2 = Graph_Accounts.grh_BarChart(df2['Nhân viên'], df2['Số lượng khách hàng'], marker_color=[
    #                                       '#67F5B4', '#67F5B4'], title='SỐ LƯỢNG KHÁCH HÀNG THEO NHÂN VIÊN MARKETING', height=600, margin=[30, 280, 35, 35])

    # df3 = DB_Accounts.GET_ACCOUNTS(('user_service', ddl_timetype, start_date, end_date, ddl_leadsource, ddl_industry,
    #                                ddl_account, ddl_user_assign,  None, None,  ddl_dept, None, None, None, None, label, value))
    # figure3 = Graph_Accounts.grh_BarChart(df3['Nhân viên'], df3['Số lượng khách hàng'], marker_color=[
    #                                       '#67F5B4', '#67F5B4'], title='SỐ LƯỢNG KHÁCH HÀNG THEO NHÂN VIÊN GIỚI THIỆU', height=600, margin=[20, 360, 35, 35])

    return figure1
