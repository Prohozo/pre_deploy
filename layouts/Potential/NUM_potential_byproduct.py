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
                html.B(html.Div("SỐ CƠ HỘI THEO SẢN PHẨM", style={
                    'width': '100%', 'background': '#60B664', 'color': 'white', 'text-align': 'center'})),
                html.A(
                    children=[
                        html.I(
                            className="fas fa-file-download")
                    ],
                    id='download_potential_byproduct',
                    download='CO_HOI_THEO_SAN_PHAM.csv',
                    target="_blank",
                    href='',
                    className='btn btn-primary',
                    style={'position': 'absolute', 'top': '0', 'right': '0', 'paddingTop': '0', 'background': '#60B664', 'border-color': '#60B664',
                           'paddingBottom': '0', 'height': '100%', 'display': 'inline-grid', 'alignItems': 'center'})
            ], style={'height': '7%', 'width': '100%', 'background': '#60B664', 'textAlign': 'center', 'display': 'inline-grid', 'alignItems': 'center', 'position': 'relative'}),

            dash_table.DataTable(
                id='num_potential_byproduct',

                # Định dạng tên cột
                columns=[
                    {
                        'name': 'Sản phẩm',
                        'id': 'pr.productname'
                    },
                    {
                        'name': 'Số cơ hội',
                        'id': 'num'
                    },
                ],

                # Format độ rộng cho mỗi cột
                style_cell_conditional=[
                    {
                        'if': {'column_id': 'pr.productname'},
                        'width': '60%',
                        'textAlign': 'left',
                        'type': 'text',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'num'},
                        'width': '40%',
                        'textAlign': 'center',
                        'type': 'numberic'
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
    ], className="col-sm-12 col-md-6 col-lg-6 mb-3", style={'height': '50vh'})
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
    Output("num_potential_byproduct", "data"),
    Output('num_potential_byproduct', 'page_count'),

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

    # Pagination, sort, filter
    Input('num_potential_byproduct', 'page_current'),
    Input('num_potential_byproduct', 'page_size'),
    Input('num_potential_byproduct', 'sort_by'),
    Input('num_potential_byproduct', 'filter_query'),

    # col, val filter
    # Input('num_potential_byindustry', 'clickData'),

    # data of dataTable

)
def UPDATE_num_potential_byproduct(date_type, start_date, end_date, potential, sales_stage, product, dept, assign, page_current, page_size, sort_by, filter):
    ctx = dash.callback_context
    datatable = {}
    label, value = GParams_Potential.Get_Value(ctx, datatable)

    df = DB_potential.Get_potential(('num_potential_byproduct', date_type, start_date, end_date, None, None, None, None,
                                     assign, None, None, None, sales_stage, potential, dept, product, None, label, value, None, None, None, None))

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

    return dff.iloc[page_current * page_size:(page_current + 1)*page_size].to_dict('records'), round(dff.shape[0]/page_size)

# Download callback


@app_Potential.callback(
    Output('download_potential_byproduct', 'href'),

    Input('download_potential_byproduct', 'n_clicks'),

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
def UPDATE_DOWNLOAD(click, date_type, start_date, end_date, potential, sales_stage, product, dept, assign):
    ctx = dash.callback_context
    datatable = {}
    label, value = GParams_Potential.Get_Value(ctx, datatable)

    # Lấy full table
    df = DB_potential.Get_potential(('num_potential_byproduct', date_type, start_date, end_date, None, None, None, None,
                                     assign, None, None, None, sales_stage, potential, dept, product, None, label, value, None, None, None, None))

    # # Xử lý tách link ra khỏi tên công ty
    # df['pr.productname'] = df['pr.productname'].apply(lambda x: x.split(']')[0][1:])

    # Nếu dataframe trả về trống thì tạo 1 df mới chỉ chứa các cột và giá trị 0
    if df.empty:
        df = pd.DataFrame({'pr.productname': ['Không có giá trị'], 'num': [0]})
        csv_string = df.to_csv(index=False, encoding='utf-8',
                               header=['Sản phẩm', 'Số cơ hội'])
    else:
        csv_string = df.to_csv(index=False, encoding='utf-8',
                               header=['Sản phẩm', 'Số cơ hội'])
    csv_string = "data:text/csv;charset=utf-8,%EF%BB%BF" + \
        urllib.parse.quote(csv_string)

    return csv_string
