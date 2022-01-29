# import dash
# import dash_core_components as dcc
# import dash_html_components as html
# from DB import DB_Users_CRM
# from dash.dependencies import Input, Output, State
# from utils import Graph_UsersCRM
# from utils import GParams_UsersCRM
# from static.system_dashboard.css import css_define as css
# import pandas as pd
# from app import app_UsersCRM

# def gen_layout():

#     layout = html.Div([
#                 html.Div([
#                     dcc.Graph(id="grh_bar_salesorder", style={'width': '100%', 'height': '100%'})
#                 ],className='au-card' ,style={'width': '100%', 'height': '100%'})
#             ], className="col-6" , style={'height':'100%'})
           
#     return layout

# @app_UsersCRM.callback(
#     Output("grh_bar_salesorder","figure"),
#     [Input('date-picker-range','start_date'),
#     Input('date-picker-range','end_date'),
#     Input('ddl_account','value'),
#     Input('ddl_user_assign','value'),
#     Input('ddl_dept','value'),
#     ],

# )

# def UPDATE_BAR_SALESORDER(start_date,end_date,ddl_account,ddl_user_assign,ddl_dept):
#     # ctx = dash.callback_context
#     # datatable = {'user_detail': data_user_detail, 
#     #             'account_detail':data_account_detail, 
#     #             'city':data_city,
#     #             }
#     # label, value = GParams_UsersCRM.Get_Value(ctx,datatable)
#     df = DB_Users_CRM.GET_USERSCRM(('user_salesorder',start_date,end_date,ddl_account,ddl_user_assign,ddl_dept,None,None))
   
#     return  Graph_UsersCRM.grh_BarChart(df['Nhân viên'],df['Số lượng đơn hàng'],label_x='NHÂN VIÊN',label_y='SỐ LƯỢNG ĐƠN HÀNG',marker_color=['#FFDC7D','#FFDC7D'],title='SỐ LƯỢNG ĐƠN HÀNG THEO NHÂN VIÊN',margin = [50, 150, 60, 35])


