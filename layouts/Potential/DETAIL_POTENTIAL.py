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
                ], style={'height': '7%', 'width': '100%', 'background': '#60B664', 'textAlign': 'center', 'display': 'inline-grid', 'alignItems': 'center', 'position': 'relative'}),


                # Slider doanh thu
                html.Div([
                    html.P(id='title_prob', children='Xác xuất', className='col-2', style={
                           'color': 'white', 'font-family': 'nunito', 'font-size': '25px !important', 'font-weight': 'bold', 'text-align': 'left', 'margin-left': '10px'}),
                    dcc.RangeSlider(
                        id='prob_slider',
                        min=0,
                        max=100,
                        allowCross=False,
                        value=[0, 100],
                        marks={i: {'label': f'{i}%', 'style': {'color': 'white'}}
                               for i in range(0, 101, 10)},
                        step=5,
                        className='col-9'
                    ),
                ], className='ele_row m-b-15', style={'margin-top': '20px'}),

                html.A(
                    children=[
                        html.I(
                            className="fas fa-file-download")
                    ],
                    id='download_potential_detail',
                    download='CO_HOI_CHI_TIET.csv',
                    target="_blank",
                    href='',
                    className='btn btn-primary',
                    style={'position': 'absolute', 'top': '0', 'right': '0', 'paddingTop': '0', 'background': '#60B664', 'border-color': '#60B664',
                           'paddingBottom': '0', 'height': '100%', 'display': 'inline-grid', 'alignItems': 'center'}
                )
            ], style={'height': '13%', 'width': '100%', 'background': '#60B664', 'textAlign': 'center', 'display': 'inline-grid', 'alignItems': 'center', 'position': 'relative'}),

            dash_table.DataTable(
                id='detail_potential',
                columns=[
                    {
                        'name': 'Cơ hội',
                        'id': 'p.potentialname',
                        'presentation': 'markdown'
                    },
                    {
                        'name': 'Số hoạt động',
                        'id': 'num_ac'
                    },
                    {
                        'name': 'Giai đoạn bán hàng',
                        'id': 'p.sales_stage'
                    },
                    {
                        'name': 'Nhân viên phân công',
                        'id': 'u.user_name'
                    },

                    {
                        'name': 'Giá trị dự kiến',
                        'id': 'p.forecast_amount'
                    },
                    {
                        'name': 'Xác xuất',
                        'id': 'p.probability'
                    },

                    {
                        'name': 'Thời gian tạo',
                        'id': 'c.createdtime'
                    },
                    {
                        'name': 'Thời gian sửa',
                        'id': 'c.modifiedtime'
                    },
                    {
                        'name': 'Ngày đóng',
                        'id': 'p.closingdate'
                    }
                ],
                style_cell_conditional=[
                    {
                        'if': {'column_id': 'p.potentialname'},
                        'width': '15%',
                        'textAlign': 'left',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'num_ac'},
                        'width': '5%',
                        'textAlign': 'center',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'p.sales_stage'},
                        'width': '10%',
                        'textAlign': 'center',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'u.user_name'},
                        'width': '10%',
                        'textAlign': 'center',
                        'padding-left': '15px'
                    },

                    {
                        'if': {'column_id': 'p.forecast_amount'},
                        'width': '5%',
                        'textAlign': 'center',
                        'type': 'numeric',
                    },
                    {
                        'if': {'column_id': 'p.probability'},
                        'width': '5%',
                        'textAlign': 'center',
                        'type': 'numeric',
                    },
                    {
                        'if': {'column_id': 'c.createdtime'},
                        'width': '7.5%',
                        'textAlign': 'center',
                        'type': 'datetime',
                    },
                    {
                        'if': {'column_id': 'c.modifiedtime'},
                        'width': '7.5%',
                        'textAlign': 'center',
                        'type': 'datetime',
                    },
                    {
                        'if': {'column_id': 'p.closingdate'},
                        'width': '8%',
                        'textAlign': 'center',
                        'type': 'datetime',
                    }

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
    Output("detail_potential", "data"),
    Output('detail_potential', 'page_count'),
    Output('title_prob', 'children'),

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
    Input('prob_slider', 'value'),

    # Pagination, sort, filter
    Input('detail_potential', 'page_current'),
    Input('detail_potential', 'page_size'),
    Input('detail_potential', 'sort_by'),
    Input('detail_potential', 'filter_query'),

    # col, val filter
    # Input('num_potential_byindustry', 'clickData'),
    # Input('num_potential_byuser', 'selectedData'),

    # data of dataTable

)
def UPDATE_detail_potential_bycity(date_type, start_date, end_date, potential, sales_stage, product, dept, assign, value_prob, page_current, page_size, sort_by, filter):
    ctx = dash.callback_context
    datatable = {}
    label, value = GParams_Potential.Get_Value(ctx, datatable)
    df = DB_potential.Get_potential(('potential_detail', date_type, start_date, end_date, value_prob[0], value_prob[
                                    1], None, None, assign, None, None, None, sales_stage, potential, dept, product, None, label, value, None, None, None, None))

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
    dff['c.createdtime'] = pd.DatetimeIndex(
        dff['c.createdtime']).strftime("%d-%m-%Y %I:%M %p")
    dff['c.modifiedtime'] = pd.DatetimeIndex(
        dff['c.modifiedtime']).strftime("%d-%m-%Y %I:%M %p")
    dff['p.closingdate'] = pd.DatetimeIndex(
        dff['p.closingdate']).strftime("%d-%m-%Y")
    return dff.iloc[page_current * page_size:(page_current + 1)*page_size].to_dict('records'), round(dff.shape[0]/page_size), f'Xác xuất (từ {value_prob[0]:0,.0f}% đến {value_prob[1]:0,.0f}%)'


@app_Potential.callback(
    Output('download_potential_detail', 'href'),

    Input('download_potential_detail', 'n_clicks'),

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
    Input('prob_slider', 'value'),
)
def UPDATE_DOWNLOAD(click, date_type, start_date, end_date, potential, sales_stage, product, dept, assign, value_prob):
    ctx = dash.callback_context
    datatable = {}
    label, value = GParams_Potential.Get_Value(ctx, datatable)

    # Lấy full table
    df = DB_potential.Get_potential(('potential_detail', date_type, start_date, end_date, value_prob[0], value_prob[
                                    1], None, None, assign, None, None, None, sales_stage, potential, dept, product, None, label, value, None, None, None, None))

    # Xử lý tách link ra khỏi tên công ty
    df['p.potentialname'] = df['p.potentialname'].apply(lambda x: x.split(']')[
                                                        0][1:])

    if df.empty:
        csv_string = df.to_csv(index=False, encoding='utf-8', header=['Cơ hội', 'Số hoạt động', 'Giai đoạn bán hàng',
                                                                      'Nhân viên được giao', 'Giá trị dự kiến', 'Xác xuất', 'Thời gian tạo', 'Thời gian sửa', 'Thời gian đóng'])
    else:
        csv_string = df.to_csv(index=False, encoding='utf-8', header=['Cơ hội', 'Số hoạt động', 'Giai đoạn bán hàng',
                                                                      'Nhân viên được giao', 'Giá trị dự kiến', 'Xác xuất', 'Thời gian tạo', 'Thời gian sửa', 'Thời gian đóng'])

    csv_string = "data:text/csv;charset=utf-8,%EF%BB%BF" + \
        urllib.parse.quote(csv_string)
    return csv_string
