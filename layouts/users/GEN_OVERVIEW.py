import dash_html_components as html
from dash_html_components.Div import Div

def create_card(title,id,color,icon):
    return  html.Div([
                html.Div([
                    html.Div([
                        html.Div([f'{title}'],style={'color':'#000000','font-size': '2vh','font-weight':'700'},className='title_below'),
                        html.Div([
                            html.Div(className='col-6 value', id=id,style={'color':'#000000','font-size': '2.5vh','font-weight':'700'}),
                            html.Div(className='col-6 value', id=id+'_diff',style={'color':'#000000','font-size': '2.5vh','font-weight':'700'})
                        ],className = 'row')
                    ],className='col-8 content-ov mt-3 mb-2'),
                    html.Div([
                        html.Img(src=f'/static/system_dashboard/images/{icon}')
                    ],className='col-3 icon-ov mt-3 mb-1'),
                ],className='row au-card',style={'width':'100%','height': '100%', 'backgroundColor': f'{color}'})
            ],style={'height': '13vh'},className='col-sm-12 col-md-12 col-lg-4 mb-3')
