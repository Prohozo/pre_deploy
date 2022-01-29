from dash import html


def create_card(title, id, color, icon, className='col-sm-12 col-md-2 col-lg-2 mb-3'):
    return html.Div([
        html.Div([
                    html.Div([
                        html.Div([f'{title}'], style={
                                 'color': '#fff', 'margin-bottom': '10px'}, className='title_below'),
                        html.Div([
                            html.Div(className='col-6 value', id=id, style={
                                     'color': '#fff', 'font-size': '30px', 'font-weight': '800'}),
                            html.Div(className='col-6 value', id=id+'_diff', style={
                                     'color': '#fff', 'font-size': '30px', 'font-weight': '300'})
                        ], className='row'),
                    ], className='col-8 content-ov mt-3'),
                    html.Div([
                        html.Img(src=f'/static/system_dashboard/images/{icon}')
                    ], className='col-4 icon-ov mt-3'),
                    ], className='row au-card', style={'width': '100%', 'height': '100%', 'background': f'{color}'})
    ], className=className)
