import dash_html_components as html

def create_button(title, id, backgound_color,title_color):
    return html.Div([
        html.Button(title, id=id, n_clicks=0, style={'width': '100%', 'color':f'{title_color}'})
    ], className='col-4 ov au-card', style={'text-align': 'center','margin-right':'10px',
                                            'width': '100%', 'height': '100%', 'backgroundColor': f'{backgound_color}'})