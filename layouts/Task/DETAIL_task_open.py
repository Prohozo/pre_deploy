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
                                html.A(
                                    children=[
                                        html.I(className="fas fa-file-download")
                                    ],
                                    id='download_detail_task_open',
                                    download='TASK_DA_DUOC_TAO.csv',
                                    target="_blank",
                                    href='',
                                    className='btn btn-primary',
                                    style={'position': 'absolute', 'top': '0', 'right': '0', 'paddingTop': '0', 'background': '#60B664', 'border-color': '#60B664',
                                           'paddingBottom': '0', 'height': '100%',  'alignItems': 'center'}
                                )
                            ], style={'height': '10%', 'width': '100%', 'paddingBottom': '20px', 'background': 'white', 'textAlign': 'center',  'alignItems': 'center', 'position': 'relative'}),

                           dash_table.DataTable(
                                id='detail_task_open',
                                columns = [
                                    {
                                        'id': 'Dự án',
                                        'presentation': 'markdown'
                                    },
                                    {
                                        'name': 'Trạng thái', 
                                        'id': 'Trạng thái',
                                    },
                                    {
                                        'name': 'Người được giao', 
                                        'id': 'Người được giao',
                                    },
                                    {
                                        'id': 'Tên task',
                                        'presentation': 'markdown'
                                    },
                                    {
                                        'name': 'Loại',
                                        'id': 'Loại',
                                    },
                                    {
                                        'name': 'Ngày mở task', 
                                        'id': 'Ngày mở task',
                                    },
                                    {
                                        'name': 'Ngày bắt đầu', 
                                        'id': 'Ngày bắt đầu',
                                    },
                                    {
                                        'name': 'Số giờ ước tính', 
                                        'id': 'Số giờ ước tính',
                                    },
                                    {
                                        'name': 'Số giờ thực hiện', 
                                        'id': 'Số giờ thực hiện',
                                    },
                                    {
                                        'name': 'Deadline', 
                                        'id': 'Deadline',
                                    },
                                ],
                                style_cell_conditional=[
                                    {
                                        'if': {'column_id': 'Dự án'},
                                        'width': '13%',
                                        'textAlign': 'left',
                                        'padding-left': '15px'
                                    },
                                    {
                                        'if': {'column_id': 'Trạng thái'},
                                        'width': '7%',
                                        'textAlign': 'center',
                                        'padding-left': '15px'
                                    },
                                    {
                                        'if': {'column_id': 'Người được giao'},
                                        'width': '8%',
                                        'textAlign': 'center',
                                        'padding-left': '15px'
                                    },
                                    {
                                        'if': {'column_id': 'Tên task'},
                                        'width': '25%',
                                        'type': 'text',
                                        'textAlign': 'left',
                                        'padding-left': '15px'
                                    },
                                    {
                                        'if': {'column_id': 'Loại'},
                                        'width': '5%',
                                        'type': 'text',
                                        'textAlign': 'center',
                                        'padding-left': '15px'
                                    },
                                    {
                                        'if': {'column_id': 'Ngày mở task'},
                                        'width': '12%',
                                        'textAlign': 'center',
                                        'padding-left': '15px',
                                        'type':'datetime'
                                    },
                                    {
                                        'if': {'column_id': 'Ngày bắt đầu'},
                                        'width': '8%',
                                        'textAlign': 'center',
                                        'padding-left': '15px',
                                        'type':'datetime'
                                    },
                                    {
                                        'if': {'column_id': 'Số giờ ước tính'},
                                        'width': '6%',
                                        'textAlign': 'center',
                                        'padding-left': '15px',
                                        'type':'numeric'
                                    },
                                    {
                                        'if': {'column_id': 'Số giờ thực hiện'},
                                        'width': '6%',
                                        'textAlign': 'center',
                                        'padding-left': '15px',
                                        'type': 'numeric'
                                    },
                                ],
                                css=[
                                        {
                                            'selector': '.dash-fixed-content',
                                            'rule': 'width: 100%;'
                                        }
                                    ],
                                fixed_rows={'headers': True},
                                style_header=css.style_header,
                                style_cell=css.style_cell,
                                # Trả về trang đầu tiên của bảng
                                page_current=0,
                                # Số dòng trong mỗi 1 trang dataTable
                                page_size=50,
                                style_table={'height': '100%', 'width': '100%'},
                                page_action='custom',
                                # Tùy chỉnh chế độ filter và sắp xếp theo dạng tùy chỉnh bằng function phía dưới
                                sort_mode='multi',
                                sort_action="custom",
                                sort_by=[],
                                
                                filter_action='custom',
                                filter_query='',
                                )
                        ], className="au-card",style={'height':'100%'})
                    ], className="col-12",style={'height':'100%', 'padding': '0 0'})
    return layout


