import dash
import dash_core_components as dcc
import dash_html_components as html
from DB import DB_Task
from app import app_Task
from utils import GParams_Task
from dash.dependencies import Input, Output, State
from static.system_dashboard.css import css_define as css
import pandas as pd
from layouts.Task.GEN_OVERVIEW import create_card
from layouts.Task.DDL_date_range_last import last_time

def gen_layout():
    
    title = 'Tổng số giờ hoàn thành'
    color = '#60B664'
    icon = 'hours.svg'

    layout = create_card(title, 'ov_total_hour', color, icon)
           
    return layout

@app_Task.callback(
    Output("ov_total_hour", "children"),
    Output("ov_total_hour_diff", "children"),

    # Lấy dữ liệu từ dropdown list
    Input('ddl_time_range', 'value'),
    Input('date_filter', 'start_date'),
    Input('date_filter', 'end_date'),
    Input('ddl_task_project', 'value'),
    Input('ddl_task_user', 'value'),
    Input('ddl_task_story', 'value'),
    Input('ddl_task_dept', 'value'),

    # col, val filter
    Input('detail_task_delay', 'active_cell'),
    Input('detail_task_byproject', 'active_cell'),
    Input('detail_task_bystory', 'active_cell'),
    Input('task_num_pri', 'clickData'),
    Input('bar_taskopened', 'selectedData'),
    Input('bar_taskdone', 'selectedData'),
    Input('num_task_bydept', 'selectedData'),

    # data of dataTable
    State('detail_task_delay', 'data'),
    State('detail_task_byproject', 'data'),
    State('detail_task_bystory', 'data')

)
def update_ov_total_task(date_value, start_date, end_date, project_id, user, story, dept, ac_task_delay, ac_task_byproject, ac_task_bystory, ac_task_numpri,ac_task_bardone, ac_task_baropened, ac_dept, data_task_delay, data_task_byproject, data_task_bystory):
    ctx = dash.callback_context
    datatable = {'detail_task_delay': data_task_delay,
                 'detail_task_byproject': data_task_byproject,
                 'detail_task_bystory': data_task_bystory
                }
    label, value = GParams_Task.Get_Value(ctx, datatable)
    values = DB_Task.Get_task(('total_hour', start_date, end_date, project_id, user, story, dept, label, value, None, None, None, None))
    if date_value is not None:
        start_date_2, end_date_2 = last_time(date_value)
        last_values = DB_Task.Get_task(('total_hour', start_date_2, end_date_2, project_id, user, story, dept, label, value, None, None, None, None))

        value1 = int(values.total_hour)
        value2 = int(last_values.total_hour)
        
        if value2 == 0:
            return value1, '-'
        elif (value1 - value2) > 0:
            return value1, '▲' + str(round((value1-value2)/value2*100, 1)) + '%'
        elif (value1 - value2) < 0:
            return value1, '▼'+ str(round((value2-value1)/value2*100, 1)) + '%'
        else:
            return value1, '-'
    else:
        return int(values.total_hour), '-'
