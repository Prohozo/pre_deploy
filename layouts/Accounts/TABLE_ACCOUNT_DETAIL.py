import dash
from dash import dcc
from dash import html
from dash.html import Br
from dash.html import Div
from dash import dash_table
import urllib.parse
import pandas as pd
from static.system_dashboard.css import css_define as css
from dash.dash_table.Format import Format, Scheme
from DB import DB_Accounts
from dash.dependencies import Input, Output, State
from utils import GParams_Accounts
from utils import Graph_Accounts
from app import app_Accounts


def gen_layout():
    df = DB_Accounts.GET_ACCOUNTS(('account_detail', None, None, None, None,
                                  None, None, None, None, None, None, None, None, None, None, None, None))

    # Tạo mark cho slider doanh thu và sl nhân viên
    mark_emp = {i: {'label': f'{i:0,.0f}', 'style': {'color': 'black'}}
                for i in range(0, int(df['employee'].max()+1), 1000)}
    mark_rev = {i*10000000000: {'label': str(i)+'0 Tỷ', 'style': {'color': 'black'}}
                for i in range(0, int(df['revenue'].max()/10000000000+1), 1)}

    layout = html.Div([
        html.Div([
            html.Div([
                html.Div("BẢNG CHI TIẾT KHÁCH HÀNG", style={
                         'width': '100%', 'fontWeight': 'bold', 'background': '#FF938B'}),
                html.A(
                    children=[
                        html.I(
                            className="fas fa-file-download")
                    ],
                    id='download_detail_account_detail',
                    download="DETAIL_ACCOUNTS.csv",
                    target="_blank",
                    href='',
                    className='btn btn-primary',
                    style={'position': 'absolute', 'top': '0', 'right': '0', 'paddingTop': '0', 'paddingBottom': '0', 'marginTop': '2%', 'marginRight': '3%', 'height': '50%', 'display': 'inline-grid', 'alignItems': 'center', 'backgroundColor': '#FF938B', 'borderColor': '#FF938B'}),
            ], style={'height': '10%', 'width': '100%', 'background': '#FF938B', 'textAlign': 'center', 'display': 'inline-grid', 'alignItems': 'center', 'position': 'relative'}),
            dash_table.DataTable(
                id='account_detail',
                columns=[
                    {
                        'name': 'Tên khách hàng',
                        'id': 'c.label',
                        'presentation': 'markdown'
                    },
                    {
                        'name': 'Lĩnh vực',
                        'id': 'a.industry',
                    },
                    {
                        'name': 'Tỉnh thành',
                        'id': 'ad.ship_city',
                    },
                    {
                        'name': 'Số lượng liên hệ',
                        'id': 'SL_contact',
                    },
                    {
                        'name': 'Số lượng cơ hội',
                        'id': 'SL_potential',
                    },
                    {
                        'name': 'Số lượng đơn hàng',
                        'id': 'SL_salesorder',
                    },
                    {
                        'name': 'Doanh thu',
                        'id': 'revenue',
                    },
                    {
                        'name': 'Số lượng nhân viên',
                        'id': 'employee',
                    },
                    {
                        'name': 'Ngày tạo',
                        'id': 'c.createdtime',
                    },
                    {
                        'name': 'Ngày sửa',
                        'id': 'c.modifiedtime',
                    },

                ],
                style_cell_conditional=[
                    {
                        'if': {'column_id': 'c.label'},
                        'width': '40%',
                        'vertical-align': 'text-top',
                        'textAlight': 'left',
                        'padding-left': '15px',
                    },
                    {
                        'if': {'column_id': 'a.industry'},
                        'width': '6%',
                        'textAlign': 'center',

                    },

                    {
                        'if': {'column_id': 'ad.ship_city'},
                        'width': '6%',
                        'textAlign': 'center',

                    },
                    {
                        'if': {'column_id': 'SL_contact'},
                        'width': '6%',
                        'textAlign': 'center',

                    },
                    {
                        'if': {'column_id': 'SL_potential'},
                        'width': '6%',
                        'textAlign': 'center',

                    },
                    {
                        'if': {'column_id': 'SL_salesorder'},
                        'width': '6%',
                        'textAlign': 'center',

                    },
                    {
                        'if': {'column_id': 'revenue'},
                        'width': '6%',
                        'textAlign': 'center',

                    },
                    {
                        'if': {'column_id': 'employee'},
                        'width': '6%',
                        'textAlign': 'center',

                    },
                    {
                        'if': {'column_id': 'c.createdtime'},
                        'width': '6%',
                        'textAlign': 'center',

                    },
                    {
                        'if': {'column_id': 'c.modifiedtime'},
                        'width': '6%',
                        'textAlign': 'center',

                    },

                ],

                css=[
                    {
                        'selector': '.dash-fixed-content',
                        'rule': 'width: 100%;'
                    },
                    {
                        'selector': 'p',
                        'rule': 'text-align : left'
                    }
                ],
                fixed_rows={'headers': True},
                style_header=css.style_header,
                style_cell=css.style_cell,
                page_current=0,
                page_size=50,
                style_table={'height': '100%', 'width': '100%'},
                page_action='custom',

                sort_mode='multi',
                sort_action="custom",
                sort_by=[],

                filter_action='custom',
                filter_query='',

            ),
            html.Br(),
            html.Div([
                html.Div(id='output_revenue_slider', style={
                         'width': '100%', 'fontWeight': 'bold'}),
                dcc.RangeSlider(
                    id='revenue_slider',
                    min=min(df['revenue']),
                    max=max(df['revenue']),
                    marks=mark_rev,
                    step=1000000000,
                    value=[min(df['revenue']), max(df['revenue'])],
                )
            ], style={'marginLeft': '2%', 'width': '95%', 'height': '10%'}),
            html.Br(),
            html.Div([
                html.Div(id='output_employee_slider', style={
                         'width': '100%', 'fontWeight': 'bold'}),
                dcc.RangeSlider(
                    id='employee_slider',
                    min=min(df['employee']),
                    max=max(df['employee']),
                    marks=mark_emp,
                    step=10,
                    value=[min(df['employee']),
                           max(df['employee'])],
                ),
            ], style={'marginLeft': '2%', 'width': '95%', 'height': '10%'}),
        ], className="au-card", style={'height': '100%'})
    ], className="col-12 mb-3", style={'height': '100vh'})

    return layout


