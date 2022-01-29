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
                value='NV phân công',
                children=[
                    dcc.Tab(
                        label='NV phân công',
                        value='NV phân công',
                        children=[dcc.Graph(id="potential_by_user_assign", style={
                                            'width': '100%', 'height': '100%'})],
                        style=tab_style, selected_style=tab_selected_style, className='col-4'
                    ),
                    # dcc.Tab(
                    #     label='NV marketing',
                    #     value='NV marketing',
                    #     children=[dcc.Graph(id="potential_by_user_mkt", style={
                    #                         'width': '100%', 'height': '100%'})],
                    #     style=tab_style, selected_style=tab_selected_style, className='col-4'
                    # ),
                    # dcc.Tab(
                    #     label='NV giới thiệu',
                    #     value='NV giới thiệu',
                    #     children=[dcc.Graph(id="potential_by_user_service", style={
                    #                         'width': '100%', 'height': '100%'})],
                    #     style=tab_style, selected_style=tab_selected_style, className='col-4'
                    # ),
                ], style={'height': '5vh', 'align-items': 'top'}, className='row')
        ], className='au-card', style={'width': '100%', 'height': '100%'})
    ], className="col-sm-12 col-md-6 col-lg-6 mb-3", style={'height': '100%'})

    return layout


@app_Potential.callback(
    Output("potential_by_user_assign", "figure"),
    # Output("potential_by_user_mkt", "figure"),
    # Output("potential_by_user_service", "figure"),

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
def update_num_potential_byuser(date_type, start_date, end_date, potential, sales_stage, product, dept, assign):
    ctx = dash.callback_context
    datatable = {}
    label, value = GParams_Potential.Get_Value(ctx, datatable)

    df_service = DB_potential.Get_potential(('num_potential_byuser', date_type, start_date, end_date, None, None, None,
                                             None, assign, None, None, None, sales_stage, potential, dept, product, None, label, value, None, None, 'Y', None))
    # df_mkt = DB_potential.Get_potential(('num_potential_byuser', date_type, start_date, end_date, None, None, None, None,
    #                                      assign, None, None, None, sales_stage, potential, dept, product, None, label, value, None, 'Y', None, None))
    # df_assign = DB_potential.Get_potential(('num_potential_byuser', date_type, start_date, end_date, None, None, None,
    #                                         None, assign, None, None, None, sales_stage, potential, dept, product, None, label, value, 'Y', None, None, None))

    # Trả về 3 biểu đồ line chart(ngày, tháng, năm) cho mỗi tab

    return Graph_Potential.grh_BarChart_percent(df_assign['u.user_name'], df_assign['num'], title=f'<b>TỶ LỆ THÀNH CÔNG THEO NHÂN VIÊN PHÂN CÔNG</b>', margin=[40, 83, 50, 35], marker_color=['#60B664', '#60B664'], customdata=df_assign['total'])
