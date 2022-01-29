import dash
from dash import dcc
from dash import html
from dash import dash_table
import pandas as pd
import urllib.parse
from dash.dependencies import Input, Output, State
from static.system_dashboard.css import css_define as css
from utils import GParams_Potential
from app import app_Potential
from DB import DB_potential


def gen_layout():

    layout = html.Div([
        html.Div([
            html.Div([
                html.Div([
                    html.B(html.Div("a", style={
                        'height': '100%', 'width': '100%', 'background': '#60B664', 'color': '#60B664', 'text-align': 'center'})),
                ], style={'height': '7%', 'width': '100%', 'background': 'white', 'textAlign': 'center', 'display': 'inline-grid', 'alignItems': 'center', 'position': 'relative'}),

                # Slider ngày trễ
                html.Div([
                    dcc.RadioItems(
                        id='activity_radio',
                        options=[{'value': 1, 'label': 'Hôm nay'},
                                 {'value': 0,
                                  'label': 'Tất cả'},
                                 ],
                        value=0,
                        style={"margin-right": "5px"},
                        inputStyle={
                            "margin-right": "10px"},
                        labelStyle={
                            "margin-right": "10px"},
                    ),

                ], className='col-12', style={'margin-top': '5px', 'margin-bottom': '5px', 'width': '95%', 'align-items': 'center'}),

                html.A(
                    children=[
                        html.I(
                            className="fas fa-file-download")
                    ],
                    id='download_activity_detail',
                    download='HOẠT_ĐỘNG_CHI_TIẾT.csv',
                    target="_blank",
                    href='',
                    className='btn btn-primary',
                    style={'position': 'absolute', 'top': '0', 'right': '0', 'paddingTop': '0', 'background': '#60B664', 'border-color': '#60B664',
                           'paddingBottom': '0', 'height': '100%', 'display': 'inline-grid', 'alignItems': 'center'})
            ], style={'height': '7%', 'width': '100%', 'background': '#60B664', 'textAlign': 'center', 'display': 'inline-grid', 'alignItems': 'center', 'position': 'relative'}),

            dash_table.DataTable(
                id='activity_detail',

                # Định dạng tên cột
                columns=[
                    {
                        'name': 'Chủ đề',
                        'id': 'a.subject',
                        'presentation': 'markdown'
                    },
                    {
                        'name': 'Loại',
                        'id': 'activitytype'
                    },
                    {
                        'name': 'Nhân viên phân công',
                        'id': 'u.user_name'
                    },
                    {
                        'name': 'Ngày bắt đầu',
                        'id': 'date_start'
                    },
                    {
                        'name': 'Thời gian bắt đầu',
                        'id': 'time_start'
                    },
                    {
                        'name': 'Ngày kết thúc',
                        'id': 'due_date'
                    },
                    {
                        'name': 'Thời gian kết thúc',
                        'id': 'time_end'
                    },
                    {
                        'name': 'Trạng thái',
                        'id': 'a.status'
                    },
                ],

                # Format độ rộng cho mỗi cột
                style_cell_conditional=[
                    {
                        'if': {'column_id': 'a.subject'},
                        'width': '30%',
                        'textAlign': 'left',
                        'type': 'text',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'activitytype'},
                        'width': '10%',
                        'textAlign': 'center',
                        'type': 'text',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'u.user_name'},
                        'width': '10%',
                        'textAlign': 'center',
                        'type': 'text',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'date_start'},
                        'width': '10%',
                        'textAlign': 'center',
                        'type': 'datetime',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'time_start'},
                        'width': '10%',
                        'textAlign': 'center',
                        'type': 'text',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'due_date'},
                        'width': '10%',
                        'textAlign': 'center',
                        'type': 'datetime',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'time_end'},
                        'width': '10%',
                        'textAlign': 'center',
                        'type': 'text',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'a.status'},
                        'width': '10%',
                        'textAlign': 'center',
                        'type': 'text',
                        'padding-left': '15px'
                    },
                ],

                css=[
                    {
                        'selector': '.dash-fixed-content',
                        'rule': 'width: 100%;'

                    }
                ],

                # Giữ dòng đầu cố định khi scroll
                fixed_rows={'headers': True},
                style_header=css.style_header,
                style_cell=css.style_cell,

                # Trả về trang đầu tiên của bảng
                page_current=0,

                # Số dòng trong mỗi 1 trang dataTable
                page_size=50,
                style_table={
                    'height': '100%', 'width': '100%'},

                # Tùy chỉnh tách trang, filter và sort theo hàm dưới callback
                page_action='custom',
                sort_mode='multi',
                sort_action="custom",
                sort_by=[],

                filter_action='custom',
                filter_query='',
            )
        ], className="au-card", style={'height': '100%'})
    ], className="col-12", style={'height': '100%', 'padding': '0 0'})
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


