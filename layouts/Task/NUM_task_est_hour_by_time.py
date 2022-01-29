import dash
import dash_core_components as dcc
import dash_html_components as html
from dash.dependencies import Input, Output, State
from layouts.Task.GEN_BUTTON import create_button
from app import app_Task
from utils import Graph_Task, GParams_Task
from DB import DB_Task
import pandas as pd
import numpy as np

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
                    children=[dcc.Graph(id="task_est_hour_by_time_date", style={'width': '100%', 'height': '100%'})],
                    style=tab_style, selected_style=tab_selected_style, className = 'col-3'
                ),
                dcc.Tab(
                    label='Tháng',
                    value='Tháng',
                    children = [dcc.Graph(id="task_est_hour_by_time_month", style={'width': '100%', 'height': '100%'})],
                    style=tab_style, selected_style=tab_selected_style, className = 'col-3'
                ),
                dcc.Tab(
                    label='Quý',
                    value='Quý',
                    children = [dcc.Graph(id="task_est_hour_by_time_quarter", style={'width': '100%', 'height': '100%'})],
                    style=tab_style, selected_style=tab_selected_style, className = 'col-3'
                ),
                dcc.Tab(
                    label='Năm',
                    value='Năm',
                    children=[dcc.Graph(id="task_est_hour_by_time_year", style={'width': '100%', 'height': '100%'})],
                    style=tab_style, selected_style=tab_selected_style, className = 'col-3'
                ),]
            , style={'height': '5vh', 'align-items': 'top'}, className = 'row')
        ], className='au-card', style={'width': '100%', 'height': '100%'})
    ], className="col-sm-12 col-md-6 col-lg-6 mb-3", style={'height': '100%'})
    return layout


@app_Task.callback(
    Output("task_est_hour_by_time_date", "figure"),
    Output("task_est_hour_by_time_month", "figure"),
    Output("task_est_hour_by_time_quarter", "figure"),
    Output("task_est_hour_by_time_year", "figure"),
    
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
    
    # Lấy data từ procedure
    df_date = DB_Task.Get_task(('num_est_hour_bytime', start_date, end_date, project_id, user, story, dept, label, value, None, None, None, 'Y'))
    
    df_month = DB_Task.Get_task(('num_est_hour_bytime', start_date, end_date, project_id, user, story, dept, label, value, None, 'Y', None, None))
    
    df_quarter = DB_Task.Get_task(('num_est_hour_bytime', start_date, end_date, project_id, user, story, dept, label, value, None, None, 'Y', None))

    df_year = DB_Task.Get_task(('num_est_hour_bytime', start_date, end_date, project_id, user, story, dept, label, value, 'Y', None, None, None))

    # Thêm các ngày bị thiếu cho các biểu đồ
    for df in [df_date, df_month, df_year, df_quarter]:
        dff = df.groupby('date_').type.nunique()
        time = list(dff[dff != 2].index)
        index = []

        for t in time:
            for i, k in enumerate(df.date_):
                if k == t:
                    index.append(i)

        type = list(df.iloc[index, :].type)
        for i, val in enumerate(index):

            if type[i] == 'Ước tính':
                df.loc[val+0.5] = time[i], 0.0, 'Thực hiện'

            else:
                df.loc[val+0.5] = time[i], 0.0, 'Ước tính'

    # Drop các giá trị 0 và sắp xếp df theo thời gian
     # Năm
    df_year.drop(df_year[(df_year['date_'] == 0) | (df_year['date_'] == 1970)].index, inplace=True)
    df_year = df_year.sort_values(by='date_')

     # Tháng/Năm
    df_month.drop(df_month[df_month['date_'] == '0/0'].index, inplace=True)
    df_month = df_month.sort_values(by='date_')
    # df_month = df_month.sort_values(by='date_', key=lambda x: pd.to_datetime(x, format='%m/%Y'))

    df_quarter.drop(df_quarter[df_quarter['date_'] == '0 - Q0'].index, inplace=True)
    df_quarter = df_quarter.sort_values(by='date_')

     # Ngày/Tháng/Năm

    df_date.drop(df_date[df_date['date_'] == '0/0/0'].index, inplace=True)

    df_date['date_'] = pd.to_datetime(df_date.date_, format='%d/%m/%Y').dt.date

    df_date = df_date.sort_values(by='date_')

    df_date['date_'] = pd.to_datetime(df_date.date_, format='%Y-%m-%d').dt.strftime('%d/%m/%Y')

    # Truyền giá trị 0/0/0 vào dataframe trong trường hợp không có giá trị nào trả về
    df_none_date = pd.DataFrame({'date_': ['0/0/0', '0/0/0'], 'value': [0, 0], 'type': ['Ước tính', 'Thực hiện']})
    df_none_month = pd.DataFrame({'date_': ['0/0/0', '0/0/0'], 'value': [0, 0], 'type': ['Ước tính', 'Thực hiện']})
    df_none_quarter = pd.DataFrame({'date_': ['0/0/0', '0/0/0'], 'value': [0, 0], 'type': ['Ước tính', 'Thực hiện']})
    df_none_year = pd.DataFrame({'date_': ['0/0/0', '0/0/0'], 'value': [0, 0], 'type': ['Ước tính', 'Thực hiện']})
    if df_date.empty:
        df_date = df_none_date
    if df_month.empty:
        df_month = df_none_month
    if df_quarter.empty:
        df_quarter = df_none_quarter
    if df_year.empty:
        df_year = df_none_year
    
    return Graph_Task.grh_Multi_Line(df_date, 'date_', 'value', title=f'<b>SỐ GIỜ THỰC HIỆN, ƯỚC TÍNH TASK THEO NGÀY</b>', color_discrete_map={
        'Thực hiện': '#60B664', 'Ước tính': '#FD413C'}, margin=[40, 83, 50, 35], legend='type'), Graph_Task.grh_Multi_Line(df_month, 'date_', 'value', title=f'<b>SỐ GIỜ THỰC HIỆN, ƯỚC TÍNH TASK THEO THÁNG</b>', color_discrete_map={'Thực hiện': '#60B664', 'Ước tính': '#FD413C'}, margin=[40, 83, 50, 35], legend='type'),Graph_Task.grh_Multi_Line(df_quarter, 'date_', 'value', title=f'<b>SỐ GIỜ THỰC HIỆN, ƯỚC TÍNH TASK THEO QUÝ</b>', color_discrete_map={'Thực hiện': '#60B664', 'Ước tính': '#FD413C'}, margin=[40, 83, 50, 35], legend='type'), Graph_Task.grh_Multi_Line(df_year, 'date_', 'value', title=f'<b>SỐ GIỜ THỰC HIỆN, ƯỚC TÍNH TASK THEO NGÀY</b>', color_discrete_map={'Thực hiện': '#60B664', 'Ước tính': '#FD413C'}, margin=[40, 83, 50, 35], legend='type')
    