import dash
from numpy.core.fromnumeric import prod
from DB import DB_Support
from app import app_Support
from utils import GParams_Support
from dash.dependencies import Input, Output, State
from layouts.Support.GEN_OVERVIEW import create_card

def gen_layout():
    
    title = 'Tổng hỗ trợ đã đóng'
    color = 'linear-gradient(to right, rgb(253, 200, 48), rgb(243, 115, 53))'
    icon = 'open.svg'

    layout = create_card(title,'ov_total_close_potential',color, icon)
    
    return layout

@app_Support.callback(
    Output("ov_total_close_potential", "children"),

    # Lấy dữ liệu từ dropdown list
    Input('date_type', 'value'),
    Input('date_filter', 'start_date'),
    Input('date_filter', 'end_date'),
    Input('ddl_account', 'value'),
    Input('ddl_account_status', 'value'),
    Input('ddl_user_assign', 'value'),
    Input('ddl_dept', 'value'),
    Input('ddl_status', 'value'),
    
    Input('num_support_byuser','clickData'),
    Input('num_support_bystatus','selectedData'),
    Input('num_Support_bypri','clickData'),
    Input('num_Support_bylocation','clickData'),
    Input('detail_Support_delay','active_cell'),
    Input('detail_Support','active_cell'),

    State('detail_Support_delay','data'),
    State('detail_Support','data')

    # col, val filter
    # Input('num_potential_byindustry', 'clickData'),
    # Input('num_potential_byuser', 'selectedData'),

    # data of dataTable
    
)
def update_ov_total_support(date_type, start_date, end_date, account, account_status, user, dept, status, pareto_user, bar_status, pie_pri, pie_location,ac_delay,ac_detail,data_delay,data_detail):
    ctx = dash.callback_context
    datatable = {'detail_Support_delay':data_delay,
                'detail_Support':data_detail}


    label, value = GParams_Support.Get_Value(ctx, datatable)
    
    values = DB_Support.get_Support(('ov_support_closed', date_type, start_date, end_date, account, account_status, user, dept, status, None, label, value))
    total = DB_Support.get_Support(('ov_support', date_type, start_date, end_date, account, account_status, user, dept, status, None, label, value))

    return f'{int(values.num)} ({round(float(values.num/total.num*100),2)}%)'
