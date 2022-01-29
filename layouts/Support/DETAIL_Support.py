import dash
from dash import dcc
from dash import html
from dash import dash_table
import pandas as pd
import urllib.parse
from dash.dependencies import Input, Output, State
from static.system_dashboard.css import css_define as css
from utils import GParams_Support
from app import app_Support
from DB import DB_Support


def gen_layout():

    layout = html.Div([
        html.Div([
            html.Div([
                html.Div([
                    html.B(html.Div("CHI TIẾT HỖ TRỢ", style={
                        'height': '100%', 'width': '100%', 'background': '#60B664', 'color': 'white', 'text-align': 'center'})),
                ], style={'height': '7%', 'width': '100%', 'background': '#60B664', 'textAlign': 'center', 'display': 'inline-grid', 'alignItems': 'center', 'position': 'relative'}),

                html.A(
                    children=[
                        html.I(
                            className="fas fa-file-download")
                    ],
                    id='download_Support_detail',
                    download='CHI_TIET_HO_TRO.csv',
                    target="_blank",
                    href='',
                    className='btn btn-primary',
                    style={'position': 'absolute', 'top': '0', 'right': '0', 'paddingTop': '0', 'background': '#60B664', 'border-color': '#60B664',
                           'paddingBottom': '0', 'height': '100%', 'display': 'inline-grid', 'alignItems': 'center'}
                )
            ], style={'height': '13%', 'width': '100%', 'background': '#60B664', 'textAlign': 'center', 'display': 'inline-grid', 'alignItems': 'center', 'position': 'relative'}),

            dash_table.DataTable(
                id='detail_Support',
                columns=[
                    {
                        'name': 'Hỗ trợ',
                        'id': 'c.label',
                        'presentation': 'markdown'
                    },
                    {
                        'name': 'Nội dung',
                        'id': 'c.description'
                    },
                    {
                        'name': 'Nhân viên được giao',
                        'id': 'u.user_name'
                    },
                    {
                        'name': 'Trạng thái',
                        'id': 't.status'
                    },
                    {
                        'name': 'Ưu tiên',
                        'id': 't.priority'
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
                        'name': 'Khách hàng',
                        'id': 'c2.label',
                        'presentation': 'markdown'
                    }
                ],
                style_cell_conditional=[
                    {
                        'if': {'column_id': 'c.label'},
                        'width': '15%',
                        'textAlign': 'left',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'c.description'},
                        'width': '15%',
                        'textAlign': 'left',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'u.user_name'},
                        'width': '10%',
                        'textAlign': 'center',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 't.status'},
                        'width': '10%',
                        'textAlign': 'center',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 't.priority'},
                        'width': '10%',
                        'textAlign': 'center',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'c.createdtime'},
                        'width': '10%',
                        'textAlign': 'center',
                        'type': 'datetime',
                    },
                    {
                        'if': {'column_id': 'c.modifiedtime'},
                        'width': '10%',
                        'textAlign': 'center',
                        'type': 'datetime',
                    },
                    {
                        'if': {'column_id': 'c2.label'},
                        'width': '20%',
                        'textAlign': 'left',
                        'padding-left': '15px'
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
    ], className="col-12 mb-3", style={'height': '100%'})
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