operators = [['ge ', '>='],
             ['le ', '<='],
             ['lt ', '<'],
             ['gt ', '>'],
             ['ne ', '!='],
             ['eq ', '='],
             ['contains '],
             ['datestartswith ']]


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


@app_Accounts.callback(
    Output("account_detail", "data"),
    Output("output_revenue_slider", "children"),
    Output("output_employee_slider", "children"),
    [Input('ddl_timetype', 'value'),
        Input('date-picker-range', 'start_date'),
        Input('date-picker-range', 'end_date'),
        Input('ddl_leadsource', 'value'),
        Input('ddl_industry', 'value'),
        Input('ddl_account', 'value'),
        Input('ddl_user_assign', 'value'),
        Input('ddl_user_marketing', 'value'),
        Input('ddl_user_service', 'value'),
        Input('ddl_dept', 'value'),
        Input('grh_bar_status', 'selectedData'),
        Input('grh_parento_industry', 'clickData'),
        Input('grh_bar_user_assign', 'selectedData'),
        # Input('grh_bar_user_marketing', 'selectedData'),
        # Input('grh_bar_user_service', 'selectedData'),
        Input('grh_map_city', 'clickData'),
        Input('user_detail', 'active_cell'),
        Input('account_detail', 'active_cell'),
        Input('city', 'active_cell'),
        Input('revenue_slider', 'value'),
        Input('employee_slider', 'value'),
        Input('account_detail', 'page_current'),
        Input('account_detail', 'page_size'),
        Input('account_detail', 'sort_by'),
        Input('account_detail', 'filter_query'),
     ],
    [State('user_detail', 'data'),
     State('account_detail', 'data'),
     State('city', 'data')]
)
def UPDATE_ACCOUNT_DETAIL(ddl_timetype, start_date, end_date, ddl_leadsource, ddl_industry, ddl_account, ddl_user_assign, ddl_dept, status, industry, user_assign, user_marketing, user_service, map_city, ac_user_detail, ac_account_detail, ac_city, revenue_slider, employee_slider, page_current, page_size, sort_by, filter, data_user_detail, data_account_detail, data_city):
    ctx = dash.callback_context
    datatable = {'user_detail': data_user_detail,
                 'account_detail': data_account_detail,
                 'city': data_city,
                 }
    label, value = GParams_Accounts.Get_Value(ctx, datatable)
    if revenue_slider is None:
        revenue_slider = [0, 0]
    if employee_slider is None:
        employee_slider = [0, 0]

    df = DB_Accounts.GET_ACCOUNTS(('account_detail', ddl_timetype, start_date, end_date, ddl_leadsource, ddl_industry, ddl_account, ddl_user_assign,
                                   ddl_dept, revenue_slider[0], revenue_slider[1], employee_slider[0], employee_slider[1], label, value))
    filtering_expressions = filter.split(' && ')

    if df.empty:
        dff = pd.DataFrame({'c.crmid': ['NULL'], 'c.label': ['Không có'], 'a.industry': ['NULL'], 'ad.ship_city': ['NULL'], 'SL_contact': [
                           'NULL'], 'SL_potential': ['NULL'], 'SL_salesorder': ['NULL'], 'revenue': ['NULL'], 'employee': ['NULL'], 'c.createdtime': ['NULL'], 'c.modifiedtime': ['NULL']})
    else:
        dff = df

    for filter_part in filtering_expressions:
        col_name, operator, filter_value = split_filter_part(filter_part)

        if operator in ('eq', 'ne', 'lt', 'le', 'gt', 'ge'):
            dff = dff.loc[getattr(dff[col_name], operator)(filter_value)]
        elif operator == 'contains':
            dff = dff.loc[dff[col_name].str.contains(filter_value)]
        elif operator == 'datestartswith':
            dff = dff.loc[dff[col_name].str.startswith(filter_value)]
    if len(sort_by):
        dff = dff.sort_values(
            [col['column_id'] for col in sort_by],
            ascending=[
                col['direction'] == 'asc'
                for col in sort_by
            ],
            inplace=False
        )

    revenue_output = html.Div(
        f'Doanh thu: {revenue_slider[0]:0,.0f} đến {revenue_slider[1]:0,.0f}')
    employee_output = html.Div(
        f'Số lượng nhân viên: từ {employee_slider[0]:0,.0f} đến {employee_slider[1]:0,.0f}')

    return dff.iloc[page_current * page_size:(page_current + 1)*page_size].to_dict('records'), revenue_output, employee_output


