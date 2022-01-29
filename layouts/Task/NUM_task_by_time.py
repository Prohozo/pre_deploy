import dash
import dash_core_components as dcc
import dash_html_components as html
from dash.dependencies import Input, Output, State
from layouts.Task.GEN_BUTTON import create_button
from app import app_Task
from utils import Graph_Task, GParams_Task
from DB import DB_Task


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
                children = [
                dcc.Tab(
                    label='Ngày',
                    value='Ngày',
                    children=[dcc.Graph(id="task_by_time_date", style={'width': '100%', 'height': '100%'})],
                    style=tab_style, selected_style=tab_selected_style, className = 'col-3'
                ),
                dcc.Tab(
                    label='Tháng',
                    value='Tháng',
                    children = [dcc.Graph(id="task_by_time_month", style={'width': '100%', 'height': '100%'})],
                    style=tab_style, selected_style=tab_selected_style, className = 'col-3'
                ),
                dcc.Tab(
                    label='Quý',
                    value='Quý',
                    children = [dcc.Graph(id="task_by_time_quarter", style={'width': '100%', 'height': '100%'})],
                    style=tab_style, selected_style=tab_selected_style, className = 'col-3'
                ),
                dcc.Tab(
                    label='Năm',
                    value='Năm',
                    children=[dcc.Graph(id="task_by_time_year", style={'width': '100%', 'height': '100%'})],
                    style=tab_style, selected_style=tab_selected_style, className = 'col-3'
                ),]
            , style={'height': '5vh', 'align-items': 'top'}, className = 'row')
        ], className='au-card', style={'width': '100%', 'height': '100%'})
    ], className="col-sm-12 col-md-6 col-lg-6 mb-3", style={'height': '100%'})

    return layout


@app_Task.callback(
    Output("task_by_time_date", "figure"),
    Output("task_by_time_month", "figure"),
    Output("task_by_time_quarter", "figure"),
    Output("task_by_time_year", "figure"),

    # Lấy dữ liệu từ dropdown list
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
    Input('num_task_bydept', 'selectedData'),
    
    # data of dataTable
    State('detail_task_delay', 'data'),
    State('detail_task_byproject', 'data'),
    State('detail_task_bystory', 'data')
)
def update_num_task_by_time(start_date, end_date, project_id, user, story, dept, ac_task_delay, ac_task_byproject, ac_task_bystory, ac_task_numpri, ac_dept, data_task_delay, data_task_byproject, data_task_bystory):
    ctx = dash.callback_context
    datatable = {'detail_task_delay': data_task_delay,
                 'detail_task_byproject': data_task_byproject,
                 'detail_task_bystory': data_task_bystory
                 }
    label, value = GParams_Task.Get_Value(ctx, datatable)
    
    df_date = DB_Task.Get_task(('num_task_bytime', start_date, end_date, project_id, user, story, dept, label, value, None, None, None, 'Y'))
    df_month = DB_Task.Get_task(('num_task_bytime', start_date, end_date, project_id, user, story, dept, label, value, None, 'Y', None, None))
    df_quarter = DB_Task.Get_task(('num_task_bytime', start_date, end_date, project_id, user, story, dept, label, value, None, None, 'Y', None))
    df_year = DB_Task.Get_task(('num_task_bytime', start_date, end_date, project_id, user, story, dept, label, value, 'Y', None, None, None))
    
    # Trả về 3 biểu đồ line chart(ngày, tháng, năm) cho mỗi tab
    return Graph_Task.grh_LineChart(df_date['t.openedDate'], df_date['num'], mode='lines+markers', title=f'<b>SỐ LƯỢNG TASK ĐÃ TẠO THEO NGÀY</b>', margin=[40, 83, 50, 35], color='#60B664'),Graph_Task.grh_LineChart(df_month['t.openedDate'], df_month['num'], mode='lines+markers', title=f'<b>SỐ LƯỢNG TASK THEO THÁNG</b>', margin=[40, 83, 50, 35], color='#60B664'),Graph_Task.grh_LineChart(df_quarter['t.openedDate'], df_quarter['num'], mode='lines+markers', title=f'<b>SỐ LƯỢNG TASK ĐÃ TẠO THEO QUÝ</b>', margin=[40, 83, 50, 35], color='#60B664'),Graph_Task.grh_LineChart(df_year['t.openedDate'], df_year['num'], mode='lines+markers', title=f'<b>SỐ LƯỢNG TASK THEO NĂM</b>', margin=[40, 83, 50, 35], color='#60B664')
