# FILE CHÍNH, tổng hợp các file layout của từng biểu đồ
from dash import dcc
from dash import html
from app import app_Potential
from index_string import index_str
from layouts.Potential import DDL_potential, DDL_date_range, OV_total_potential, OV_total_potential_won, OV_total_potential_sale, OV_total_potential_lost, NUM_potential_bytime, NUM_potential_bysalestage, NUM_potential_byproduct, DETAIL_delay_all, DETAIL_POTENTIAL, DETAIL_comment, DETAIL_all
app_Potential.index_string = index_str


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
                                          'label': 'Ngày chỉnh sửa'},
                                         {'value': 'Ngày đóng',
                                          'label': 'Ngày đóng'},
                                         ],
                                value='Ngày tạo',
                                style={'height': '45px'}
                            )
                        ], style={'margin-bottom': '22px'}),
                        html.Div('Ngày bắt đầu', style={
                                 'margin-bottom': '30px', 'font-size': '15px', 'color': 'black', 'font-weight': 'bold'}),
                        html.Div('Ngày kết thúc', style={
                                 'font-size': '15px', 'color': 'black', 'font-weight': 'bold'}),
                    ], className='col-sm-1 col-md-1 col-lg-1 mb-3'),

                    # DateRange Filter
                    DDL_date_range.gen_layout(),

                    # Overview

                    OV_total_potential.gen_layout(),
                    OV_total_potential_sale.gen_layout(),
                    OV_total_potential_won.gen_layout(),
                    OV_total_potential_lost.gen_layout()


                ], className='row'),

                # Row 1: Filter

                # (Company, Source, Status)

                DDL_potential.gen_layout_row_1(),


                # (Dept, User_assign, City)

                DDL_potential.gen_layout_row_2(),


                # Row 2: potential_byuser, potential_bytime
                html.Div([
                    NUM_potential_bytime.gen_layout(),
                    DETAIL_delay_all.gen_layout()
                ], className='row'),

                # Row 3: potential_bysource, potential_bystatus
                html.Div([
                    NUM_potential_bysalestage.gen_layout(),
                    NUM_potential_byproduct.gen_layout()
                ], className='row'),

                # Row 4: potential_by_industry, potential_bycity
                # html.Div([
                #     NUM_potential_byuser.gen_layout(),
                #     NUM_potential_byuser_status.gen_layout()
                # ], className='row'),

                # Row 5: potential_detail, comment_detail
                html.Div([
                    DETAIL_all.gen_layout()
                ], className='row'),

            ], className="container-fluid")
        ], className="section__content--p30", style={'backgroundColor': '#E5E5E5'})
    ])
    return layout


app_Potential.layout = render_layout()

# Thiết lập host, port cho dashboard
if __name__ == '__main__':
    app_Potential.run_server(debug=True)
    # host = '192.168.1.239', port = ''
