import dash
from DB import DB_Lead
from app import app_Lead
from utils import GParams_Lead
from dash.dependencies import Input, Output, State
from layouts.Lead.GEN_OVERVIEW import create_card
from layouts.Task.DDL_date_range_last import last_time

def gen_layout():
    
    title = 'Tổng lĩnh vực'
    color = '#60B664'
    icon = 'factory.svg'

    layout = create_card(title,'ov_total_industry',color, icon)
    
    return layout

@app_Lead.callback(
    Output("ov_total_industry", "children"),
    Output("ov_total_industry_diff", "children"),

    # Lấy dữ liệu từ dropdown list
    Input('ddl_time_range', 'value'),
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
def update_ov_total_industry(date_value, date_type,start_date, end_date, company, dept, source, status, assign, city, ac_industry, ac_user):
    ctx = dash.callback_context
    datatable = {}
    
    label, value = GParams_Lead.Get_Value(ctx, datatable)
    values = DB_Lead.Get_Lead(('total_industry', date_type,start_date, end_date,None, None, None, None, assign, status, source, company, dept, city, label, value, None, None,None, None))
    
    if date_value is not None:
        start_date_2, end_date_2 = last_time(date_value)
        last_values = DB_Lead.Get_Lead(('total_industry', date_type,start_date_2, end_date_2,None, None, None, None, assign, status, source, company, dept, city, label, value, None, None,None, None))

        value1 = int(values.total_industry)
        value2 = int(last_values.total_industry)
        
        if (value1 - value2) > 0:
            return value1, '▲' + str((value1-value2))
        elif (value1 - value2) < 0:
            return value1, '▼'+ str((value2-value1))
        else:
            return value1, '-'
    else:
        return int(values.total_industry), '-'