@app_Potential.callback(
    Output("activity_detail", "data"),
    Output('activity_detail', 'page_count'),

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
    Input('activity_radio', 'value'),

    # Pagination, sort, filter
    Input('activity_detail', 'page_current'),
    Input('activity_detail', 'page_size'),
    Input('activity_detail', 'sort_by'),
    Input('activity_detail', 'filter_query'),

    # col, val filter
    # Input('num_potential_byindustry', 'clickData'),

    # data of dataTable

)
def UPDATE_activity_detail(date_type, start_date, end_date, potential, sales_stage, product, dept, assign, day, page_current, page_size, sort_by, filter):
    ctx = dash.callback_context
    datatable = {}
    label, value = GParams_Potential.Get_Value(ctx, datatable)

    df = DB_potential.Get_potential(('activity_detail', date_type, start_date, end_date, None, None, None, None,
                                     assign,  None, None, None, sales_stage, potential, dept, product, day, label, value, None, None, None, None))

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

    dff['date_start'] = pd.DatetimeIndex(
        dff['date_start']).strftime("%d-%m-%Y")
    dff['time_start'] = pd.DatetimeIndex(
        dff['time_start']).strftime("%I:%M %p")
    dff['due_date'] = pd.DatetimeIndex(dff['due_date']).strftime("%d-%m-%Y")
    dff['time_end'] = pd.DatetimeIndex(dff['time_end']).strftime("%I:%M %p")
    return dff.iloc[page_current * page_size:(page_current + 1)*page_size].to_dict('records'), round(dff.shape[0]/page_size)

# Download callback


@app_Potential.callback(
    Output('download_activity_detail', 'href'),

    Input('download_activity_detail', 'n_clicks'),

    # Dropdown list
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
)
def UPDATE_DOWNLOAD(click, date_type, start_date, end_date, potential, sales_stage, product, dept, assign,):
    ctx = dash.callback_context
    datatable = {}
    label, value = GParams_Potential.Get_Value(ctx, datatable)

    # Lấy full table
    df = DB_potential.Get_potential(('activity_detail', date_type, start_date, end_date, None, None, None, None,
                                     assign, None, None, None, sales_stage, potential, dept, product, None, label, value, None, None, None, None))

    # Xử lý tách link ra khỏi tên công ty
    df['a.subject'] = df['a.subject'].apply(lambda x: x.split(']')[0][1:])

    # Nếu dataframe trả về trống thì tạo 1 df mới chỉ chứa các cột và giá trị 0
    if df.empty:
        df = pd.DataFrame({'a.subject': ['Không có giá trị'], 'activitytype': ['Không có giá trị'], 'u.user_name': ['Không có giá trị'], 'date_start': [
                          'Không có giá trị'], 'time_start': ['Không có giá trị'], 'due_date': ['Không có giá trị'], 'time_end': ['Không có giá trị'], 'a.status': ['Không có giá trị']})
        csv_string = df.to_csv(index=False, encoding='utf-8', header=[
                               'Chủ đề', 'Loại', 'Nhân viên phân công', 'Ngày bắt đầu', 'Thời gian bắt đầu', 'Ngày kết thúc', 'Thời gian kết thúc', 'Trạng thái'])
    else:
        csv_string = df.to_csv(index=False, encoding='utf-8', header=[
                               'Chủ đề', 'Loại', 'Nhân viên phân công', 'Ngày bắt đầu', 'Thời gian bắt đầu', 'Ngày kết thúc', 'Thời gian kết thúc', 'Trạng thái'])
    csv_string = "data:text/csv;charset=utf-8,%EF%BB%BF" + \
        urllib.parse.quote(csv_string)

    return csv_string
# colors=['#107a8b', '#2cb978', '#60B664', '#3b5441']
