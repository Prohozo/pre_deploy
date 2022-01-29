from dash import html


def create_card(title, id, color, icon):
    return html.Div([
        html.Div([
                    html.Div([
                        html.Div([f'{title}'], style={
                                 'color': '#fff', 'margin-bottom': '10px'}, className='title_below'),
                        html.Div(className='value', id=id, style={
                                 'color': '#fff', 'font-size': '30px'}),
                    ], className='col-7 content-ov mt-3 ml-1'),
                    html.Div([
                        html.Img(src=f'/static/system_dashboard/images/{icon}')
                    ], className='col-4 icon-ov mt-3'),
                    ], className='row au-card', style={'width': '100%', 'height': '80%', 'background': f'{color}'})
    ], style={'height': '19.5vh'}, className='col-sm-12 col-md-6 col-lg-3 mb-3')
