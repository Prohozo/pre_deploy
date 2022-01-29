# FILE CHÍNH, tổng hợp các file layout của từng biểu đồ
from dash import dcc
from dash import html
from app import app_Support
from index_string import index_str
from layouts.Support import DDL_Support, DDL_date_range, OV_total_Support, NUM_Support_byuser, NUM_Support_bystatus, NUM_Support_bypri, NUM_Support_bylocation, NUM_Support_bytime, DETAIL_Support_delay, DETAIL_Support, OV_total_closed_Support, OV_total_opened_Support
app_Support.index_string = index_str


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
                                options=[{'value': '0', 'label': 'Ngày tạo'},
                                         {'value': '1', 'label': 'Ngày chỉnh sửa'},
                                         ],
                                value='0',
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
                    OV_total_Support.gen_layout(),
                    OV_total_opened_Support.gen_layout(),
                    OV_total_closed_Support.gen_layout()
                    # OV_total_potential_sale.gen_layout(),
                    # OV_total_potential_won.gen_layout(),
                    # OV_total_potential_lost.gen_layout()
                ], className='row ml-1'),

                # Row 1: Filter

                # (Company, Source, Status)
                DDL_Support.gen_layout(),

                html.Br(),
                # Row 2: potential_byuser, potential_bytime
                html.Div([
                    NUM_Support_byuser.gen_layout(),
                    DETAIL_Support_delay.gen_layout()
                ], className='row'),

                # Row 3: potential_bysource, potential_bystatus
                html.Div([
                    NUM_Support_bystatus.gen_layout(),
                    NUM_Support_bypri.gen_layout(),
                    NUM_Support_bylocation.gen_layout()
                    # NUM_potential_byproduct.gen_layout()
                ], className='row'),


                # Row 4: potential_by_industry, potential_bycity
                html.Div([
                    NUM_Support_bytime.gen_layout()
                ], className='row'),

                # Row 5: potential_detail, comment_detail
                html.Div([
                    DETAIL_Support.gen_layout()
                ], style={'height': '100%'}, className='row'),

            ], className="container-fluid")
        ], className="section__content--p30", style={'backgroundColor': '#E5E5E5'})
    ])
    return layout


app_Support.layout = render_layout()

# Thiết lập host, port cho dashboard
if __name__ == '__main__':
    app_Support.run_server(debug=True)
    # host = '192.168.1.239', port = ''
