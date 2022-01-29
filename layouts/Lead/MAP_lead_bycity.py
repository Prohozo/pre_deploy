import dash
import math
import json
import urllib.request
from dash import dcc
import pandas as pd
from dash import html
from dash.dependencies import Input, Output, State
from layouts.Lead.GEN_BUTTON import create_button
import urllib.request
import plotly.express as px
from app import app_Lead
from utils import Graph_Lead, GParams_Lead
from DB import DB_Lead


def gen_layout():
    layout = html.Div([
        html.Div([
            html.Div([
                html.B(html.Div("BẢN ĐỒ TIỀM NĂNG THEO THÀNH PHỐ", style={
                       'height': '100%', 'width': '100%', 'background': '#60B664', 'color': 'white', 'text-align': 'center'})),
            ], style={'height': '7%', 'width': '100%', 'background': '#60B664', 'textAlign': 'center', 'display': 'inline-grid', 'alignItems': 'center', 'position': 'relative'}),
            dcc.Graph(id="map_lead_bycity", style={
                      'width': '100%', 'height': '92%'}),
        ], className='au-card', style={'width': '100%', 'height': '100%'}),
    ], className="col-sm-12 col-md-12 col-lg-8 mb-3", style={'height': '64vh'})

    return layout


@app_Lead.callback(
    Output("map_lead_bycity", "figure"),

    # Lấy dữ liệu từ dropdown list
    Input('date_type', 'value'),
    Input('date_filter', 'start_date'),
    Input('date_filter', 'end_date'),
    Input('ddl_lead_company', 'value'),
    Input('ddl_lead_dept', 'value'),
    Input('ddl_lead_source', 'value'),
    Input('ddl_lead_status', 'value'),
    Input('ddl_lead_assign', 'value'),
    Input('ddl_lead_city', 'value'),

    # col, val filter
    Input('num_lead_byindustry', 'clickData'),
    Input('num_lead_byuser', 'selectedData'),

    # data of dataTable

)
def update_map_lead_bycity(date_type, start_date, end_date, company, dept, source, status, assign, city, ac_industry, ac_user):
    ctx = dash.callback_context

    datatable = {}
    label, value = GParams_Lead.Get_Value(ctx, datatable)
    df = DB_Lead.Get_Lead(('num_lead_bycity', date_type, start_date, end_date, None, None, None,
                          None, assign, status, source, company, dept, city, label, value, None, None, None, None))

    df['percentage'] = round((df['num'] / df['num'].sum()) * 100, 2)

    with urllib.request.urlopen('https://data.opendevelopmentmekong.net/dataset/999c96d8-fae0-4b82-9a2b-e481f6f50e12/resource/234169fb-ae73-4f23-bbd4-ff20a4fca401/download/diaphantinh.geojson') as response:
        gj = json.loads(response.read())

    city = ['An Giang', 'Bà Rịa -Vũng Tàu', 'Bắc Giang', 'Bắc Kạn', 'Bạc Liêu', 'Bắc Ninh', 'Bến Tre', 'Bình Định', 'Bình Dương', 'Bình Phước', 'Bình Thuận', 'Cà Mau', 'Cần Thơn', 'Cao Bằng', 'Đà Nẵng', 'Đăk Lăk', 'Đăk Nông', 'Điện Biên', 'Đồng Nai', 'Đồng Tháp', 'Gia Lai', 'Hà Giang', 'Hà Nam', 'Hà Nội', 'Hà Tĩnh', 'Hải Dương', 'Hải Phòng', 'Hậu Giang', 'Hòa Bình', 'Hưng Yên', 'Khánh Hòa', 'Kien Giang',
            'Kon Tum', 'Lai Châu', 'Lâm Đồng', 'Lạng Sơn', 'Lào Cai', 'Long An', 'Nam Định', 'Nghệ An', 'Ninh Bình', 'Ninh Thuận', 'Phú Thọ', 'Phú Yên', 'Quản Bình', 'Quảng Nam', 'Quảng Ngãi', 'Quảng Ninh', 'Quảng Trị', 'Sóc Trăng', 'Sơn La', 'Tây Ninh', 'Thái Bình', 'Thái Nguyên', 'Thanh Hóa', 'Thừa Thiên Huế', 'Tiền Giang', 'TP. Hồ Chí Minh', 'Trà Vinh', 'Tuyên Quang', 'Vĩnh Long', 'Vĩnh Phúc', 'Yên Bái']

    # Lấy index max của dataframe, nếu df trống thì trả về -1
    max_index = df.index.max()
    if math.isnan(max_index):
        max_index = -1
        df = pd.DataFrame({'la.city': [], 'num': [], 'percentage': []})

    # tất cả city trong df
    all_city = list(set(df['la.city'].tolist()))

    # các city không nằm trong city của file json map
    na_city = [c for c in city if c not in all_city]

    # thêm các city bị thiếu vào df chính
    for i in range(max_index+1, max_index + len(na_city)+1):
        df.loc[i] = [na_city[i - max_index - 1], 0, 0]

    # đổi tên cột
    df.columns = ['Thành phố', 'Số tiềm năng', 'Phần trăm']

    figure = px.choropleth_mapbox(
        df, geojson=gj, color='Số tiềm năng', locations='Thành phố',
        featureidkey="properties.ten_tinh",
        mapbox_style="white-bg",
        hover_data=['Thành phố', 'Số tiềm năng', 'Phần trăm'],
        color_continuous_scale=[[0, '#E5ECF6'], [0.00000000000001, '#F3FDAD'], [0.1, '#CCF0A1'], [
            0.2, '#A4E599'], [0.4, '#68BC8A'], [0.6, '#3B8E7E'], [0.8, '#337382'], [1.0, '#14435D']],
        center={"lat": 15.91030623, "lon": 105.8066925},
        height=650,
        zoom=4.7
    )

    figure.update_layout(margin=dict(t=10, b=30, r=10, l=10))
    return figure
# px.colors.sequential.Peach
