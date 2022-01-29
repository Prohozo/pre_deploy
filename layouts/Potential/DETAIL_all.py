from dash import dcc
from dash import html
# from layouts.Potential.DETAIL_comment import gen_layout as comment
from layouts.Potential.DETAIL_POTENTIAL import gen_layout as potential
from layouts.Potential.DETAIL_activity import gen_layout as activity

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
                    label='CHI TIẾT CƠ HỘI',
                    children=[potential()],
                    style=tab_style, selected_style=tab_selected_style, className='col-6'
                ),
                dcc.Tab(
                    label='CHI TIẾT HOẠT ĐỘNG',
                    children=[activity()],
                    style=tab_style, selected_style=tab_selected_style, className='col-6'
                ),
                # dcc.Tab(
                #     label='CHI TIẾT BÌNH LUẬN',
                #     children=[comment()],
                #     style=tab_style, selected_style=tab_selected_style, className='col-4'
                # ),
            ], style={'height': '4vh', 'align-items': 'top'}, className='row')
        ], className='au-card', style={'width': '100%', 'height': '100%'})
    ], className="col-sm-12 col-md-12 col-lg-12 mb-3", style={'height': '100%'})

    return layout
