import dash
from numpy.core.fromnumeric import prod
from DB import DB_potential
from app import app_Potential
from utils import GParams_Potential
from dash.dependencies import Input, Output, State
from layouts.Potential.GEN_OVERVIEW import create_card
from layouts.Potential.DDL_date_range_last import last_time


def gen_layout():

    title = 'Tổng cơ hội'
    color = 'linear-gradient(to right, rgb(17, 153, 142), rgb(56, 239, 125))'
    icon = 'star.svg'

    layout = create_card(title, 'ov_total_potential', color,
                         icon, className='col-sm-12 col-md-3 col-lg-3 mb-3')

    return layout


@app_Potential.callback(
    Output("ov_total_potential", "children"),
    Output("ov_total_potential_diff", "children"),

    # Lấy dữ liệu từ dropdown list
    Input('ddl_time_range', 'value'),
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
def update_ov_total_potential(date_value, date_type, start_date, end_date, potential, sales_stage, product, dept, assign):
    ctx = dash.callback_context
    datatable = {}

    label, value = GParams_Potential.Get_Value(ctx, datatable)

    values = DB_potential.Get_potential(('total_potential', date_type, start_date, end_date, None, None, None, None,
                                         assign, None, None, None, sales_stage, potential, dept, product, None, label, value, None, None, None, None))
    if date_value is not None:
        start_date_2, end_date_2 = last_time(date_value)
        last_values = DB_potential.Get_potential(('total_potential', date_type, start_date_2, end_date_2, None, None, None,
                                                  None, assign, None, None, None, sales_stage, potential, dept, product, None, label, value, None, None, None, None))

        value1 = int(values.total_potential)

        value2 = int(last_values.total_potential)

        if value2 == 0:
            return value1, '-'
        elif (value1 - value2) > 0:
            return value1, '▲' + str(round((value1-value2)/value2*100, 1)) + '%'
        elif (value1 - value2) < 0:
            return value1, '▼' + str(round((value2-value1)/value2*100, 1)) + '%'
        else:
            return value1, '-'
    else:
        return int(values.total_potential), '-'