@app_Accounts.callback(
    Output('download_detail_account_detail', 'href'),
    [Input('download_detail_account_detail', 'n_clicks'),
     Input('ddl_timetype', 'value'),
     Input('date-picker-range', 'start_date'),
     Input('date-picker-range', 'end_date'),
     Input('ddl_leadsource', 'value'),
     Input('ddl_industry', 'value'),
     Input('ddl_account', 'value'),
     Input('ddl_user_assign', 'value'),
     # Input('ddl_user_marketing', 'value'),
     # Input('ddl_user_service', 'value'),
     Input('ddl_dept', 'value'),
     Input('grh_bar_status', 'selectedData'),
     Input('grh_parento_industry', 'clickData'),
     Input('grh_bar_user_assign', 'selectedData'),
     Input('grh_bar_user_marketing', 'selectedData'),
     Input('grh_bar_user_service', 'selectedData'),
     Input('grh_map_city', 'clickData'),
     Input('user_detail', 'active_cell'),
     Input('account_detail', 'active_cell'),
     Input('city', 'active_cell'),
     Input('revenue_slider', 'value'),
     Input('employee_slider', 'value'),
     Input('account_detail', 'page_current'),
     Input('account_detail', 'page_size'),
     Input('account_detail', 'sort_by'),
     Input('account_detail', 'filter_query'),
     ],
    [State('user_detail', 'data'),
     State('account_detail', 'data'),
     State('city', 'data')]
)
def UPDATE_DOWNLOAD(click, ddl_timetype, start_date, end_date, ddl_leadsource, ddl_industry, ddl_account, ddl_user_assign, ddl_dept, status, industry, user_assign, user_marketing, user_service, map_city, ac_user_detail, ac_account_detail, ac_city, revenue_slider, employee_slider, page_current, page_size, sort_by, filter, data_user_detail, data_account_detail, data_city):
    ctx = dash.callback_context
    datatable = {'user_detail': data_user_detail,
                 'account_detail': data_account_detail,
                 'city': data_city,
                 }
    label, value = GParams_Accounts.Get_Value(ctx, datatable)
    if revenue_slider is None:
        revenue_slider = [0, 0]
    if employee_slider is None:
        employee_slider = [0, 0]

    df = DB_Accounts.GET_ACCOUNTS(('account_detail', ddl_timetype, start_date, end_date, ddl_leadsource, ddl_industry, ddl_account, ddl_user_assign,
                                   ddl_dept, revenue_slider[0], revenue_slider[1], employee_slider[0], employee_slider[1], label, value))
    df = df.drop(columns=['c.crmid'])

    filtering_expressions = filter.split(' && ')

    if df.empty:
        dff = pd.DataFrame({'c.label': ['Không có '], 'a.industry': ['NULL'], 'ad.ship_city': ['NULL'], 'SL_contact': ['NULL'], 'SL_potential': [
                           'NULL'], 'SL_salesorder': ['NULL'], 'revenue': ['NULL'], 'employee': ['NULL'], 'c.createdtime': ['NULL'], 'c.modifiedtime': ['NULL']})
    else:
        dff = df
        dff['c.label'] = dff['c.label'].apply(lambda x: x.split(']')[0][1:] if x.count(
            ']') == 1 else x.split(']')[0][1:]+']' + x.split(']')[1])

    for filter_part in filtering_expressions:
        col_name, operator, filter_value = split_filter_part(filter_part)

        if operator in ('eq', 'ne', 'lt', 'le', 'gt', 'ge'):
            dff = dff.loc[getattr(dff[col_name], operator)(filter_value)]
        elif operator == 'contains':
            dff = dff.loc[dff[col_name].str.contains(filter_value)]
        elif operator == 'datestartswith':
            dff = dff.loc[dff[col_name].str.startswith(filter_value)]
    if len(sort_by):
        dff = dff.sort_values(
            [col['column_id'] for col in sort_by],
            ascending=[
                col['direction'] == 'asc'
                for col in sort_by
            ],
            inplace=False
        )

    csv_string = dff.to_csv(index=False, encoding='utf-8', header=['Tên khách hàng', 'Lĩnh vực', 'Tỉnh thành',
                            'Số lượng liên hệ', 'Số lượng cơ hội', 'Số lượng đơn hàng', 'Doanh thu', 'Số lượng nhân viên', 'Ngày tạo', 'Ngày sửa'])
    csv_string = "data:text/csv;charset=utf-8,%EF%BB%BF" + \
        urllib.parse.quote(csv_string)
    return csv_string
