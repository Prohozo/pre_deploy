from dash import dcc
from dash import html
from layouts.Potential.DETAIL_potential_delay import gen_layout as delay1
from layouts.Potential.DETAIL_potential_delay_2 import gen_layout as delay2


# Tab tổng hợp các bảng chi tiết
def gen_layout():
    tab_style = {
        'borderBottom': '1px solid #d6d6d6',
        'color': 'black',
        'background-color': 'white',
        'border-left': '1px solid #E5E5E5',
        'text-align': 'center',
        'padding': '9px 25px'
    }

    tab_selected_style = {
        'borderTop': '1px solid #60B664',
        'borderBottom': '1px solid #60B664',
        'backgroundColor': '#60B664',
        'color': 'white',
        'fontWeight': 'bold',
        'text-align': 'center',
        'padding': '9px 25px'
    }
    layout = html.Div([
        html.Div([
            dcc.Tabs([
                dcc.Tab(
                    label='CƠ HỘI KHÔNG TƯƠNG TÁC',
                    children=[delay1()],
                    style=tab_style, selected_style=tab_selected_style, className='col-6'
                ),
                dcc.Tab(
                    label='CƠ HỘI KÉO DÀI',
                    children=[delay2()],
                    style=tab_style, selected_style=tab_selected_style, className='col-6'
                )
            ], style={'height': '5vh', 'align-items': 'top'}, className='row')
        ], className='au-card', style={'width': '100%', 'height': '100%'})
    ], className="col-sm-12 col-md-6 col-lg-6 mb-3", style={'height': '65vh'})

    return layout
