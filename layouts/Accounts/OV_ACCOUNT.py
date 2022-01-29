import dash
from dash import dcc
from dash import html
from DB import DB_Accounts
from dash.dependencies import Input, Output, State
from utils import GParams_Accounts
from static.system_dashboard.css import css_define as css
import pandas as pd
from layouts.Accounts.GEN_OVERVIEW import create_card
from app import app_Accounts
from layouts.Accounts.DDL_DATE_RANGE_LAST import last_time


def gen_layout():

    title = 'SỐ LƯỢNG KHÁCH HÀNG'
    color = '#FEA57D'
    icon = 'customer.svg'
    layout = create_card(title, 'ov_account', color, icon)

    return layout


@app_Accounts.callback(
    Output("ov_account", "children"),
    Output("ov_account_diff", "children"),
    [Input('ddl_time_range', 'value'),
     Input('ddl_timetype', 'value'),
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
def UPDATE_OV_ACCOUNT(date_value, ddl_timetype, start_date, end_date, ddl_leadsource, ddl_industry, ddl_account, ddl_user_assign,  ddl_dept, status, industry, user_assign, user_marketing, user_service, map_city, ac_user_detail, ac_account_detail, ac_city, data_user_detail, data_account_detail, data_city):
    ctx = dash.callback_context
    datatable = {'user_detail': data_user_detail,
                 'account_detail': data_account_detail,
                 'city': data_city,
                 }
    label, value = GParams_Accounts.Get_Value(ctx, datatable)
    df = DB_Accounts.GET_ACCOUNTS(('ov_account', ddl_timetype, start_date, end_date, ddl_leadsource, ddl_industry,
                                  ddl_account, ddl_user_assign,  None, None,  ddl_dept, None, None, None, None, label, value))

    if date_value is not None:
        start_date_last, end_date_last = last_time(date_value)
        df2 = DB_Accounts.GET_ACCOUNTS(('ov_account', ddl_timetype, start_date_last, end_date_last, ddl_leadsource, ddl_industry,
                                       ddl_account, ddl_user_assign,  None, None,  ddl_dept, None, None, None, None, label, value))

        end_value = df['Tổng số lượng khách hàng'].values[0]
        start_value = df2['Tổng số lượng khách hàng'].values[0]

        if (end_value - start_value) > 0:
            return end_value, '▲' + str(round((end_value-start_value)/start_value*100, 1)) + '%'
        elif (end_value - start_value) < 0:
            return end_value, '▼' + str(round((start_value-end_value)/start_value*100, 1)) + '%'
        else:
            return end_value, '0%'
    else:
        return df['Tổng số lượng khách hàng'].values[0], '-'
