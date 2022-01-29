import dash
from dash import dcc
from dash import html
from dash.dependencies import Input, Output, State
from app import app_Lead
from utils import Graph_Lead, GParams_Lead
from DB import DB_Lead


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
                value='Ngày',
                children=[
                    dcc.Tab(
                        label='Ngày',
                        value='Ngày',
                        children=[dcc.Graph(id="lead_by_time_date", style={
                            'width': '100%', 'height': '100%'})],
                        style=tab_style, selected_style=tab_selected_style, className='col-3'
                    ),
                    dcc.Tab(
                        label='Tháng',
                        value='Tháng',
                        children=[dcc.Graph(id="lead_by_time_month", style={
                                            'width': '100%', 'height': '100%'})],
                        style=tab_style, selected_style=tab_selected_style, className='col-3'
                    ),
                    dcc.Tab(
                        label='Quý',
                        value='Quý',
                        children=[dcc.Graph(id="lead_by_time_quarter", style={
                                            'width': '100%', 'height': '100%'})],
                        style=tab_style, selected_style=tab_selected_style, className='col-3'
                    ),
                    dcc.Tab(
                        label='Năm',
                        value='Năm',
                        children=[dcc.Graph(id="lead_by_time_year", style={
                            'width': '100%', 'height': '100%'})],
                        style=tab_style, selected_style=tab_selected_style, className='col-3'
                    ), ], style={'height': '5vh', 'align-items': 'top'}, className='row')
        ], className='au-card', style={'width': '100%', 'height': '100%'})
    ], className="col-sm-12 col-md-6 col-lg-6 mb-3", style={'height': '51vh'})

    return layout


@app_Lead.callback(
    Output("lead_by_time_date", "figure"),
    Output("lead_by_time_month", "figure"),
    Output("lead_by_time_quarter", "figure"),
    Output("lead_by_time_year", "figure"),


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
def update_num_lead_bystatus(date_type, start_date, end_date, company, dept, source, status, assign, city, ac_industry, ac_user):
    ctx = dash.callback_context
    datatable = {}
    label, value = GParams_Lead.Get_Value(ctx, datatable)

    df_date = DB_Lead.Get_Lead(('num_lead_bytime', date_type, start_date, end_date, None, None,
                               None, None, assign, status, source, company, dept, city, label, value, None, None, None, 'Y'))
    df_month = DB_Lead.Get_Lead(('num_lead_bytime', date_type, start_date, end_date, None, None,
                                None, None, assign, status, source, company, dept, city, label, value, None, 'Y', None, None))
    df_quarter = DB_Lead.Get_Lead(('num_lead_bytime', date_type, start_date, end_date, None, None,
                                  None, None, assign, status, source, company, dept, city, label, value, None, None, 'Y', None))
    df_year = DB_Lead.Get_Lead(('num_lead_bytime', date_type, start_date, end_date, None, None,
                               None, None, assign, status, source, company, dept, city, label, value, 'Y', None, None, None))

    # Trả về 3 biểu đồ line chart(ngày, tháng, năm) cho mỗi tab
    if (date_type == 'Ngày tạo') | (date_type is None):
        return Graph_Lead.grh_LineChart(df_date['c.createdtime'], df_date['num'], mode='lines+markers', title=f'<b>SỐ TIỀM NĂNG ĐÃ TẠO THEO NGÀY</b>', margin=[40, 83, 50, 35], color='#60B664'), Graph_Lead.grh_LineChart(df_month['c.createdtime'], df_month['num'], mode='lines+markers', title=f'<b>SỐ TIỀM NĂNG THEO THÁNG</b>', margin=[40, 83, 50, 35], color='#60B664'), Graph_Lead.grh_LineChart(df_quarter['c.createdtime'], df_quarter['num'], mode='lines+markers', title=f'<b>SỐ TIỀM NĂNG ĐÃ TẠO THEO QUÝ</b>', margin=[40, 83, 50, 35], color='#60B664'), Graph_Lead.grh_LineChart(df_year['c.createdtime'], df_year['num'], mode='lines+markers', title=f'<b>SỐ TIỀM NĂNG THEO NĂM</b>', margin=[40, 83, 50, 35], color='#60B664')
    else:
        return Graph_Lead.grh_LineChart(df_date['c.modifiedtime'], df_date['num'], mode='lines+markers', title=f'<b>SỐ TIỀM NĂNG ĐÃ TẠO THEO NGÀY</b>', margin=[40, 83, 50, 35], color='#60B664'), Graph_Lead.grh_LineChart(df_month['c.modifiedtime'], df_month['num'], mode='lines+markers', title=f'<b>SỐ TIỀM NĂNG THEO THÁNG</b>', margin=[40, 83, 50, 35], color='#60B664'), Graph_Lead.grh_LineChart(df_quarter['c.modifiedtime'], df_quarter['num'], mode='lines+markers', title=f'<b>SỐ TIỀM NĂNG ĐÃ TẠO THEO QUÝ</b>', margin=[40, 83, 50, 35], color='#60B664'), Graph_Lead.grh_LineChart(df_year['c.modifiedtime'], df_year['num'], mode='lines+markers', title=f'<b>SỐ TIỀM NĂNG THEO NĂM</b>', margin=[40, 83, 50, 35], color='#60B664')
