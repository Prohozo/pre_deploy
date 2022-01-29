import dash
from dash import dcc
import pandas as pd
from dash import html
from dash.dependencies import Input, Output, State
from layouts.Support.GEN_BUTTON import create_button
from app import app_Support
from utils import Graph_Support, GParams_Support
from DB import DB_Support


def gen_layout():
    layout = html.Div([
        html.Div([
            html.Div([
                html.B(html.Div("SỐ HỖ TRỢ THEO TRẠNG THÁI", style={
                       'height': '100%', 'width': '100%', 'background': '#60B664', 'color': 'white', 'text-align': 'center'})),

            ], style={'height': '7%', 'width': '100%', 'background': '#60B664', 'textAlign': 'center', 'display': 'inline-grid', 'alignItems': 'center', 'position': 'relative'}),
            dcc.Graph(id="num_support_bystatus", style={
                      'width': '100%', 'height': '92%'}),
        ], className='au-card', style={'width': '100%', 'height': '100%'}),
    ], className="col-sm-12 col-md-6 col-lg-6 mb-3", style={'height': '63vh'})

    return layout


@app_Support.callback(
    Output("num_support_bystatus", "figure"),

    # Lấy dữ liệu từ dropdown list
    Input('date_type', 'value'),
    Input('date_filter', 'start_date'),
    Input('date_filter', 'end_date'),
    Input('ddl_account', 'value'),
    Input('ddl_account_status', 'value'),
    Input('ddl_user_assign', 'value'),
    Input('ddl_dept', 'value'),
    Input('ddl_status', 'value'),

    Input('num_support_byuser', 'clickData'),
    Input('num_support_bystatus', 'selectedData'),
    Input('num_Support_bypri', 'clickData'),
    Input('num_Support_bylocation', 'clickData'),
    Input('detail_Support_delay', 'active_cell'),
    Input('detail_Support', 'active_cell'),

    State('detail_Support_delay', 'data'),
    State('detail_Support', 'data')

    # col, val filter
    # Input('num_potential_byindustry', 'clickData'),
    # Input('num_potential_byuser', 'selectedData'),

    # data of dataTable

)
def update_num_potential_bystatus(date_type, start_date, end_date, account, account_status, user, dept, status, pareto_user, bar_status, pie_pri, pie_location, ac_delay, ac_detail, data_delay, data_detail):
    ctx = dash.callback_context
    datatable = {'detail_Support_delay': data_delay,
                 'detail_Support': data_detail}
    label, value = GParams_Support.Get_Value(ctx, datatable)
    df = DB_Support.get_Support(('status', date_type, start_date, end_date,
                                account, account_status, user, dept, status, None, label, value))

    if df.empty:
        df = pd.DataFrame({'status': ['Không có giá trị'], 'num': [0]})

    return Graph_Support.grh_BarChart(df['status'], df['num'], label_x='<b>Trạng thái</b>', label_y='<b>Số hỗ trợ</b>', marker_color=['#2cb978', '#2cb978'], margin=[50, 150, 75, 75])
