# FILE CHÍNH, tổng hợp các file layout của từng biểu đồ
from dash import dcc
from dash import html
from app import app_Lead
from index_string import index_str
from layouts.Lead import DDL_Lead, DDL_date_range, OV_total_lead, OV_total_industry, OV_total_city, NUM_lead_bysource, NUM_lead_bystatus, NUM_lead_bytime, NUM_lead_byindustry, NUM_lead_byuser, DETAIL_lead_bycity, DETAIL_lead_detail, DETAIL_comment_detail, DETAIL_all, MAP_lead_bycity
app_Lead.index_string = index_str


def render_layout():
    layout = html.Div([
        html.Div([
            html.Div([

                # DateRange Filter, Overview
                html.Div([
                    html.Div([
                        html.Div([
                            dcc.Dropdown(
                                id='date_type',
                                options=[{'value': 'Ngày tạo', 'label': 'Ngày tạo'},
                                         {'value': 'Ngày chỉnh sửa',
                                          'label': 'Ngày chỉnh sửa'}
                                         ],
                                value='Ngày tạo',
                                style={'height': '45px'}
                            )
                        ], style={'margin-bottom': '22px'}),
                        html.Div('Ngày bắt đầu', style={
                                 'margin-bottom': '30px', 'font-size': '15px', 'color': 'black', 'font-weight': 'bold'}),
                        html.Div('Ngày kết thúc', style={
                                 'font-size': '15px', 'color': 'black', 'font-weight': 'bold'}),
                    ], className='col-sm-3 col-md-3 col-lg-1 mb-3'),

                    # DateRange Filter
                    DDL_date_range.gen_layout(),

                    # Overview
                    OV_total_lead.gen_layout(),
                    OV_total_industry.gen_layout(),
                    OV_total_city.gen_layout()
                ], className='row'),

                # Row 1: Filter

                # (Company, Source, Status)
                html.Div([
                    DDL_Lead.gen_layout_row_1()
                ], className='row'),

                # (Dept, User_assign, City)
                html.Div([
                    DDL_Lead.gen_layout_row_2()
                ], className='row'),

                # Row 2: Lead_byuser, Lead_bytime
                html.Div([
                    NUM_lead_byuser.gen_layout(),
                    NUM_lead_bytime.gen_layout()
                ], className='row'),

                # Row 3: Lead_bysource, lead_bystatus
                html.Div([
                    NUM_lead_bysource.gen_layout(),
                    NUM_lead_bystatus.gen_layout()
                ], className='row'),

                # Row 4: Lead_by_industry, Lead_bycity
                html.Div([
                    MAP_lead_bycity.gen_layout(),
                    DETAIL_lead_bycity.gen_layout()
                ], className='row'),

                # Row 4: Lead_by_industry, Lead_bycity
                html.Div([
                    NUM_lead_byindustry.gen_layout()
                ], className='row'),

                # Row 5: Lead_detail, comment_detail
                html.Div([
                    DETAIL_all.gen_layout()
                ], className='row'),

            ], className="container-fluid")
        ], className="section__content--p30", style={'backgroundColor': '#E5E5E5'})
    ])
    return layout


app_Lead.layout = render_layout()

# Thiết lập host, port cho dashboard
if __name__ == '__main__':
    app_Lead.run_server(debug=True)
    # host = '192.168.1.239', port = ''