operators = [['ge ', '>='],
             ['le ', '<='],
             ['lt ', '<'],
             ['gt ', '>'],
             ['ne ', '!='],
             ['eq ', '='],
             ['contains '],
             ['datestartswith ']]

# Hàm filter cho bảng
# Lý do dùng hàm riêng chứ không dùng filter_action='native', sort_action='native' vì làm như vậy sẽ tạo xung đột trong bảng và gây ra lỗi
def split_filter_part(filter_part):
    for operator_type in operators:
        for operator in operator_type:
            if operator in filter_part:
                name_part, value_part = filter_part.split(operator, 1)
                name = name_part[name_part.find('{') + 1: name_part.rfind('}')]

                value_part = value_part.strip()
                v0 = value_part[0]
                if (v0 == value_part[-1] and v0 in ("'", '"', '`')):
                    value = value_part[1: -1].replace('\\' + v0, v0)
                else:
                    try:
                        value = float(value_part)
                    except ValueError:
                        value = value_part
                return name, operator_type[0].strip(), value
    return [None] * 3

@app_Task.callback(
    Output("detail_task_open", "data"),
    Output('detail_task_open', 'page_count'),
    Output('detail_task_open', 'style_data_conditional'),

    # Lấy dữ liệu từ filter
    Input('date_filter', 'start_date'),
    Input('date_filter', 'end_date'),
    Input('ddl_task_project', 'value'),
    Input('ddl_task_user', 'value'),
    Input('ddl_task_story', 'value'),
    Input('ddl_task_dept', 'value'),

    # col, val DataTable filter
    Input('detail_task_delay', 'active_cell'),
    Input('detail_task_byproject', 'active_cell'),
    Input('detail_task_bystory', 'active_cell'),
    Input('task_num_pri', 'clickData'),
    Input('num_task_bydept', 'selectedData'),

    # Pagination, sort, filter
    Input('detail_task_open', 'page_current'),
    Input('detail_task_open', 'page_size'),
    Input('detail_task_open', 'sort_by'),
    Input('detail_task_open', 'filter_query'),
    
    # data of dataTable
    State('detail_task_delay', 'data'),
    State('detail_task_byproject', 'data'),
    State('detail_task_bystory', 'data')
)
def UPDATE_detail_task(start_date, end_date, project_id, user, story, dept, ac_task_delay, ac_task_byproject, ac_task_bystory, ac_task_numpri, ac_dept, page_current, page_size, sort_by, filter, data_task_delay, data_task_byproject, data_task_bystory):
    ctx = dash.callback_context
    
    datatable = {'detail_task_delay': data_task_delay,
                 'detail_task_byproject': data_task_byproject,
                 'detail_task_bystory': data_task_bystory
                }

    label, value = GParams_Task.Get_Value(ctx, datatable)
    
    df = DB_Task.Get_task(('detail_open', start_date, end_date, project_id, user, story, dept, label, value, None, None, None, None))

    # Xử lý filter_query đã nhập và trả về dataframe
    filtering_expressions = filter.split(' && ')
    dff = df
    for filter_part in filtering_expressions:
        col_name, operator, filter_value = split_filter_part(filter_part)

        if operator in ('eq', 'ne', 'lt', 'le', 'gt', 'ge'):
            dff = dff.loc[getattr(dff[col_name], operator)(filter_value)]
        elif operator == 'contains':
            dff = dff.loc[dff[col_name].str.contains(filter_value)]
        elif operator == 'datestartswith':
            dff = dff.loc[dff[col_name].str.startswith(filter_value)]
    # Xử lý sắp xếp cột trong bảng
    if len(sort_by):
        dff = dff.sort_values(
            [col['column_id'] for col in sort_by],
            ascending=[
                col['direction'] == 'asc'
                for col in sort_by
            ],
            inplace=False
        )

    col = 'Ngày mở task'

    style = (
        [
            {
                'if': {
                    'filter_query': f'{{{col}}} is blank',
                    'column_id': col
                },
                'backgroundColor': '#FD413C',
                'color': 'white'
            }
        ]
    )

    dff['Ngày mở task'] = pd.DatetimeIndex(dff['Ngày mở task']).strftime("%d-%m-%Y %I:%M %p")
    dff['Ngày bắt đầu'] = pd.DatetimeIndex(dff['Ngày bắt đầu']).strftime("%d-%m-%Y")
    dff['Deadline'] = pd.DatetimeIndex(dff['Deadline']).strftime("%d-%m-%Y")

    # Nếu page hiện tại(page_current) thay đổi thì sẽ trả 1 lát cắt với giá trị là page_size dòng, trả về tên cột và trả về số lượng page(Tổng số dòng/số dòng mỗi page)
    return dff.iloc[page_current * page_size:(page_current + 1)*page_size].to_dict('records'), round(dff.shape[0]/page_size), style


