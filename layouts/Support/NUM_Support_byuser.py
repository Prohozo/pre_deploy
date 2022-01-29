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
                html.B(html.Div("SỐ HỖ TRỢ THEO NHÂN VIÊN", style={
                       'height': '100%', 'width': '100%', 'background': '#60B664', 'color': 'white', 'text-align': 'center'})),

                # Nút refresh
                html.Button(
                    html.I(className='fas fa-sync-alt'),
                    id='btn_R',
                    style={'position': 'absolute', 'top': '0', 'right': '0', 'paddingTop': '0', 'background': '#60B664', 'border-color': '#60B664', 'paddingBottom': '0', 'height': '100%', 'display': 'inline-grid', 'alignItems': 'center'}, className='btn_in_title btn btn-primary col-1'
                )

            ], style={'height': '7%', 'width': '100%', 'background': '#60B664', 'textAlign': 'center', 'display': 'inline-grid', 'alignItems': 'center', 'position': 'relative'}),
            dcc.Graph(id="num_support_byuser", style={
                      'width': '100%', 'height': '92%'}),
        ], className='au-card', style={'width': '100%', 'height': '100%'}),
    ], className="col-sm-12 col-md-6 col-lg-6 mb-3", style={'height': '75vh'})

    return layout


@app_Support.callback(
    Output("num_support_byuser", "figure"),

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

)
def update_num_potential_bysource(date_type, start_date, end_date, account, account_status, user, dept, status, pareto_user, bar_status, pie_pri, pie_location, ac_delay, ac_detail, data_delay, data_detail):
    ctx = dash.callback_context
    datatable = {'detail_Support_delay': data_delay,
                 'detail_Support': data_detail}
    label, value = GParams_Support.Get_Value(ctx, datatable)
    df = DB_Support.get_Support(('user_assign', date_type, start_date, end_date,
                                account, account_status, user, dept, status, None, label, value))

    # Tính đường phần trăm gộp cho biểu đồ Pareto
    df['cumulative_sum'] = df.num.cumsum()
    df['cumulative_perc'] = round(df['cumulative_sum']/df['num'].sum()*100, 2)

    if df.empty:
        df = pd.DataFrame({'user_name': ['Không có giá trị'], 'num': [
                          0], 'cumulative_perc': [0]})

    return Graph_Support.grh_ParetoChart(x1=df['user_name'], y1=df['num'], x2=df['user_name'], y2=df['cumulative_perc'], label_x='<b>Nhân viên<b>', label_y='<b>Số lượng hỗ trợ<b>', marker_color=['#60B664', '#60B664'], color_line='#FD413C', mode='lines+markers', margin=[35, 150, 75, 75], customdata=[i+1 for i in df.index.values])


@app_Support.callback(
    Output('num_support_byuser', 'clickData'),
    Input('btn_R', 'n_clicks')
)
def refresh(click):
    return None
