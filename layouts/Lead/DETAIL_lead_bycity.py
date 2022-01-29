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
                html.B(html.Div("SỐ TIỀM NĂNG THEO THÀNH PHỐ", style={
                    'width': '100%', 'background': '#60B664', 'color': 'white', 'text-align': 'center'})),
                html.A(
                    children=[
                        html.I(
                            className="fas fa-file-download")
                    ],
                    id='download_task_bycity',
                    download='LEAD_THEO_CITY.csv',
                    target="_blank",
                    href='',
                    className='btn btn-primary',
                    style={'position': 'absolute', 'top': '0', 'right': '0', 'paddingTop': '0', 'background': '#60B664', 'border-color': '#60B664',
                           'paddingBottom': '0', 'height': '100%', 'display': 'inline-grid', 'alignItems': 'center'}
                )
            ], style={'height': '7%', 'width': '100%', 'background': '#60B664', 'textAlign': 'center', 'display': 'inline-grid', 'alignItems': 'center', 'position': 'relative'}),

            dash_table.DataTable(
                id='detail_lead_bycity',
                columns=[
                    {
                        'name': 'Thành phố',
                        'id': 'la.city'
                    },
                    {
                        'name': 'Số tiềm năng',
                        'id': 'num'
                    },
                    {
                        'name': 'Phần trăm',
                        'id': 'percentage'
                    }
                ],
                style_cell_conditional=[
                    {
                        'if': {'column_id': 'la.city'},
                        'width': '40%',
                        'textAlign': 'left',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'num'},
                        'width': '30%',
                        'type': 'numeric',
                        'padding-left': '15px'
                    },
                    {
                        'if': {'column_id': 'percentage'},
                        'width': '30%',
                        'type': 'numeric',
                        'padding-left': '15px'
                    },
                ],
                css=[
                    {
                        'selector': '.dash-fixed-content',
                        'rule': 'width: 100%;'

                    }
                ],
                fixed_rows={'headers': True},
                style_header=css.style_header,
                style_cell=css.style_cell,
                page_action='none',
                filter_action='native',
                style_table={
                    'height': '100%', 'width': '100%'},
                sort_action="native",
            )
        ], className="au-card", style={'height': '100%'})
    ], className="col-sm-12 col-md-12 col-lg-4 mb-3", style={'height': '64vh'})
    return layout


@app_Lead.callback(
    Output("detail_lead_bycity", "data"),

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

    # col, val filter
    Input('num_lead_byindustry', 'clickData'),
    Input('num_lead_byuser', 'selectedData'),

    # data of dataTable

)
def UPDATE_detail_lead_bycity(date_type, start_date, end_date, company, dept, source, status, assign, city, ac_industry, ac_user):
    ctx = dash.callback_context
    datatable = {}
    label, value = GParams_Lead.Get_Value(ctx, datatable)
    df = DB_Lead.Get_Lead(('num_lead_bycity', date_type, start_date, end_date, None, None, None,
                          None, assign, status, source, company, dept, city, label, value, None, None, None, None))
    df['percentage'] = round((df['num'] / df['num'].sum()) * 100, 2)
    return df.to_dict(orient='records')


@app_Lead.callback(
    Output('download_task_bycity', 'href'),
    [Input('download_task_bycity', 'n_clicks'),
     Input('detail_lead_bycity', 'data')]
)
def UPDATE_DOWNLOAD(click, data):
    # df.percentage = round((df['num'] / df['num'].sum()) * 100,2)
    df = pd.DataFrame.from_dict(data)
    if df.empty:
        csv_string = df.to_csv(index=False, encoding='utf-8', header=[])
    else:
        csv_string = df.to_csv(index=False, encoding='utf-8',
                               header=['Thành phố', 'Số tiềm năng', 'Phần trăm'])
    csv_string = "data:text/csv;charset=utf-8,%EF%BB%BF" + \
        urllib.parse.quote(csv_string)
    return csv_string