@app_Task.callback(
    Output('download_detail_task_open', 'href'),
    Input('download_detail_task_open', 'n_clicks'),

    # Lấy dữ liệu từ filter
    Input('date_filter', 'start_date'),
    Input('date_filter', 'end_date'),
    Input('ddl_task_project', 'value'),
    Input('ddl_task_user', 'value'),
    Input('ddl_task_story', 'value'),
    Input('ddl_task_dept', 'value'),

    # col, val DataTable filter
    Input('detail_task_delay', 'active_cell'),
    Input('detail_task_byproject', 'active_cell'),
    Input('detail_task_bystory', 'active_cell'),
    Input('task_num_pri', 'clickData'),
    
    # data of dataTable
    State('detail_task_delay', 'data'),
    State('detail_task_byproject', 'data'),
    State('detail_task_bystory', 'data')
)
def UPDATE_DOWNLOAD(click, start_date, end_date, project_id, user, story, dept, ac_task_delay, ac_task_byproject, ac_task_bystory, ac_task_numpri, data_task_delay, data_task_byproject, data_task_bystory):
    ctx = dash.callback_context
    
    datatable = {'detail_task_delay': data_task_delay,
                 'detail_task_byproject': data_task_byproject,
                 'detail_task_bystory': data_task_bystory
                }

    label, value = GParams_Task.Get_Value(ctx, datatable)
    
    df = DB_Task.Get_task(('detail_open', start_date, end_date, project_id, user, story, dept, label, value, None, None, None, None))

    # Xử lý tách link ra khỏi tên công ty
    df['Tên task'] = df['Tên task'].apply(lambda x: x.split(']')[0][1:] if x.count(']')==1 else x.split(']')[0][1:]+']'+ x.split(']')[1])

    if df.empty:
        csv_string = df.to_csv(index=False, encoding='utf-8', header=['Dự án', 'Trạng thái', 'Người được giao','Tên task', 'Loại', 'Ngày mở task', 'Ngày bắt đầu', 'Số giờ ước tính', 'Số giờ thực hiện', 'Deadline'])
    else:
        csv_string = df.to_csv(index=False, encoding='utf-8', header=['Dự án', 'Trạng thái', 'Người được giao','Tên task', 'Loại', 'Ngày mở task', 'Ngày bắt đầu', 'Số giờ ước tính', 'Số giờ thực hiện', 'Deadline'])
    csv_string = "data:text/csv;charset=utf-8,%EF%BB%BF" + urllib.parse.quote(csv_string)
    return csv_string
