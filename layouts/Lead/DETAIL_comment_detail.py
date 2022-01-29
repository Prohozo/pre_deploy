import dash
from dash import dcc
from dash import html
from dash import dash_table
import pandas as pd
import urllib.parse
from dash.dependencies import Input, Output, State
from static.system_dashboard.css import css_define as css
from utils import GParams_Lead, Graph_Lead
from app import app_Lead
from DB import DB_Lead


def gen_layout():

    layout = html.Div([
        html.Div([
            html.Div([
                html.Div([
                    html.B(html.Div("a", style={
                        'height': '100%', 'width': '100%', 'background': 'white', 'color': 'white', 'text-align': 'center'})),
                ], style={'height': '7%', 'width': '100%', 'background': 'white', 'textAlign': 'center', 'display': 'inline-grid', 'alignItems': 'center', 'position': 'relative'}),

                html.A(
                    children=[
                        html.I(
                            className="fas fa-file-download")
                    ],
                    id='download_comment_detail',
                    download='COMMENT_CHI_TIẾT.csv',
                    target="_blank",
                    href='',
                    className='btn btn-primary',
                    style={'position': 'absolute', 'top': '0', 'right': '0', 'paddingTop': '0', 'background': '#60B664', 'border-color': '#60B664',
                           'paddingBottom': '0', 'height': '100%', 'display': 'inline-grid', 'alignItems': 'center'})
            ], style={'height': '7%', 'width': '100%', 'background': 'white', 'textAlign': 'center', 'display': 'inline-grid', 'alignItems': 'center', 'position': 'relative'}),

            dash_table.DataTable(
                id='comment_detail',

                # Định dạng tên cột
                columns=[
                    {
                        'name': 'Công ty',
                        'id': 'company',
                        'presentation': 'markdown'
                    },
                    {
                        'name': 'Bình luận',
                        'id': 'comment'
                    },
                    {
                        'name': 'Trả lời',
                        'id': 'answer'
                    },
                ],

                # Format độ rộng cho mỗi cột
                style_cell_conditional=[
                    {
                        'if': {'column_id': 'company'},
                        'width': '20%',
                        'textAlign': 'left',
                        'type': 'text',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'comment'},
                        'width': '50%',
                        'textAlign': 'left',
                        'type': 'text',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'answer'},
                        'width': '30%',
                        'textAlign': 'left',
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


@app_Lead.callback(
    Output("comment_detail", "data"),
    Output('comment_detail', 'page_count'),

    # Lấy dữ liệu từ dropdown list
    Input('date_type', 'value'),
    Input('date_filter', 'start_date'),
    Input('date_filter', 'end_date'),
    Input('ddl_lead_company', 'value'),
    Input('ddl_lead_dept', 'value'),
    Input('ddl_lead_source', 'value'),
    Input('ddl_lead_status', 'value'),
    Input('ddl_lead_assign', 'value'),
    Input('ddl_lead_city', 'value'),

    # Pagination, sort, filter
    Input('comment_detail', 'page_current'),
    Input('comment_detail', 'page_size'),
    Input('comment_detail', 'sort_by'),
    Input('comment_detail', 'filter_query'),

    # col, val filter
    Input('num_lead_byindustry', 'clickData'),

    # data of dataTable

)
def UPDATE_comment_detail(date_type, start_date, end_date, company, dept, source, status, assign, city, page_current, page_size, sort_by, filter, ac_industry):
    ctx = dash.callback_context
    datatable = {}
    label, value = GParams_Lead.Get_Value(ctx, datatable)

    df = DB_Lead.Get_Lead(('comment_detail', date_type, start_date, end_date, None, None, None,
                          None, assign, status, source, company, dept, city, label, value, None, None, None, None))

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


@app_Lead.callback(
    Output('download_comment_detail', 'href'),

    Input('download_comment_detail', 'n_clicks'),

    # Dropdown list
    Input('date_type', 'value'),
    Input('date_filter', 'start_date'),
    Input('date_filter', 'end_date'),
    Input('ddl_lead_company', 'value'),
    Input('ddl_lead_dept', 'value'),
    Input('ddl_lead_source', 'value'),
    Input('ddl_lead_status', 'value'),
    Input('ddl_lead_assign', 'value'),
    Input('ddl_lead_city', 'value'),

    # col, val filter
    Input('num_lead_byindustry', 'clickData'),
    Input('num_lead_byuser', 'selectedData'),
)
def UPDATE_DOWNLOAD(click, date_type, start_date, end_date, company, dept, source, status, assign, city, ac_industry, ac_user):
    ctx = dash.callback_context
    datatable = {}
    label, value = GParams_Lead.Get_Value(ctx, datatable)

    # Lấy full table
    df = DB_Lead.Get_Lead(('comment_detail', date_type, start_date, end_date, None, None, None,
                          None, assign, status, source, company, dept, city, label, value, None, None, None, None))

    # Xử lý tách link ra khỏi tên công ty
    df['company'] = df['company'].apply(lambda x: x.split(']')[0][1:])

    # Nếu dataframe trả về trống thì tạo 1 df mới chỉ chứa các cột và giá trị 0
    if df.empty:
        df = pd.DataFrame(
            {'company': ['Không có giá trị'], 'comment': [0], 'answer': [0]})
        csv_string = df.to_csv(index=False, encoding='utf-8',
                               header=['Công ty', 'Bình luận', 'Trả lời'])
    else:
        csv_string = df.to_csv(index=False, encoding='utf-8',
                               header=['Công ty', 'Bình luận', 'Trả lời'])
    csv_string = "data:text/csv;charset=utf-8,%EF%BB%BF" + \
        urllib.parse.quote(csv_string)

    return csv_string
# colors=['#107a8b', '#2cb978', '#60B664', '#3b5441']
