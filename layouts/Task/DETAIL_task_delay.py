import dash
import dash_core_components as dcc
import dash_html_components as html
import dash_table
import pandas as pd
import urllib.parse
from dash_table.Format import Format, Scheme
from dash.dependencies import Input, Output, State
from static.system_dashboard.css import css_define as css
from utils import GParams_Task, Graph_Task
from app import app_Task
from DB import DB_Task


def gen_layout():

    layout =html.Div([
                        html.Div([
                            html.Div([
                                html.B(html.Div("BẢNG CHI TIẾT TASK TRỄ", style={'width': '100%', 'background': '#60B664', 'color': 'white', 'text-align': 'center'})),
                                html.A(
                                    children=[
                                        html.I(
                                            className="fas fa-file-download")
                                    ],
                                    id='download_task_delay',
                                    download='TASK_DELAY.csv',
                                    target="_blank",
                                    href='',
                                    className='btn btn-primary',
                                    style={'position': 'absolute', 'top': '0', 'right': '0', 'paddingTop': '0', 'background': '#60B664', 'border-color': '#60B664',
                                           'paddingBottom': '0', 'height': '100%',  'alignItems': 'center'}
                                )
                            ], style={'height': '5%', 'width': '100%', 'background': '#60B664', 'textAlign': 'center',  'alignItems': 'center', 'position': 'relative'}),

                           dash_table.DataTable(
                                id='detail_task_delay',
                                columns=[
                                    {
                                        'name': 'Dự án', 
                                        'id': 'p.name'
                                    },
                                    {
                                        'name': 'Tên task',
                                        'id': 't.name',
                                        'presentation' : 'markdown'
                                    },
                                    {
                                        'name': 'Người thực hiện',
                                        'id': 't.assignedTo'
                                    },
                                    {
                                        'name': 'Trạng thái',
                                        'id': 't.status'
                                    },
                                    {
                                        'name': 'Số ngày trễ',
                                        'id': 'delay_days',
                                        'type': 'numeric'
                                        
                                    },
                                ],
                                style_cell_conditional=[
                                    {
                                        'if': {'column_id': 'p.name'},
                                        'width': '30%',
                                        'textAlign': 'left',
                                        'padding-left': '15px'
                                    },
                                    {
                                        'if': {'column_id': 't.name'},
                                        'width': '35%',
                                        'textAlign': 'left',
                                        'padding-left': '15px'
                                    },
                                    {
                                        'if': {'column_id': 't.assignedTo'},
                                        'width': '10%',
                                        'textAlign': 'left',
                                        'padding-left': '15px'
                                    },
                                    {
                                        'if': {'column_id': 't.status'},
                                        'width': '7%',
                                        'padding-left': '15px'
                                    },
                                    {
                                        'if': {'column_id': 'delay_days'},
                                        'type' : 'numeric',
                                        'padding-left': '15px'
                                    },
                                ],
                                
                                css=[
                                        {
                                            'selector': '.dash-fixed-content',
                                            'rule': 'width: 100%;'
                                        }
                                    ],
                                fixed_rows={'headers': True},
                                filter_action='native',
                                style_header=css.style_header,
                                style_cell=css.style_cell,
                                page_action = 'none',
                                style_table={'height': '30%', 'width': '100%', 'overflowY': 'auto'},
                                sort_action="native",
                                )
                        ], className="au-card",style={'height':'100%'})
                    ], className="col-sm-12 col-md-12 col-lg-9 mb-3",style={'height':'60vh'})
    return layout

# Tạo data bar cho cột số ngày trễ
def data_bars(df, column):
    n_bins = 100
    bounds = [i * (1.0 / n_bins) for i in range(n_bins + 1)]
    ranges = [
        ((df[column].max() - df[column].min()) * i) + df[column].min()
        for i in bounds
    ]
    styles = []
    for i in range(1, len(bounds)):
        min_bound = ranges[i - 1]
        max_bound = ranges[i]
        max_bound_percentage = bounds[i] * 100
        styles.append({
            'if': {
                'filter_query': (
                    '{{{column}}} >= {min_bound}' +
                    (' && {{{column}}} < {max_bound}' if (
                        i < len(bounds) - 1) else '')
                ).format(column=column, min_bound=min_bound, max_bound=max_bound),
                'column_id': column
            },
            'background': (
                """
                    linear-gradient(90deg,
                    #FD413C 0%,
                    #FD413C {max_bound_percentage}%,
                     {max_bound_percentage}%,
                    white 100%)
                """.format(max_bound_percentage=max_bound_percentage)
            ),
            'paddingBottom': 2,
            'paddingTop': 2
        })

    return styles

@app_Task.callback(
    Output("detail_task_delay", "data"),
    # Trả về databar
    Output("detail_task_delay", "style_data_conditional"),

    # Lấy dữ liệu từ dropdown list
    Input('date_filter', 'start_date'),
    Input('date_filter', 'end_date'),
    Input('ddl_task_project', 'value'),
    Input('ddl_task_user', 'value'),
    Input('ddl_task_story', 'value'),
    Input('ddl_task_dept', 'value'),

    # col, val filter
    Input('detail_task_byproject', 'active_cell'),
    Input('detail_task_bystory', 'active_cell'),
    Input('task_num_pri', 'clickData'),
    Input('num_task_bydept', 'selectedData'),

    # data of dataTable
    State('detail_task_byproject', 'data'),
    State('detail_task_bystory', 'data')
)
def UPDATE_detail_task_delay(start_date, end_date, project_id, user, story, dept, ac_task_byproject, ac_task_bystory, ac_task_numpri, ac_dept, data_task_byproject, data_task_bystory):
    ctx = dash.callback_context

    datatable = {'detail_task_byproject': data_task_byproject,
                 'detail_task_bystory': data_task_bystory}

    label, value = GParams_Task.Get_Value(ctx, datatable)
    df = DB_Task.Get_task(('delay_detail', start_date, end_date,project_id, user, story, dept, label, value, None, None, None, None))
    return df.to_dict(orient='records'), data_bars(df, 'delay_days')


@app_Task.callback(
    Output('download_task_delay', 'href'),
    [Input('download_task_delay', 'n_clicks'),
     Input('detail_task_delay', 'data')]
)
def UPDATE_DOWNLOAD(click, data):
    df = pd.DataFrame.from_dict(data)
    if df.empty:
        csv_string = df.to_csv(index=False, encoding='utf-8', header=[])
    else:
        csv_string = df.to_csv(index=False, encoding='utf-8',header=['Dự án', 'Tên task', 'Người thực hiện', 'Trạng thái', 'Số ngày trễ'])
    csv_string = "data:text/csv;charset=utf-8,%EF%BB%BF" + urllib.parse.quote(csv_string)
    return csv_string
