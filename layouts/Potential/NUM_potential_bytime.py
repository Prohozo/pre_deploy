import dash
from dash import dcc
from dash import html
from dash.dependencies import Input, Output, State
from app import app_Potential
from utils import Graph_Potential, GParams_Potential
from DB import DB_potential


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
                        children=[dcc.Graph(id="potential_by_time_date", style={
                            'width': '100%', 'height': '100%'})],
                        style=tab_style, selected_style=tab_selected_style, className='col-3'
                    ),
                    dcc.Tab(
                        label='Tháng',
                        value='Tháng',
                        children=[dcc.Graph(id="potential_by_time_month", style={
                                            'width': '100%', 'height': '100%'})],
                        style=tab_style, selected_style=tab_selected_style, className='col-3'
                    ),
                    dcc.Tab(
                        label='Quý',
                        value='Quý',
                        children=[dcc.Graph(id="potential_by_time_quarter", style={
                                            'width': '100%', 'height': '100%'})],
                        style=tab_style, selected_style=tab_selected_style, className='col-3'
                    ),
                    dcc.Tab(
                        label='Năm',
                        value='Năm',
                        children=[dcc.Graph(id="potential_by_time_year", style={
                            'width': '100%', 'height': '100%'})],
                        style=tab_style, selected_style=tab_selected_style, className='col-3'
                    ), ], style={'height': '5vh', 'align-items': 'top'}, className='row')
        ], className='au-card', style={'width': '100%', 'height': '100%'})
    ], className="col-sm-12 col-md-6 col-lg-6 mb-3", style={'height': '65vh'})

    return layout


@app_Potential.callback(
    Output("potential_by_time_date", "figure"),
    Output("potential_by_time_month", "figure"),
    Output("potential_by_time_quarter", "figure"),
    Output("potential_by_time_year", "figure"),

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
def update_num_potential_bystatus(date_type, start_date, end_date, potential, sales_stage, product, dept, assign):
    ctx = dash.callback_context
    datatable = {}
    label, value = GParams_Potential.Get_Value(ctx, datatable)

    df_year = DB_potential.Get_potential(('num_potential_bytime', date_type, start_date, end_date, None, None, None,
                                          None, assign, None, None, None, sales_stage, potential, dept, product, None, label, value, 'Y', None, None, None))
    df_date = DB_potential.Get_potential(('num_potential_bytime', date_type, start_date, end_date, None, None, None,
                                          None, assign, None, None, None, sales_stage, potential, dept, product, None, label, value, None, None, 'Y', None))
    df_month = DB_potential.Get_potential(('num_potential_bytime', date_type, start_date, end_date, None, None, None,
                                           None, assign, None, None, None, sales_stage, potential, dept, product, None, label, value, None, 'Y', None, None))
    df_quarter = DB_potential.Get_potential(('num_potential_bytime', date_type, start_date, end_date, None, None, None,
                                             None, assign, None, None, None, sales_stage, potential, dept, product, None, label, value, None, None, None, 'Y'))
    df_year = DB_potential.Get_potential(('num_potential_bytime', date_type, start_date, end_date, None, None, None,
                                          None, assign, None, None, None, sales_stage, potential, dept, product, None, label, value, 'Y', None, None, None))

    # Trả về 3 biểu đồ line chart(ngày, tháng, năm) cho mỗi tab
    if (date_type == 'Ngày tạo') | (date_type is None):
        return Graph_Potential.grh_LineChart(df_date['c.createdtime'], df_date['num'], mode='lines+markers', title=f'<b>SỐ CƠ HỘI THEO NGÀY (NGÀY TẠO)</b>', margin=[40, 83, 50, 35], color='#60B664'), Graph_Potential.grh_LineChart(df_month['c.createdtime'], df_month['num'], mode='lines+markers', title=f'<b>SỐ CƠ HỘI THEO THÁNG (NGÀY TẠO)</b>', margin=[40, 83, 50, 35], color='#60B664'), Graph_Potential.grh_LineChart(df_quarter['c.createdtime'], df_quarter['num'], mode='lines+markers', title=f'<b>SỐ CƠ HỘI THEO QUÝ (NGÀY TẠO)</b>', margin=[40, 83, 50, 35], color='#60B664'), Graph_Potential.grh_LineChart(df_year['c.createdtime'], df_year['num'], mode='lines+markers', title=f'<b>SỐ CƠ HỘI THEO NĂM (NGÀY TẠO)</b>', margin=[40, 83, 50, 35], color='#60B664')
    elif date_type == 'Ngày chỉnh sửa':
        return Graph_Potential.grh_LineChart(df_date['c.modifiedtime'], df_date['num'], mode='lines+markers', title=f'<b>SỐ CƠ HỘI THEO NGÀY (NGÀY CHỈNH SỬA)</b>', margin=[40, 83, 50, 35], color='#60B664'), Graph_Potential.grh_LineChart(df_month['c.modifiedtime'], df_month['num'], mode='lines+markers', title=f'<b>SỐ CƠ HỘI THEO THÁNG (NGÀY CHỈNH SỬA)</b>', margin=[40, 83, 50, 35], color='#60B664'), Graph_Potential.grh_LineChart(df_quarter['c.modifiedtime'], df_quarter['num'], mode='lines+markers', title=f'<b>SỐ CƠ HỘI THEO QUÝ (NGÀY CHỈNH SỬA)</b>', margin=[40, 83, 50, 35], color='#60B664'), Graph_Potential.grh_LineChart(df_year['c.modifiedtime'], df_year['num'], mode='lines+markers', title=f'<b>SỐ CƠ HỘI THEO NĂM (NGÀY CHỈNH SỬA)</b>', margin=[40, 83, 50, 35], color='#60B664')
    else:
        return Graph_Potential.grh_LineChart(df_date['p.closingdate'], df_date['num'], mode='lines+markers', title=f'<b>SỐ CƠ HỘI THEO NGÀY (NGÀY ĐÓNG)</b>', margin=[40, 83, 50, 35], color='#60B664'), Graph_Potential.grh_LineChart(df_month['p.closingdate'], df_month['num'], mode='lines+markers', title=f'<b>SỐ CƠ HỘI THEO THÁNG (NGÀY ĐÓNG)</b>', margin=[40, 83, 50, 35], color='#60B664'), Graph_Potential.grh_LineChart(df_quarter['p.closingdate'], df_quarter['num'], mode='lines+markers', title=f'<b>SỐ CƠ HỘI THEO QUÝ (NGÀY ĐÓNG)</b>', margin=[40, 83, 50, 35], color='#60B664'), Graph_Potential.grh_LineChart(df_year['p.closingdate'], df_year['num'], mode='lines+markers', title=f'<b>SỐ CƠ HỘI THEO NĂM (NGÀY ĐÓNG)</b>', margin=[40, 83, 50, 35], color='#60B664')
