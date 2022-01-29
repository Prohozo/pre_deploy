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
                html.B(html.Div("KHÁCH HÀNG KHÔNG CHĂM SÓC", style={
                    'height': '100%', 'width': '100%', 'background': '#60B664', 'color': 'white', 'text-align': 'center'})),


                html.A(
                    children=[
                        html.I(
                            className="fas fa-file-download")
                    ],
                    id='download_potential_delay',
                    download='KHACH_HANG_KHONG_CHAM_SOC.csv',
                    target="_blank",
                    href='',
                    className='btn btn-primary',
                    style={'position': 'absolute', 'top': '0', 'right': '0', 'paddingTop': '0', 'background': '#60B664', 'border-color': '#60B664',
                           'paddingBottom': '0', 'height': '100%', 'display': 'inline-grid', 'alignItems': 'center'}
                )
            ], style={'height': '7%', 'width': '100%', 'background': '#60B664', 'textAlign': 'center', 'display': 'inline-grid', 'alignItems': 'center', 'position': 'relative'}),

            dash_table.DataTable(
                id='detail_Support_delay',
                columns=[
                    {
                        'name': 'Khách hàng',
                        'id': 'c2.label',
                        'presentation': 'markdown'
                    },
                    {
                        'name': 'Trạng thái',
                        'id': 'a.cf_891'
                    },
                    {
                        'name': 'Nhân viên được giao',
                        'id': 'u.user_name'
                    },
                    {
                        'name': 'Số ticket',
                        'id': 'num_ticket'
                    },
                    {
                        'name': 'Số ngày',
                        'id': 'delay_day'
                    }
                ],
                style_cell_conditional=[
                    {
                        'if': {'column_id': 'c2.label'},
                        'width': '40%',
                        'textAlign': 'center',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'a.cf_891'},
                        'width': '20%',
                        'textAlign': 'center',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'u.user_name'},
                        'width': '20%',
                        'textAlign': 'center',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'num_ticket'},
                        'width': '10%',
                        'textAlign': 'center',
                        'type': 'numeric',
                    },
                    {
                        'if': {'column_id': 'delay_day'},
                        'width': '10%',
                        'textAlign': 'center',
                        'type': 'numeric',
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
    ], className="col-sm-12 col-md-6 col-lg-6 mb-3", style={'height': '75vh'})
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


@app_Support.callback(
    Output("detail_Support_delay", "data"),
    # Trả về databar
    Output("detail_Support_delay", "style_data_conditional"),
    Output('detail_Support_delay', 'page_count'),

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
    Input('detail_Support_delay', 'page_current'),
    Input('detail_Support_delay', 'page_size'),
    Input('detail_Support_delay', 'sort_by'),
    Input('detail_Support_delay', 'filter_query'),


    Input('num_support_byuser', 'clickData'),
    Input('num_support_bystatus', 'selectedData'),
    Input('num_Support_bypri', 'clickData'),
    Input('num_Support_bylocation', 'clickData'),
    Input('detail_Support_delay', 'active_cell'),
    Input('detail_Support', 'active_cell'),

    State('detail_Support_delay', 'data'),
    State('detail_Support', 'data')

)
def UPDATE_detail_Support_delay(date_type, start_date, end_date, account, account_status, user, dept, status, page_current, page_size, sort_by, filter, pareto_user, bar_status, pie_pri, pie_location, ac_delay, ac_detail, data_delay, data_detail):
    ctx = dash.callback_context
    datatable = {'detail_Support_delay': data_delay,
                 'detail_Support': data_detail}
    label, value = GParams_Support.Get_Value(ctx, datatable)
    df1 = DB_Support.get_Support(('detail_delay_without_count', date_type, start_date,
                                 end_date, account, account_status, user, dept, status, None, label, value))
    df2 = DB_Support.get_Support(('detail_delay_with_count', date_type, start_date,
                                 end_date, account, account_status, user, dept, status, None, label, value))

    #df = df1.set_index('c2.crmid').join(df2.set_index('c2.crmid'))
    # df = pd.merge(df1, df2, how='left', left_on=['c2.crmid'], right_on=['c2.crmid'])
    df = df1.merge(df2)
    print(df.shape)
    #df.sort_values(by='delay_day', ascending=False)
    df = df.sort_values(['delay_day', 'c2.label'], ascending=[False, True])
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

    return dff.iloc[page_current * page_size:(page_current + 1)*page_size].to_dict('records'), data_bars(df, 'delay_day'), round(dff.shape[0]/page_size)


@app_Support.callback(
    Output('download_potential_delay', 'href'),

    Input('download_potential_delay', 'n_clicks'),

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
    df1 = DB_Support.get_Support(('detail_delay_without_count', date_type, start_date,
                                 end_date, account, account_status, user, dept, status, None, label, value))
    df2 = DB_Support.get_Support(('detail_delay_with_count', date_type, start_date,
                                 end_date, account, account_status, user, dept, status, None, label, value))

    #df = df1.set_index('c2.crmid').join(df2.set_index('c2.crmid'))
    df = df1.merge(df2)
    #df.sort_values(by='delay_day', ascending=False)
    df = df.sort_values(['delay_day', 'c2.label'], ascending=[False, True])

    # Xử lý tách link ra khỏi tên công ty
    df['c2.label'] = df['c2.label'].apply(lambda x: x.split(']')[0][1:])

    cols = list(df.columns)
    a, b = cols.index('delay_day'), cols.index('num_ticket')
    cols[b], cols[a] = cols[a], cols[b]
    df = df[cols]

    if df.empty:
        csv_string = df.to_csv(index=False, encoding='utf-8', header=[
                               'Mã hỗ trợ', 'Khách hàng', 'Trạng thái', 'Nhân viên được giao', 'Số ticket', 'Số ngày'])
    else:
        csv_string = df.to_csv(index=False, encoding='utf-8', header=[
                               'Mã hỗ trợ', 'Khách hàng', 'Trạng thái', 'Nhân viên được giao', 'Số ticket', 'Số ngày'])

    csv_string = "data:text/csv;charset=utf-8,%EF%BB%BF" + \
        urllib.parse.quote(csv_string)
    return csv_string
