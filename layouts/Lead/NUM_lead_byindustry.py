import dash
from dash import dcc
import pandas as pd
from dash import html
from dash.dependencies import Input, Output, State
from app import app_Lead
from utils import Graph_Lead, GParams_Lead
from DB import DB_Lead


def gen_layout():
    layout = html.Div([
        html.Div([
            html.Div([

                html.B(html.Div("SỐ KHÁCH HÀNG TIỀM NĂNG THEO LĨNH VỰC", style={
                       'width': '100%', 'background': '#60B664', 'color': 'white', 'text-align': 'center'})),

                # Nút refresh
                html.Button(
                    html.I(className='fas fa-sync-alt'),
                    id='btn_R',
                    style={'position': 'absolute', 'top': '0', 'right': '0', 'paddingTop': '0', 'background': '#60B664', 'border-color': '#60B664', 'paddingBottom': '0', 'height': '100%', 'display': 'inline-grid', 'alignItems': 'center'}, className='btn_in_title btn btn-primary col-1'
                )

            ], style={'height': '7%', 'width': '100%', 'background': '#60B664', 'textAlign': 'center', 'display': 'inline-grid', 'alignItems': 'center', 'position': 'relative'}),

            dcc.Graph(id="num_lead_byindustry", style={
                      'width': '100%', 'height': '92%'}),

        ], className='au-card', style={'width': '100%', 'height': '100%'}),

    ], className="col-sm-12 col-md-12ư col-lg-12 mb-3", style={'height': '100%'})

    return layout


@app_Lead.callback(
    Output("num_lead_byindustry", "figure"),

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
def update_num_lead_byindustry(date_type, start_date, end_date, company, dept, source, status, assign, city, ac_industrty, ac_user):
    ctx = dash.callback_context
    datatable = {}
    label, value = GParams_Lead.Get_Value(ctx, datatable)

    df = DB_Lead.Get_Lead(('num_lead_byindustry', date_type, start_date, end_date, None, None, None,
                          None, assign, status, source, company, dept, city, label, value, None, None, None, None))

    # Tính đường phần trăm gộp cho biểu đồ Pareto
    df['cumulative_sum'] = df.num.cumsum()
    df['cumulative_perc'] = round(df['cumulative_sum']/df['num'].sum()*100, 2)

    if df.empty:
        df = pd.DataFrame({'ld.industry': ['Không có giá trị'], 'num': [
                          0], 'cumulative_sum': [0], 'cumulative_perc': [0]})

    return Graph_Lead.grh_ParetoChart(x1=df['ld.industry'], y1=df['num'], x2=df['ld.industry'], y2=df['cumulative_perc'], label_x='<b>Lĩnh vực<b>', label_y='<b>Số lượng KH tiềm năng<b>', marker_color=['#60B664', '#60B664'], color_line='#FD413C', mode='lines+markers', margin=[35, 150, 80, 35], customdata=[i+1 for i in df.index.values])


@app_Lead.callback(
    Output('num_lead_byindustry', 'clickData'),
    Input('btn_R', 'n_clicks')
)
def refresh(click):
    return None
