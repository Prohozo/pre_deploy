import dash
from dash import dcc
import pandas as pd
from dash import html
from dash.dependencies import Input, Output, State
from layouts.Potential.GEN_BUTTON import create_button
from app import app_Potential
from utils import Graph_Potential, GParams_Potential
from DB import DB_potential


def gen_layout():
    layout = html.Div([
        html.Div([
            html.Div([
                html.B(html.Div("SỐ CƠ HỘI THEO GIAI ĐOẠN BÁN HÀNG", style={
                       'height': '100%', 'width': '100%', 'background': '#60B664', 'color': 'white', 'text-align': 'center'})),
            ], style={'height': '7%', 'width': '100%', 'background': '#60B664', 'textAlign': 'center', 'display': 'inline-grid', 'alignItems': 'center', 'position': 'relative'}),
            dcc.Graph(id="num_potential_bysalestage", style={
                      'width': '100%', 'height': '92%'}),
        ], className='au-card', style={'width': '100%', 'height': '100%'}),
    ], className="col-sm-12 col-md-6 col-lg-6 mb-3", style={'height': '50vh'})

    return layout


@app_Potential.callback(
    Output("num_potential_bysalestage", "figure"),

    # Lấy dữ liệu từ dropdown list
    Input('date_type', 'value'),
    Input('date_filter', 'start_date'),
    Input('date_filter', 'end_date'),
    Input('ddl_potential_company', 'value'),
    Input('ddl_potential_sales_stage', 'value'),
    # Input('ddl_potential_status', 'value'),
    Input('ddl_potential_product', 'value'),
    Input('ddl_potential_dept', 'value'),
    Input('ddl_potential_assign', 'value'),
    # Input('ddl_potential_mkt', 'value'),
    # Input('ddl_potential_service', 'value'),

    # col, val filter
    # Input('num_potential_byindustry', 'clickData'),
    # Input('num_potential_byuser', 'selectedData'),

    # data of dataTable

)
def update_num_potential_bysource(date_type, start_date, end_date, potential, sales_stage, product, dept, assign):
    ctx = dash.callback_context
    datatable = {}
    label, value = GParams_Potential.Get_Value(ctx, datatable)
    df = DB_potential.Get_potential(('num_potential_bysalestage', date_type, start_date, end_date, None, None, None,
                                     None, assign, None, None, None, sales_stage, potential, dept, product, None, label, value, None, None, None, None))

    if df.empty:
        df = pd.DataFrame({'p.sales_stage': ['Không có giá trị'], 'num': [0]})

    return Graph_Potential.grh_BarChart(df['p.sales_stage'], df['num'], label_x='<b>Giai đoạn bán hàng</b>', label_y='<b>Số tiềm năng</b>', marker_color=['#2cb978', '#2cb978'], margin=[50, 150, 100, 20])
