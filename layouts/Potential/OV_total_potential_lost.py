import dash
from numpy.core.fromnumeric import prod
from DB import DB_potential
from app import app_Potential
from utils import GParams_Potential
from dash.dependencies import Input, Output, State
from layouts.Potential.GEN_OVERVIEW import create_card


def gen_layout():

    title = 'Tổng cơ hội thất bại'
    color = 'linear-gradient(to right, rgb(255, 65, 108), rgb(255, 75, 43))'
    icon = 'lost.svg'

    layout = create_card(title, 'ov_total_lost', color, icon)

    return layout


@app_Potential.callback(
    Output("ov_total_lost", "children"),

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
def update_ov_total_potential_lost(date_type, start_date, end_date, potential, sales_stage, product, dept, assign):
    ctx = dash.callback_context
    datatable = {}

    label, value = GParams_Potential.Get_Value(ctx, datatable)

    values = DB_potential.Get_potential(('total_potential_lost', date_type, start_date, end_date, None, None, None, None,
                                         assign, None, None, None, sales_stage, potential, dept, product, None, label, value, None, None, None, None))
    total = DB_potential.Get_potential(('total_potential', date_type, start_date, end_date, None, None, None, None,
                                        assign, None, None, None, sales_stage, potential, dept, product, None, label, value, None, None, None, None))

    return f'{int(values.total_potential_lost)} ({round(float(values.total_potential_lost/total.total_potential*100),2)}%)'
