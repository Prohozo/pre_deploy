import dash
from dash import dcc
from dash import html
from dash.dependencies import Input, Output, State
from app import app_Support
from utils import Graph_Support, GParams_Support
from DB import DB_Support


def gen_layout():
    tab_style = {
        'borderBottom': '1px solid #d6d6d6',
        'color': 'black',
        'background-color': 'white',
        'border-left': '1px solid #E5E5E5',
        'text-align': 'center',
        'padding': '9px 25px'
    }

    tab_selected_style = {
        'borderTop': '1px solid #60B664',
        'borderBottom': '1px solid #60B664',
        'backgroundColor': '#60B664',
        'color': 'white',
        'fontWeight': 'bold',
        'text-align': 'center',
        'padding': '9px 25px'
    }
    layout = html.Div([
        html.Div([
            dcc.Tabs(
                value='Tháng',
                children=[
                    dcc.Tab(
                        label='Ngày',
                        value='Ngày',
                        children=[dcc.Graph(id="support_by_time_date", style={
                            'width': '100%', 'height': '100%'})],
                        style=tab_style, selected_style=tab_selected_style, className='col-3'
                    ),
                    dcc.Tab(
                        label='Tháng',
                        value='Tháng',
                        children=[dcc.Graph(id="support_by_time_month", style={
                                            'width': '100%', 'height': '100%'})],
                        style=tab_style, selected_style=tab_selected_style, className='col-3'
                    ),
                    dcc.Tab(
                        label='Quý',
                        value='Quý',
                        children=[dcc.Graph(id="support_by_time_quarter", style={
                                            'width': '100%', 'height': '100%'})],
                        style=tab_style, selected_style=tab_selected_style, className='col-3'
                    ),
                    dcc.Tab(
                        label='Năm',
                        value='Năm',
                        children=[dcc.Graph(id="support_by_time_year", style={
                            'width': '100%', 'height': '100%'})],
                        style=tab_style, selected_style=tab_selected_style, className='col-3'
                    ), ], style={'height': '6vh', 'align-items': 'center'}, className='row')
        ], className='au-card', style={'width': '100%', 'height': '100%'})
    ], className="col-sm-12 col-md-12 col-lg-12 mb-3", style={'height': '100%'})

    return layout


@app_Support.callback(
    Output("support_by_time_date", "figure"),
    Output("support_by_time_month", "figure"),
    Output("support_by_time_quarter", "figure"),
    Output("support_by_time_year", "figure"),

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

    df_date = DB_Support.get_Support(('support_day', date_type, start_date,
                                     end_date, account, account_status, user, dept, status, None, label, value))
    df_month = DB_Support.get_Support(('support_month', date_type, start_date,
                                      end_date, account, account_status, user, dept, status, None, label, value))
    df_quarter = DB_Support.get_Support(('support_quarter', date_type, start_date,
                                        end_date, account, account_status, user, dept, status, None, label, value))
    df_year = DB_Support.get_Support(('support_year', date_type, start_date,
                                     end_date, account, user, account_status, dept, status, None, label, value))

    # Trả về 3 biểu đồ line chart(ngày, tháng, năm) cho mỗi tab
    if (date_type == 'Ngày tạo') | (date_type is None):
        return Graph_Support.grh_LineChart(df_date['day'], df_date['num'], mode='lines+markers', title=f'<b>SỐ HỖ TRỢ THEO NGÀY (NGÀY TẠO)</b>', margin=[40, 83, 50, 35], color='#60B664'), Graph_Support.grh_LineChart(df_month['month'], df_month['num'], mode='lines+markers', title=f'<b>SỐ HỖ TRỢ THEO THÁNG (NGÀY TẠO)</b>', margin=[40, 83, 50, 35], color='#60B664'), Graph_Support.grh_LineChart(df_quarter['quarter'], df_quarter['num'], mode='lines+markers', title=f'<b>SỐ HỖ TRỢ THEO QUÝ (NGÀY TẠO)</b>', margin=[40, 83, 50, 35], color='#60B664'), Graph_Support.grh_LineChart(df_year['year'], df_year['num'], mode='lines+markers', title=f'<b>SỐ HỖ TRỢ THEO NĂM (NGÀY TẠO)</b>', margin=[40, 83, 50, 35], color='#60B664')
    else:
        return Graph_Support.grh_LineChart(df_date['day'], df_date['num'], mode='lines+markers', title=f'<b>SỐ HỖ TRỢ THEO NGÀY (NGÀY CHỈNH SỬA)</b>', margin=[40, 83, 50, 35], color='#60B664'), Graph_Support.grh_LineChart(df_month['month'], df_month['num'], mode='lines+markers', title=f'<b>SỐ HỖ TRỢ THEO THÁNG (NGÀY CHỈNH SỬA)</b>', margin=[40, 83, 50, 35], color='#60B664'), Graph_Support.grh_LineChart(df_quarter['quarter'], df_quarter['num'], mode='lines+markers', title=f'<b>SỐ HỖ TRỢ THEO QUÝ (NGÀY CHỈNH SỬA)</b>', margin=[40, 83, 50, 35], color='#60B664'), Graph_Support.grh_LineChart(df_year['year'], df_year['num'], mode='lines+markers', title=f'<b>SỐ HỖ TRỢ THEO NĂM (NGÀY CHỈNH SỬA)</b>', margin=[40, 83, 50, 35], color='#60B664')
