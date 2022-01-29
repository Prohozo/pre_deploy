import dash
from dash import dcc
from dash import html
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

    layout = html.Div([
        html.Div([
            html.Div([
                html.Div("BẢNG CHI TIẾT KHÁCH HÀNG THEO NHÂN VIÊN", style={
                         'width': '100%', 'fontWeight': 'bold', 'background': '#7DC383'}),
                html.A(
                    children=[
                        html.I(
                            className="fas fa-file-download")
                    ],
                    id='download_detail_user',
                    download="DETAIL_ACCOUNTS_USERS.csv",
                    target="_blank",
                    href='',
                    className='btn btn-primary',
                    style={'position': 'absolute', 'top': '0', 'right': '0', 'paddingTop': '0', 'paddingBottom': '0', 'marginTop': '2%', 'marginRight': '3%', 'height': '50%', 'display': 'inline-grid', 'alignItems': 'center', 'backgroundColor': '#7DC383', 'borderColor': '#7DC383'}),
            ], style={'height': '10%', 'width': '100%', 'background': '#7DC383', 'textAlign': 'center', 'display': 'inline-grid', 'alignItems': 'center', 'position': 'relative'}),
            dash_table.DataTable(
                id='user_detail',
                columns=[
                    {
                        'name': 'Tên khách hàng',
                        'id': 'c.label',
                        'presentation': 'markdown'
                    },
                    {
                        'name': 'NV được phân công',
                        'id': 'NV_assign',
                    },
                    # {
                    #     'name': 'NV marketing',
                    #     'id': 'acf.user_marketing',
                    # },
                    # {
                    #     'name': 'NV giới thiệu',
                    #     'id': 'acf.user_service',
                    # },
                ],
                style_cell_conditional=[
                    {
                        'if': {'column_id': 'c.label'},
                        'width': '60%',
                        'vertical-align': 'text-top',
                        'padding-left': '15px',

                    },
                    {
                        'if': {'column_id': 'NV_assign'},
                        'width': '10%',
                        'textAlign': 'center',

                    },
                    # {
                    #     'if': {'column_id': 'acf.user_marketing'},
                    #     'width': '10%',
                    #     'textAlign': 'center',

                    # },
                    # {
                    #     'if': {'column_id': 'acf.user_service'},
                    #     'width': '10%',
                    #     'textAlign': 'center',

                    # },
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

            )
        ], className="au-card", style={'height': '100%'})
    ], className="col-sm-12 col-md-6 col-lg-6 mb-3", style={'height': '63vh'})

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
    Output("user_detail", "data"),
    [Input('ddl_timetype', 'value'),
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
     Input('user_detail', 'page_current'),
     Input('user_detail', 'page_size'),
     Input('user_detail', 'sort_by'),
     Input('user_detail', 'filter_query'),
     ],
    [State('user_detail', 'data'),
     State('account_detail', 'data'),
     State('city', 'data')]

)
def UPDATE_USER_DETAIL(ddl_timetype, start_date, end_date, ddl_leadsource, ddl_industry, ddl_account, ddl_user_assign, ddl_dept, status, industry, user_assign, user_marketing, user_service, map_city, ac_user_detail, ac_account_detail, ac_city, page_current, page_size, sort_by, filter, data_user_detail, data_account_detail, data_city):
    ctx = dash.callback_context

    datatable = {'user_detail': data_user_detail,
                 'account_detail': data_account_detail,
                 'city': data_city,
                 }
    label, value = GParams_Accounts.Get_Value(ctx, datatable)
    df = DB_Accounts.GET_ACCOUNTS(('user_detail', ddl_timetype, start_date, end_date, ddl_leadsource, ddl_industry,
                                  ddl_account, ddl_user_assign,  None, None,  ddl_dept, None, None, None, None, label, value))
    print(df)
    filtering_expressions = filter.split(' && ')
    if df.empty:
        dff = pd.DataFrame({'c.crmid': ['NULL'], 'c.label': [
                           'Không có'], 'c.smownerid': ['NULL'], 'NV_assign': ['NULL']})
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
    return dff.iloc[page_current * page_size:(page_current + 1)*page_size].to_dict('records')


@app_Accounts.callback(
    Output('download_detail_user', 'href'),
    [Input('download_detail_user', 'n_clicks'),
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
     Input('user_detail', 'page_current'),
     Input('user_detail', 'page_size'),
     Input('user_detail', 'sort_by'),
     Input('user_detail', 'filter_query'),
     ],
    [State('user_detail', 'data'),
     State('account_detail', 'data'),
     State('city', 'data')]
)
def UPDATE_DOWNLOAD(click, ddl_timetype, start_date, end_date, ddl_leadsource, ddl_industry, ddl_account, ddl_user_assign, ddl_dept, status, industry, user_assign, user_marketing, user_service, map_city, ac_user_detail, ac_account_detail, ac_city, page_current, page_size, sort_by, filter, data_user_detail, data_account_detail, data_city):
    ctx = dash.callback_context
    datatable = {'user_detail': data_user_detail,
                 'account_detail': data_account_detail,
                 'city': data_city,
                 }
    label, value = GParams_Accounts.Get_Value(ctx, datatable)
    df = DB_Accounts.GET_ACCOUNTS(('user_detail', ddl_timetype, start_date, end_date, ddl_leadsource, ddl_industry,
                                  ddl_account, ddl_user_assign,  None, None,  ddl_dept, None, None, None, None, label, value))

    df = df.drop(columns=['c.crmid', 'c.smownerid'])

    filtering_expressions = filter.split(' && ')

    if df.empty:
        dff = pd.DataFrame({'c.label': ['Không có'], 'NV_assign': ['NULL']})
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

    #
    csv_string = dff.to_csv(index=False, encoding='utf-8',
                            header=['Tên khách hàng', 'NV được phân công'])
    csv_string = "data:text/csv;charset=utf-8,%EF%BB%BF" + \
        urllib.parse.quote(csv_string)
    return csv_string
