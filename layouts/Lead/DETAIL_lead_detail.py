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

    # Gọi full bảng chi tiết để tạo mark cho slider
    df = DB_Lead.Get_Lead(('lead_detail', None, None, None, None, None, None, None,
                          None, None, None, None, None, None, None, None, None, None, None, None))

    # Tạo mark cho slider doanh thu và sl nhân viên
    mark_emp = {i: {'label': f'{int(i/1000)}K', 'style': {'color': 'white'}}
                for i in range(0, int(df['ld.noofemployees'].max()+1), 1000)}
    mark_rev = {i: {'label': str(i)[:int(len(str(i))) % 10 + 1]+' Tỷ', 'style': {'color': 'white'}}
                for i in range(0, int(df['ld.annualrevenue'].max()+1), 10000000000)}  # 10 ty

    layout = html.Div([
        html.Div([
            html.Div([

                # Tiêu đề bảng
                html.Div([
                    html.B(html.Div(" ", style={
                        'height': '100%', 'width': '100%', 'background': '#60B664', 'color': 'white', 'text-align': 'center'})),
                ], style={'height': '7%', 'width': '100%', 'background': '#60B664', 'textAlign': 'center', 'display': 'inline-grid', 'alignItems': 'center', 'position': 'relative'}),

                html.Div([

                    # Slider doanh thu
                    html.Div([
                        html.P(id='title_rev', children='Doanh thu', className='col-2', style={
                               'color': 'white', 'font-family': 'nunito', 'font-size': '25px !important', 'font-weight': 'bold', 'text-align': 'left', 'margin-left': '10px'}),
                        dcc.RangeSlider(
                            id='revenue_slider',
                            min=int(
                                df['ld.annualrevenue'].min()),
                            max=int(
                                df['ld.annualrevenue'].max()),
                            allowCross=False,
                            value=[int(df['ld.annualrevenue'].min()), int(
                                df['ld.annualrevenue'].max())],
                            marks=mark_rev,
                            step=1000000000,  # 1 ty
                            className='col-9'
                        ),
                    ], className='ele_row m-b-15', style={'margin-top': '20px'}),

                    # Slider số lượng nhân viên
                    html.Div([
                        html.P(id='title_emp', children='Số lượng nhân viên', className='col-2', style={
                               'color': 'white', 'font-family': 'nunito', 'font-size': '25px !important', 'font-weight': 'bold', 'text-align': 'left', 'margin-left': '10px'}),
                        dcc.RangeSlider(
                            id='emp_slider',
                            min=int(
                                df['ld.noofemployees'].min()),
                            max=int(
                                df['ld.noofemployees'].max()),
                            allowCross=False,
                            value=[int(df['ld.noofemployees'].min()), int(
                                df['ld.noofemployees'].max())],
                            marks=mark_emp,
                            step=100,
                            className='col-9'
                        ),
                    ], className='ele_row m-b-15', style={'margin-top': '20px'}),
                ]),

                # Nút download
                html.A(
                    children=[
                        html.I(
                            className="fas fa-file-download")
                    ],
                    id='download_lead_detail',
                    download='LEAD_CHI_TIẾT.csv',
                    target="_blank",
                    href='',
                    className='btn btn-primary',
                    style={'position': 'absolute', 'top': '0', 'right': '0', 'paddingTop': '0', 'background': '#60B664', 'border-color': '#60B664',
                           'paddingBottom': '0', 'height': '100%', 'display': 'inline-grid', 'alignItems': 'center'}
                )
            ], style={'height': '7%', 'width': '100%', 'background': '#60B664', 'textAlign': 'center', 'display': 'inline-grid', 'alignItems': 'center', 'position': 'relative'}),

            dash_table.DataTable(
                id='lead_detail',

                # Định dạng tên cột
                columns=[
                    {
                        'name': 'Công ty',
                        'id': 'ld.company',
                        'presentation': 'markdown'
                    },
                    {
                        'name': 'Họ và tên',
                        'id': 'ld.name'
                    },
                    {
                        'name': 'Nhân viên được giao',
                        'id': 'u.user_name'
                    },
                    {
                        'name': 'Nguồn',
                        'id': 'ld.leadsource'
                    },
                    {
                        'name': 'Trạng thái',
                        'id': 'ld.leadstatus'
                    },
                    {
                        'name': 'Số lượng nhân viên',
                        'id': 'ld.noofemployees'
                    },
                    {
                        'name': 'Doanh thu',
                        'id': 'ld.annualrevenue'
                    },
                    {
                        'name': 'Lĩnh vực',
                        'id': 'ld.industry'
                    },
                    {
                        'name': 'Thành phố',
                        'id': 'la.city'
                    },
                    {
                        'name': 'Thời gian',
                        'id': 'c.createdtime'
                    }
                ],

                # Format độ rộng cho mỗi cột
                style_cell_conditional=[
                    {
                        'if': {'column_id': 'ld.company'},
                        'width': '20%',
                        'textAlign': 'left',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'ld.name'},
                        'width': '10%',
                        'textAlign': 'left',
                        'type': 'text',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'u.user_name'},
                        'width': '10%',
                        'type': 'text',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'ld.leadsource'},
                        'width': '10%',
                        'type': 'text',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'ld.leadstatus'},
                        'width': '8%',
                        'type': 'text',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'ld.noofemployees'},
                        'width': '6%',
                        'type': 'numeric',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'ld.annualrevenue'},
                        'width': '10%',
                        'type': 'numeric',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'ld.industry'},
                        'width': '10%',
                        'type': 'text',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'la.city'},
                        'width': '10%',
                        'type': 'text',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'c.createdtime'},
                        'width': '10%',
                        'padding-left': '15px',
                                        'type': 'datetime'
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
    Output("lead_detail", "data"),
    Output('lead_detail', 'page_count'),

    # Slider
    Output('title_emp', 'children'),
    Output('title_rev', 'children'),

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

    Input('revenue_slider', 'value'),
    Input('emp_slider', 'value'),

    # Pagination, sort, filter
    Input('lead_detail', 'page_current'),
    Input('lead_detail', 'page_size'),
    Input('lead_detail', 'sort_by'),
    Input('lead_detail', 'filter_query'),

    # col, val filter
    Input('num_lead_byindustry', 'clickData'),
    Input('num_lead_byuser', 'selectedData'),

    # data of dataTable

)
def UPDATE_lead_detail(date_type, start_date, end_date, company, dept, source, status, assign, city, value_rev, value_emp, page_current, page_size, sort_by, filter, ac_industry, ac_user):
    ctx = dash.callback_context
    datatable = {}
    if page_current == 0:
        label, value = GParams_Lead.Get_Value(ctx, datatable)
    else:
        label, value = GParams_Lead.Get_Value(
            ctx, datatable, page_current, page_size)

    # Nếu giá trị slider bị trống thì trả về giá trị min, max=0
    if value_emp is None:
        value_emp = [0, 0]

    if value_rev is None:
        value_rev = [0, 0]

    df = DB_Lead.Get_Lead(('lead_detail', date_type, start_date, end_date, value_rev[0], value_rev[1], value_emp[
                          0], value_emp[1], assign, status, source, company, dept, city, label, value, None, None, None, None))

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
    return dff.iloc[page_current * page_size:(page_current + 1)*page_size].to_dict('records'), round(dff.shape[0]/page_size), f'Số lượng nhân viên (từ {value_emp[0]:0,.0f} đến {value_emp[1]:0,.0f})', f'Doanh thu (từ {value_rev[0]:0,.0f}đ đến {value_rev[1]:0,.0f}đ)'

