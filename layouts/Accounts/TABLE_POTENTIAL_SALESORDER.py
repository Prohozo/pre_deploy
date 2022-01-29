# import dash
# import dash_core_components as dcc
# import dash_html_components as html
# import dash_table
# import urllib.parse
# import pandas as pd
# from static.system_dashboard.css import css_define as css
# from dash_table.Format import Format, Scheme
# from DB import DB_Accounts
# from dash.dependencies import Input, Output, State
# from utils import  GParams
# from utils import  Graph
# from app import app_Accounts


# def gen_layout():

#     layout =html.Div([
#                         html.Div([
#                             html.Div([
#                                 html.Div("BẢNG CHI TIẾT KHÁCH HÀNG THEO SỐ LƯỢNG CƠ HỘI VÀ ĐƠN HÀNG", style={'width':'100%','fontWeight': 'bold','background': '#FF938B'}),
#                                 html.A(
#                                     children=[
#                                         html.I(className="fas fa-file-download")
#                                     ],
#                                     id='download_detail_potential_salesorder',
#                                     download="DETAIL_POTENTIAL_SALESORDER.csv",
#                                     target="_blank",
#                                     href = '',
#                                     className='btn btn-primary',
#                                     style={'position':'absolute','top':'0','right':'0','paddingTop':'0','paddingBottom':'0','marginTop': '2%','marginRight':'3%','height': '50%','display': 'inline-grid','alignItems': 'center','backgroundColor':'#FF938B','borderColor':'#FF938B'}),
#                             ], style={'height': '10%','width':'100%','background': '#FF938B','textAlign':'center','display':'inline-grid','alignItems':'center','position':'relative'}),
#                             dash_table.DataTable(
#                                 id='potential_salesorder',
#                                 columns=[
#                                     {
#                                         'name': 'Tên khách hàng', 
#                                         'id': 'c.label',
#                                     },
#                                     {
#                                         'name': 'Số lượng cơ hội', 
#                                         'id': 'potential',
#                                     },
#                                     {
#                                         'name': 'Số lượng đơn hàng', 
#                                         'id': 'salesorder',
#                                     },
#                                 ],
#                                 style_cell_conditional=[
#                                     {
#                                         'if': {'column_id': 'c.label'},
#                                         'width': '65%',
#                                         'vertical-align': 'text-top',

#                                     },
#                                     {
#                                         'if': {'column_id': 'potential'},
#                                         'width': '17%',
#                                         'textAlign': 'center',
                                        
#                                     },
#                                     {
#                                         'if': {'column_id': 'salesorder'},
#                                         'width': '17%',
#                                         'textAlign': 'center',
                                        
#                                     },

#                                 ],
                                
#                                 css=[
#                                         {
#                                             'selector': '.dash-fixed-content',
#                                             'rule': 'width: 100%;'
#                                         }
#                                     ],
#                                 fixed_rows={'headers': True},
#                                 style_header=css.style_header,
#                                 style_cell=css.style_cell,
#                                 page_current=0,
#                                 page_size=50,
#                                 style_table={'height': '100%','width':'100%'},
#                                 page_action='custom',
                                
#                                 sort_mode='multi',
#                                 sort_action="custom",
#                                 sort_by=[],
                                
#                                 filter_action='custom',
#                                 filter_query='',
                                
#                             )
#                         ], className="au-card",style={'height':'100%'})
#                     ], className="col-6",style={'height':'100%'})

#     return layout

# operators = [['ge ', '>='],
#              ['le ', '<='],
#              ['lt ', '<'],
#              ['gt ', '>'],
#              ['ne ', '!='],
#              ['eq ', '='],
#              ['contains '],
#              ['datestartswith ']]

# def split_filter_part(filter_part):
#     for operator_type in operators:
#         for operator in operator_type:
#             if operator in filter_part:
#                 name_part, value_part = filter_part.split(operator, 1)
#                 name = name_part[name_part.find('{') + 1: name_part.rfind('}')]

#                 value_part = value_part.strip()
#                 v0 = value_part[0]
#                 if (v0 == value_part[-1] and v0 in ("'", '"', '`')):
#                     value = value_part[1: -1].replace('\\' + v0, v0)
#                 else:
#                     try:
#                         value = float(value_part)
#                     except ValueError:
#                         value = value_part
#                 return name, operator_type[0].strip(), value
#     return [None] * 3

# @app_Accounts.callback(
#     Output("potential_salesorder","data"),
#     [Input('date-picker-range','start_date'),
#     Input('date-picker-range','end_date'),
#     Input('ddl_leadsource','value'),
#     Input('ddl_industry','value'),
#     Input('ddl_account','value'),
#     Input('ddl_user_assign','value'),
#     Input('ddl_user_marketing','value'),
#     Input('ddl_user_service','value'),
#     Input('ddl_dept','value'),
#     Input('potential_salesorder', 'page_current'),
#     Input('potential_salesorder', 'page_size'),
#     Input('potential_salesorder', 'sort_by'),
#     Input('potential_salesorder', 'filter_query'),
#     ],

# )

# def UPDATE_POTENTIAL_SALESORDER(start_date,end_date,ddl_leadsource,ddl_industry,ddl_account,ddl_user_assign,ddl_user_marketing,ddl_user_service,ddl_dept,page_current,page_size,sort_by, filter):
#     # ctx = dash.callback_context

#     # label, value = GParams.Get_Value(ctx)
#     df = DB_Accounts.GET_ACCOUNTS(('potential_salesorder',start_date,end_date,ddl_leadsource,ddl_industry,ddl_account,ddl_user_assign,ddl_user_marketing,ddl_user_service,ddl_dept,None,None,None,None,None,None))
#     filtering_expressions = filter.split(' && ')
#     dff = df
#     for filter_part in filtering_expressions:
#         col_name, operator, filter_value = split_filter_part(filter_part)

#         if operator in ('eq', 'ne', 'lt', 'le', 'gt', 'ge'):
#             dff = dff.loc[getattr(dff[col_name], operator)(filter_value)]
#         elif operator == 'contains':
#             dff = dff.loc[dff[col_name].str.contains(filter_value)]
#         elif operator == 'datestartswith':
#             dff = dff.loc[dff[col_name].str.startswith(filter_value)]
#     if len(sort_by):
#         dff = dff.sort_values(
#             [col['column_id'] for col in sort_by],
#             ascending=[
#                 col['direction'] == 'asc'
#                 for col in sort_by
#             ],
#             inplace=False
#         )

   
#     return dff.iloc[page_current * page_size:(page_current + 1)*page_size].to_dict('records')
        

# @app_Accounts.callback(
#     Output('download_detail_potential_salesorder', 'href'),
#     [Input('download_detail_potential_salesorder', 'n_clicks'),
#      Input('potential_salesorder', 'data')]
# )
# def UPDATE_DOWNLOAD(click, data):
#     df = pd.DataFrame.from_dict(data)

#     csv_string = df.to_csv(index=False, encoding='utf-8', header=['Tên khách hàng','Số lượng cơ hội','Số lượng đơn hàng'])
#     csv_string = "data:text/csv;charset=utf-8,%EF%BB%BF" + urllib.parse.quote(csv_string)
#     return csv_string