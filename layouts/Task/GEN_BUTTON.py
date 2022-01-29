import dash_html_components as html
# Tạo 1 template giao diện cho Button
def create_button(title, id, backgound_color,title_color):
    return html.Div([
        html.Button(title, id=id, n_clicks=0, style={
                    'width': '100%', 'color': f'{title_color}', 'font-family': 'nunito'})
    ], className='col-4', style={'text-align': 'center','margin-right':'10px',
                                            'width': '100%', 'height': '110%', 'backgroundColor': f'{backgound_color}'})
    
