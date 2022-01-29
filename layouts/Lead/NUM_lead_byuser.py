import dash
from dash import dcc
import pandas as pd
from dash import html
from dash.dependencies import Input, Output, State
from app import app_Lead
from utils import Graph_Lead, GParams_Lead
from DB import DB_Lead


def gen_layout():
    layout = html.Div([
        html.Div([
            html.Div([
                html.B(html.Div("SỐ KHÁCH HÀNG TIỀM NĂNG THEO NHÂN VIÊN", style={
                       'height': '100%', 'width': '100%', 'background': '#60B664', 'color': 'white', 'text-align': 'center'})),
            ], style={'height': '8%', 'width': '100%', 'background': '#60B664', 'textAlign': 'center', 'display': 'inline-grid', 'alignItems': 'center', 'position': 'relative'}),
            dcc.Graph(id="num_lead_byuser", style={
                      'width': '100%', 'height': '92%'}),
        ], className='au-card', style={'width': '100%', 'height': '100%'}),
    ], className="col-sm-12 col-md-6 col-lg-6 mb-3", style={'height': '51vh'})

    return layout


@app_Lead.callback(
    Output("num_lead_byuser", "figure"),

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
def update_num_lead_byuser(date_type, start_date, end_date, company, dept, source, status, assign, city, ac_industry, ac_user):
    ctx = dash.callback_context
    datatable = {}
    label, value = GParams_Lead.Get_Value(ctx, datatable)
    df = DB_Lead.Get_Lead(('num_lead_byuser', date_type, start_date, end_date, None, None, None,
                          None, assign, status, source, company, dept, city, label, value, None, None, None, None))

    if df.empty:
        df = pd.DataFrame({'u.user_name': ['Không có giá trị'], 'num': [0]})

    return Graph_Lead.grh_BarChart(df['u.user_name'], df['num'], label_x='<b>Nhân viên</b>', label_y='<b>Số tiềm năng</b>', marker_color=['#3b5441', '#3b5441'], margin=[50, 150, 100, 20])

    # '#107a8b', '#2cb978', '#60B664', '#3b5441'
