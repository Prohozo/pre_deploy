import dash_html_components as html
from dash_html_components.Div import Div

def create_card(title, id_ov, color, className, icon = 'consume_inland.svg'):
    return  html.Div([
                html.Div([
                    html.Img(src=f'../static/system_dashboard/images/{icon}', className='col-5' ,style={'height': '100%', 'padding':'5px'}),
                    html.Div([
                        html.Div([
                            html.Div([
                                html.Div([f'{title}'],className='title_below_kt text-center', style={'fontSize':'1.6vw'}),
                                html.Div(id=id_ov, className='value', style={'fontSize':'1.6vw'})
                            ], className='content-ov-kt' ,style={'height': '100%'})
                        ], className='ele_row')
                    ],className='text-center col-7', style={'height':'100%'}),
                ],className='ele_row au-card',style={'width':'100%','height': '100%', 'backgroundColor': f'{color}', 'borderRadius': '5px'})
            ],className= className, style={'width':'100%', 'height':'13vh'})
