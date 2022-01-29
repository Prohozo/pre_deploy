import dash
from dash import dcc
from dash import html
from dash.dependencies import Input, Output, State
from app import app_Potential
from utils import Graph_Potential, GParams_Potential
from DB import DB_potential
import pandas as pd


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
                        children=[dcc.Graph(id="potential_by_user_status_assign", style={
                            'width': '100%', 'height': '100%'})],
                        style=tab_style, selected_style=tab_selected_style, className='col-4'
                    ),
                    # dcc.Tab(
                    #     label='NV marketing',
                    #     value='NV marketing',
                    #     children = [dcc.Graph(id="potential_by_user_status_mkt", style={'width': '100%', 'height': '100%'})],
                    #     style=tab_style, selected_style=tab_selected_style, className='col-4'
                    # ),
                    # dcc.Tab(
                    #     label='NV giới thiệu',
                    #     value='NV giới thiệu',
                    #     children=[dcc.Graph(id="potential_by_user_status_service", style={'width': '100%', 'height': '100%'})],
                    #     style=tab_style, selected_style=tab_selected_style, className='col-4'
                    # ),
                ], style={'height': '5vh', 'align-items': 'top'}, className='row')
        ], className='au-card', style={'width': '100%', 'height': '100%'})
    ], className="col-sm-12 col-md-6 col-lg-6 mb-3", style={'height': '100%'})

    return layout


@app_Potential.callback(
    Output("potential_by_user_status_assign", "figure"),
    # Output("potential_by_user_status_mkt", "figure"),
    # Output("potential_by_user_status_service", "figure"),

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
    # Input('num_potential_byuser_status', 'selectedData'),

    # data of dataTable

)
def update_num_potential_byuser_status_status(date_type, start_date, end_date, potential, sales_stage,  status, product, dept, assign, mkt, service):
    ctx = dash.callback_context
    datatable = {}
    label, value = GParams_Potential.Get_Value(ctx, datatable)

    df_service = DB_potential.Get_potential(('num_potential_byuser_status', date_type, start_date, end_date, None, None, None,
                                             None, assign, None, None, None, sales_stage, potential, dept, product, None, label, value, None, None, 'Y', None))
    # df_mkt = DB_potential.Get_potential(('num_potential_byuser_status', date_type, start_date, end_date, None, None, None,
    #                                      None, assign, None, None, None, sales_stage, potential, dept, product, None, label, value, None, 'Y', None, None))
    # df_assign = DB_potential.Get_potential(('num_potential_byuser_status', date_type, start_date, end_date, None, None, None,
    #                                         None, assign, None, None, None, sales_stage, potential, dept, product, None, label, value, 'Y', None, None, None))

    # Trả về 3 biểu đồ
    if df_assign.empty:
        df_assign = pd.DataFrame({'u.user_name': ['Không có giá trị'], 'p.sales_stage': [
                                 'Không có giá trị'], 'num': [0]})
    # if df_mkt.empty:
    #     df_mkt = pd.DataFrame({'pcf.cf_985': ['Không có giá trị'], 'p.sales_stage': ['Không có giá trị'], 'num': [0]})
    # if df_service.empty:
    #     df_service = pd.DataFrame({'pcf.cf_901': ['Không có giá trị'], 'p.sales_stage': ['Không có giá trị'], 'num': [0]})

    return Graph_Potential.grh_StackedBarChart(df_assign, x='u.user_name', y='num', color='p.sales_stage', title='<b>Giai đoạn bán hàng theo nhân viên phân công</b>', margin=[40, 83, 50, 35])