@app_Support.callback(
    Output("detail_Support", "data"),
    Output('detail_Support', 'page_count'),


    # Lấy dữ liệu từ dropdown list
    Input('date_type', 'value'),
    Input('date_filter', 'start_date'),
    Input('date_filter', 'end_date'),
    Input('ddl_account', 'value'),
    Input('ddl_account_status', 'value'),
    Input('ddl_user_assign', 'value'),
    Input('ddl_dept', 'value'),
    Input('ddl_status', 'value'),

    # Pagination, sort, filter
    Input('detail_Support', 'page_current'),
    Input('detail_Support', 'page_size'),
    Input('detail_Support', 'sort_by'),
    Input('detail_Support', 'filter_query'),

    Input('num_support_byuser', 'clickData'),
    Input('num_support_bystatus', 'selectedData'),
    Input('num_Support_bypri', 'clickData'),
    Input('num_Support_bylocation', 'clickData'),
    Input('detail_Support_delay', 'active_cell'),
    Input('detail_Support', 'active_cell'),

    State('detail_Support_delay', 'data'),
    State('detail_Support', 'data')

)
def UPDATE_detail_Support_bycity(date_type, start_date, end_date, account, account_status, user, dept, status,  page_current, page_size, sort_by, filter, pareto_user, bar_status, pie_pri, pie_location, ac_delay, ac_detail, data_delay, data_detail):
    ctx = dash.callback_context
    datatable = {'detail_Support_delay': data_delay,
                 'detail_Support': data_detail}
    label, value = GParams_Support.Get_Value(ctx, datatable)
    df = DB_Support.get_Support(('detail', date_type, start_date, end_date,
                                account, account_status, user, dept, status, None, label, value))

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
        dff['c.createdtime']).strftime("%d-%m-%Y")
    dff['c.modifiedtime'] = pd.DatetimeIndex(
        dff['c.modifiedtime']).strftime("%d-%m-%Y")
    return dff.iloc[page_current * page_size:(page_current + 1)*page_size].to_dict('records'), round(dff.shape[0]/page_size)


@app_Support.callback(
    Output('download_Support_detail', 'href'),

    Input('download_Support_detail', 'n_clicks'),

    # Lấy dữ liệu từ dropdown list
    Input('date_type', 'value'),
    Input('date_filter', 'start_date'),
    Input('date_filter', 'end_date'),
    Input('ddl_account', 'value'),
    Input('ddl_account_status', 'value'),
    Input('ddl_user_assign', 'value'),
    Input('ddl_dept', 'value'),
    Input('ddl_status', 'value'),


    Input('num_support_byuser', 'clickData'),
    Input('num_support_bystatus', 'selectedData'),
    Input('num_Support_bypri', 'clickData'),
    Input('num_Support_bylocation', 'clickData'),
    Input('detail_Support_delay', 'active_cell'),
    Input('detail_Support', 'active_cell'),

    State('detail_Support_delay', 'data'),
    State('detail_Support', 'data')
)
def UPDATE_DOWNLOAD(click, date_type, start_date, end_date, account, account_status, user, dept, status, pareto_user, bar_status, pie_pri, pie_location, ac_delay, ac_detail, data_delay, data_detail):
    ctx = dash.callback_context
    datatable = {'detail_Support_delay': data_delay,
                 'detail_Support': data_detail}
    label, value = GParams_Support.Get_Value(ctx, datatable)

    # Lấy full table
    df = DB_Support.get_Support(('detail', date_type, start_date, end_date,
                                account, account_status, user, dept, status, None, label, value))

    # Xử lý tách link ra khỏi tên công ty
    df['c.label'] = df['c.label'].apply(lambda x: x.split(']')[0][1:])

    if df.empty:
        csv_string = df.to_csv(index=False, encoding='utf-8', header=['Mã hỗ trợ', 'Hỗ trợ', 'Nội dung',
                               'Nhân viên được giao', 'Trạng thái', 'Ưu tiên', 'Ngày tạo', 'Ngày chỉnh sửa', 'Mã khách hàng', 'Khách hàng'])
    else:
        csv_string = df.to_csv(index=False, encoding='utf-8', header=['Mã hỗ trợ', 'Hỗ trợ', 'Nội dung',
                               'Nhân viên được giao', 'Trạng thái', 'Ưu tiên', 'Ngày tạo', 'Ngày chỉnh sửa', 'Mã khách hàng', 'Khách hàng'])

    csv_string = "data:text/csv;charset=utf-8,%EF%BB%BF" + \
        urllib.parse.quote(csv_string)
    return csv_string
