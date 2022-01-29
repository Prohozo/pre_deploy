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
                    html.B(html.Div(children="Slider tháng theo ngày tạo", id='title_month', style={
                        'height': '100%', 'width': '100%', 'background': '#60B664', 'color': 'white', 'text-align': 'center'})),
                ], style={'height': '7%', 'width': '100%', 'background': 'white', 'textAlign': 'center', 'display': 'inline-grid', 'alignItems': 'center', 'position': 'relative'}),


                # Slider doanh thu
                html.Div([
                    dcc.RangeSlider(
                        id='month_slider',
                        min=0,
                        max=36,
                        allowCross=False,
                        value=[0, 36],
                        marks={i: {'label': f'{i}', 'style': {'color': 'white'}}
                               for i in range(0, 37)},
                        step=1,
                        className='col-12'
                    ),

                ], className='col-12', style={'margin-top': '5px', 'margin-bottom': '5px', 'width': '95%', 'align-items': 'center'}),

                html.Div([
                    html.B(html.Div(children="Slider tháng theo ngày đóng dự kiến", id='title_month2', style={
                        'height': '100%', 'width': '100%', 'background': '#60B664', 'color': 'white', 'text-align': 'center'})),
                ], style={'height': '7%', 'width': '100%', 'background': 'white', 'textAlign': 'center', 'display': 'inline-grid', 'alignItems': 'center', 'position': 'relative'}),


                # Slider doanh thu
                html.Div([
                    dcc.RangeSlider(
                        id='month_slider2',
                        min=0,
                        max=36,
                        allowCross=False,
                        value=[0, 36],
                        marks={i: {'label': f'{i}', 'style': {'color': 'white'}}
                               for i in range(0, 37)},
                        step=1,
                        className='col-12'
                    ),

                ], className='col-12', style={'margin-top': '5px', 'margin-bottom': '5px', 'width': '95%', 'align-items': 'center'}),


                html.A(
                    children=[
                        html.I(
                            className="fas fa-file-download")
                    ],
                    id='download_potential_delay_2',
                    download='CO_HOI_KEO_DAI.csv',
                    target="_blank",
                    href='',
                    className='btn btn-primary',
                    style={'position': 'absolute', 'top': '0', 'right': '0', 'paddingTop': '0', 'background': '#60B664', 'border-color': '#60B664',
                           'paddingBottom': '0', 'height': '100%', 'display': 'inline-grid', 'alignItems': 'center'}
                )
            ], style={'height': '13%', 'width': '100%', 'background': '#60B664', 'textAlign': 'center', 'display': 'inline-grid', 'alignItems': 'center', 'position': 'relative'}),

            dash_table.DataTable(
                id='detail_potential_delay_2',
                columns=[
                    {
                        'name': 'Cơ hội',
                        'id': 'p.potentialname',
                        'presentation': 'markdown'
                    },
                    {
                        'name': 'Nhân viên được giao',
                        'id': 'u.user_name'
                    },
                    {
                        'name': 'Giai đoạn bán hàng',
                        'id': 'p.sales_stage'
                    },
                    {
                        'name': 'Số tháng (ngày tạo)',
                        'id': 'delay_days'
                    },
                    {
                        'name': 'Số tháng (ngày đóng)',
                        'id': 'delay_days_2'
                    }
                ],
                style_cell_conditional=[
                    {
                        'if': {'column_id': 'p.potentialname'},
                        'width': '40%',
                        'textAlign': 'center',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'u.user_name'},
                        'width': '18%',
                        'textAlign': 'center',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'p.sales_stage'},
                        'width': '18%',
                        'textAlign': 'center',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'delay_days'},
                        'width': '12%',
                        'textAlign': 'center',
                        'type': 'numeric',
                    },
                    {
                        'if': {'column_id': 'delay_days_2'},
                        'width': '12%',
                        'textAlign': 'center',
                        'type': 'numeric',
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

# Tạo data bar cho cột số ngày trễ


def data_bars_2(df, column):
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
                    #FD893C 0%,
                    #FD893C {max_bound_percentage}%,
                     {max_bound_percentage}%,
                    white 100%)
                """.format(max_bound_percentage=max_bound_percentage)
            ),
            'paddingBottom': 2,
            'paddingTop': 2
        })

    return styles


@app_Potential.callback(
    Output("detail_potential_delay_2", "data"),
    # Trả về databar
    # Output("detail_potential_delay_2", "style_data_conditional"),
    Output('detail_potential_delay_2', 'page_count'),
    Output('title_month', 'children'),
    Output('title_month2', 'children'),

    # Lấy dữ liệu từ dropdown list
    Input('ddl_potential_company', 'value'),
    Input('ddl_potential_sales_stage', 'value'),
    # Input('ddl_potential_status', 'value'),
    Input('ddl_potential_product', 'value'),
    Input('ddl_potential_dept', 'value'),
    Input('ddl_potential_assign', 'value'),
    # Input('ddl_potential_mkt', 'value'),
    # Input('ddl_potential_service', 'value'),
    Input('month_slider', 'value'),
    Input('month_slider2', 'value'),

    # Pagination, sort, filter
    Input('detail_potential_delay_2', 'page_current'),
    Input('detail_potential_delay_2', 'page_size'),
    Input('detail_potential_delay_2', 'sort_by'),
    Input('detail_potential_delay_2', 'filter_query'),

    # col, val filter
    # Input('num_potential_byindustry', 'clickData'),
    # Input('num_potential_byuser', 'selectedData'),

    # data of dataTable

)
def UPDATE_detail_potential_delay_2(potential, sales_stage, product, dept, assign, month_value, month_value2, page_current, page_size, sort_by, filter):
    ctx = dash.callback_context
    datatable = {}
    label, value = GParams_Potential.Get_Value(ctx, datatable)
    df = DB_potential.Get_potential(('potential_delay_2', None, None, None, month_value[0], month_value[1], month_value2[0], month_value2[
                                    1], assign, None, None, None, sales_stage, potential, dept, product, None, label, value, None, None, None, None))

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
    #data_bars(df, 'delay_days'),
    return dff.iloc[page_current * page_size:(page_current + 1)*page_size].to_dict('records'),  round(dff.shape[0]/page_size),  f'Slider tháng tạo (từ {month_value[0]} đến {month_value[1]})',  f'Slider tháng đóng (từ {month_value2[0]} đến {month_value2[1]})'


@app_Potential.callback(
    Output('download_potential_delay_2', 'href'),

    Input('download_potential_delay_2', 'n_clicks'),

    # Lấy dữ liệu từ dropdown list
    Input('ddl_potential_company', 'value'),
    Input('ddl_potential_sales_stage', 'value'),
    # Input('ddl_potential_status', 'value'),
    Input('ddl_potential_product', 'value'),
    Input('ddl_potential_dept', 'value'),
    Input('ddl_potential_assign', 'value'),
    # Input('ddl_potential_mkt', 'value'),
    # Input('ddl_potential_service', 'value'),
    Input('month_slider', 'value'),
    Input('month_slider2', 'value'),
)
def UPDATE_DOWNLOAD(click, potential, sales_stage, product, dept, assign, month_value, month_value2):
    ctx = dash.callback_context
    datatable = {}
    label, value = GParams_Potential.Get_Value(ctx, datatable)

    # Lấy full table
    df = DB_potential.Get_potential(('potential_delay_2',  None, None, None, month_value[0], month_value[1], month_value2[0], month_value2[
                                    1], assign, None, None, None, sales_stage, potential, dept, product, None, label, value, None, None, None, None))

    # Xử lý tách link ra khỏi tên công ty
    df['p.potentialname'] = df['p.potentialname'].apply(lambda x: x.split(']')[
                                                        0][1:])

    if df.empty:
        csv_string = df.to_csv(index=False, encoding='utf-8', header=[
                               'Cơ hội', 'Nhân viên được giao', 'Giai đoạn bán hàng', 'Số tháng(ngày tạo)', 'Số tháng(ngày đóng)'])
    else:
        csv_string = df.to_csv(index=False, encoding='utf-8', header=[
                               'Cơ hội', 'Nhân viên được giao', 'Giai đoạn bán hàng', 'Số tháng(ngày tạo)', 'Số tháng(ngày đóng)'])

    csv_string = "data:text/csv;charset=utf-8,%EF%BB%BF" + \
        urllib.parse.quote(csv_string)
    return csv_string
