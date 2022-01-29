import dash
from dash import dcc
from dash import html
from dash.html import Div
from numpy import append, maximum
from DB import DB_Accounts
from dash.dependencies import Input, Output, State
from utils import GParams_Accounts
from utils import Graph_Accounts
from static.system_dashboard.css import css_define as css
import pandas as pd
from app import app_Accounts
from urllib.request import urlopen
import json
import plotly.express as px

with urlopen('https://data.opendevelopmentmekong.net/dataset/999c96d8-fae0-4b82-9a2b-e481f6f50e12/resource/234169fb-ae73-4f23-bbd4-ff20a4fca401/download/diaphantinh.geojson') as response:
    counties = json.load(response)


def gen_layout():

    layout = html.Div([
        html.Div([
            html.Div([
                html.Div("SỐ LƯỢNG KH THEO TỈNH THÀNH", style={
                         'width': '100%', 'fontWeight': 'bold', 'background': '#ACE89B'}),
            ], style={'height': '10%', 'width': '100%', 'background': '#ACE89B', 'textAlign': 'center', 'display': 'inline-grid', 'alignItems': 'center', 'position': 'relative'}),
            html.Div([
                dcc.Graph(id="grh_map_city", style={
                    'width': '100%', 'height': '100%'})
            ])
        ], className='au-card', style={'width': '100%', 'height': '100%'})
    ], className="col-sm-12 col-md-6 col-lg-8 mb-3", style={'height': '63vh'})

    return layout


@app_Accounts.callback(
    Output("grh_map_city", "figure"),
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
     ],
    [State('user_detail', 'data'),
     State('account_detail', 'data'),
     ]

)
def UPDATE_MAP_CITY(ddl_timetype, start_date, end_date, ddl_leadsource, ddl_industry, ddl_account, ddl_user_assign, ddl_dept, status, industry, user_assign, user_marketing, user_service, map_city, ac_user_detail, ac_account_detail, data_user_detail, data_account_detail):
    ctx = dash.callback_context
    datatable = {'user_detail': data_user_detail,
                 'account_detail': data_account_detail,
                 }
    label, value = GParams_Accounts.Get_Value(ctx, datatable)

    df = DB_Accounts.GET_ACCOUNTS(('city', ddl_timetype, start_date, end_date, ddl_leadsource, ddl_industry, ddl_account,
                                  ddl_user_assign,  None, None,  ddl_dept, None, None, None, None, label, value))
    df['percentage'] = round(
        (df['num_account'] / df['num_account'].sum()) * 100, 2)
    city = []
    num_account = df['num_account'].tolist()
    for i in counties['features']:
        city.append(i['properties']['ten_tinh'])

    list_city = df['ad.ship_city'].tolist()
    num_account = df['num_account'].tolist()
    percentage = df['percentage'].tolist()
    city_notin_df = [c for c in city if c not in list_city]
    for i in city_notin_df:
        list_city.append(i)
        num_account.append(0)
        percentage.append(0)

    dff = pd.DataFrame({'ad.ship_city': list_city,
                       'num_account': num_account, 'percentage': percentage})

    figure = px.choropleth_mapbox(dff, geojson=counties, featureidkey="properties.ten_tinh", locations=dff['ad.ship_city'], color=dff['num_account'], labels={'ad.ship_city': 'Tỉnh/Thành phố', 'num_account': 'Số lượng KH', 'percentage': 'Phần trăm'}, hover_data={'ad.ship_city': True, 'num_account': True, 'percentage': True},
                                  color_continuous_scale=[[0, '#E5ECF6'], [0.00000000000001, '#F3FDAD'], [0.1, '#CCF0A1'], [
                                      0.2, '#A4E599'], [0.4, '#4B8964'], [0.6, '#3B8E7E'], [0.8, '#337382'], [1.0, '#14435D']],
                                  mapbox_style="white-bg", zoom=4.5, center={"lat": 15.9030623, "lon": 105.81113535866}, height=650)

    figure.update_layout(margin={"r": 20, "t": 0, "l": 0, "b": 130})
    return figure
