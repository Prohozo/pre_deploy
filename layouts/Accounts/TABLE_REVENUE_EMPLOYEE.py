# import dash
# import dash_core_components as dcc
# import dash_html_components as html
# from dash_html_components.Br import Br
# from dash_html_components.Div import Div
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
#     df = DB_Accounts.GET_ACCOUNTS(('revenue_employee',None,None,None,None,None,None,None,None,None,None,None,None,None,None,None))

#     # Tạo mark cho slider doanh thu và sl nhân viên
#     mark_emp = {i:{'label': f'{i:0,.0f}', 'style':{'color':'black'}} for i in range(0, int(df['employee'].max()+1),1000)}
#     mark_rev = {i*10000000000:{'label': str(i)+' Tỷ', 'style':{'color':'black'}} for i in range(0, int(df['revenue'].max()/10000000000+1),1)}

#     layout =html.Div([
#                         html.Div([
#                             html.Div([
#                                 html.Div("BẢNG CHI TIẾT KHÁCH HÀNG THEO DOANH THU VÀ SỐ LƯỢNG NHÂN VIÊN", style={'width':'100%','fontWeight': 'bold','background': '#FF938B'}),
#                                 html.A(
#                                     children=[
#                                         html.I(className="fas fa-file-download")
#                                     ],
#                                     id='download_detail_revenue_employee',
#                                     download="DETAIL_ACCOUNTS_REVENUE_EMPLOYEE.csv",
#                                     target="_blank",
#                                     href = '',
#                                     className='btn btn-primary',
#                                     style={'position':'absolute','top':'0','right':'0','paddingTop':'0','paddingBottom':'0','marginTop': '2%','marginRight':'3%','height': '50%','display': 'inline-grid','alignItems': 'center','backgroundColor':'#FF938B','borderColor':'#FF938B'}),
#                             ], style={'height': '10%','width':'100%','background': '#FF938B','textAlign':'center','display':'inline-grid','alignItems':'center','position':'relative'}),
#                             dash_table.DataTable(
#                                 id='revenue_employee',
#                                 columns=[
#                                     {
#                                         'name': 'Tên khách hàng', 
#                                         'id': 'c.label',
#                                     },
#                                     {
#                                         'name': 'Doanh thu', 
#                                         'id': 'revenue',
#                                     },
#                                     {
#                                         'name': 'Số lượng nhân viên', 
#                                         'id': 'employee',
#                                     },

#                                 ],
#                                 style_cell_conditional=[
#                                     {
#                                         'if': {'column_id': 'c.label'},
#                                         'width': '65%',
#                                         'vertical-align': 'text-top',

#                                     },
#                                     {
#                                         'if': {'column_id': 'revenue'},
#                                         'width': '17%',
#                                         'textAlign': 'center',
                                        
#                                     },
#                                     {
#                                         'if': {'column_id': 'employee'},
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
                                
#                             ),
#                             html.Br(),
#                             html.Div([
#                                 html.Div(id='output_revenue_slider', style={'width':'100%','fontWeight': 'bold'}),
#                                 dcc.RangeSlider(
#                                         id='revenue_slider',
#                                         min=min(df['revenue']), 
#                                         max=max(df['revenue']),                                     
#                                         marks=mark_rev,
#                                         step=1000000000,
#                                         value=[min(df['revenue']),max(df['revenue'])],                                         
#                                 )                            
#                             ],style={'marginLeft':'2%','width':'95%','height':'5%'}),
#                             html.Br(),
#                             html.Div([
#                                 html.Div(id='output_employee_slider', style={'width':'100%','fontWeight': 'bold'}),
#                                 dcc.RangeSlider(
#                                         id='employee_slider',
#                                         min=min(df['employee']), 
#                                         max=max(df['employee']),
#                                         marks=mark_emp,
#                                         step=10,
#                                         value=[min(df['employee']), max(df['employee'])],
#                                 ),                               
#                             ],style={'marginLeft':'2%','width':'95%','height':'5%'}),
#                         ], className="au-card",style={'height':'100%'})
#                     ], className="col-12",style={'height':'100%'})

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
#     Output("revenue_employee","data"),
#     Output("output_revenue_slider","children"),
#     Output("output_employee_slider","children"),
#     [Input('date-picker-range','start_date'),
#     Input('date-picker-range','end_date'),
#     Input('ddl_leadsource','value'),
#     Input('ddl_industry','value'),
#     Input('ddl_account','value'),
#     Input('ddl_user_assign','value'),
#     Input('ddl_user_marketing','value'),
#     Input('ddl_user_service','value'),
#     Input('ddl_dept','value'),
#     Input('revenue_slider','value'),
#     Input('employee_slider','value'),
#     Input('revenue_employee', 'page_current'),
#     Input('revenue_employee', 'page_size'),
#     Input('revenue_employee', 'sort_by'),
#     Input('revenue_employee', 'filter_query'),
#     ],

# )

# def UPDATE_REVENUE_EMPLOYEE(start_date,end_date,ddl_leadsource,ddl_industry,ddl_account,ddl_user_assign,ddl_user_marketing,ddl_user_service,ddl_dept,revenue_slider,employee_slider,page_current,page_size,sort_by, filter):
#     # ctx = dash.callback_context
#     # label, value = GParams.Get_Value(ctx)
#     if revenue_slider is None:
#         revenue_slider = [0,0]
#     if employee_slider is None:
#         employee_slider = [0,0]

#     df = DB_Accounts.GET_ACCOUNTS(('revenue_employee',start_date,end_date,ddl_leadsource,ddl_industry,ddl_account,ddl_user_assign,ddl_user_marketing,ddl_user_service,ddl_dept,revenue_slider[0],revenue_slider[1],employee_slider[0],employee_slider[1],None,None))
#     filtering_expressions = filter.split(' && ')
    
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

#     revenue_output = html.Div('Doanh thu: từ {0} đến {1}'.format(*revenue_slider))
#     employee_output = html.Div('Số lượng nhân viên: từ {0} đến {1}'.format(*employee_slider))
#     if df.empty:
#         dff = pd.DataFrame({'c.label':['Không có '],'revenue':['NULL'],'employee':['NULL']})
#         return dff.to_dict(orient='records'),revenue_output,employee_output
#     else:
#         dff=df
#         return dff.iloc[page_current * page_size:(page_current + 1)*page_size].to_dict('records'),revenue_output,employee_output
        

# @app_Accounts.callback(
#     Output('download_detail_revenue_employee', 'href'),
#     [Input('download_detail_revenue_employee', 'n_clicks'),
#      Input('revenue_employee', 'data')]
# )
# def UPDATE_DOWNLOAD(click, data):
#     df = pd.DataFrame.from_dict(data)

#     csv_string = df.to_csv(index=False, encoding='utf-8', header=['Tên khách hàng','Doanh thu','Số lượng nhân viên'])
#     csv_string = "data:text/csv;charset=utf-8,%EF%BB%BF" + urllib.parse.quote(csv_string)
#     return csv_string