# Download callback


@app_Lead.callback(
    Output('download_lead_detail', 'href'),

    Input('download_lead_detail', 'n_clicks'),

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

    # Slider
    Input('revenue_slider', 'value'),
    Input('emp_slider', 'value'),

    # col, val filter
    Input('num_lead_byindustry', 'clickData'),
)
def UPDATE_DOWNLOAD(click, date_type, start_date, end_date, company, dept, source, status, assign, city, value_rev, value_emp, ac_industry):
    ctx = dash.callback_context
    datatable = {}
    label, value = GParams_Lead.Get_Value(ctx, datatable)

    # Lấy full table
    df = DB_Lead.Get_Lead(('lead_detail', date_type, start_date, end_date, value_rev[0], value_rev[1], value_emp[
                          0], value_emp[1], assign, status, source, company, dept, city, label, value, None, None, None, None))

    # Xử lý tách link ra khỏi tên công ty
    df['ld.company'] = df['ld.company'].apply(lambda x: x.split(']')[0][1:])

    # Nếu dataframe trả về trống thì tạo 1 df mới chỉ chứa các cột và giá trị 0
    if df.empty:
        df = pd.DataFrame({'Công ty': [0], 'Họ và tên': [0], 'Nhân viên được giao': [0], 'Nguồn': [0], 'Trạng thái': [
                          0], 'Số lượng nhân viên': [0], 'Doanh thu': [0], 'Lĩnh vực': [0], 'Thành phố': [0], 'Thời gian tạo': [0]})
        csv_string = df.to_csv(index=False, encoding='utf-8', header=['Công ty', 'Họ và tên', 'Nhân viên được giao',
                               'Nguồn', 'Trạng thái', 'Số lượng nhân viên', 'Doanh thu', 'Lĩnh vực', 'Thành phố', 'Thời gian tạo'])
    else:
        csv_string = df.to_csv(index=False, encoding='utf-8', header=['Công ty', 'Họ và tên', 'Nhân viên được giao',
                               'Nguồn', 'Trạng thái', 'Số lượng nhân viên', 'Doanh thu', 'Lĩnh vực', 'Thành phố', 'Thời gian tạo'])
    csv_string = "data:text/csv;charset=utf-8,%EF%BB%BF" + \
        urllib.parse.quote(csv_string)

    return csv_string
# colors=['#107a8b', '#2cb978', '#60B664', '#3b5441']
