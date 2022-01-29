import dash
import dash_core_components as dcc
import dash_html_components as html
import dash_table
import urllib.parse
import pandas as pd
from static.system_dashboard.css import css_define as css
from dash_table.Format import Format, Scheme
from DB import DB_Users_CRM
from dash.dependencies import Input, Output, State
from utils import GParams_UsersCRM
from utils import Graph_UsersCRM
from app import app_UsersCRM

def gen_layout():

    layout =html.Div([
                        html.Div([
                            html.Div([
                                html.Div("BẢNG CHI TIẾT HOẠT ĐỘNG THEO NHÂN VIÊN", style={'width':'100%','fontWeight': 'bold','background': '#7DC383'}),
                                html.A(
                                    children=[
                                        html.I(className="fas fa-file-download")
                                    ],
                                    id='download_detail_activity_user',
                                    download="DETAIL_ACTIVITY_USERS.csv",
                                    target="_blank",
                                    href = '',
                                    className='btn btn-primary',
                                    style={'position':'absolute','top':'0','right':'0','paddingTop':'0','paddingBottom':'0','marginTop': '2%','marginRight':'3%','height': '50%','display': 'inline-grid','alignItems': 'center','backgroundColor':'#7DC383','borderColor':'#7DC383'}),
                            ], style={'height': '10%','width':'100%','background': '#7DC383','textAlign':'center','display':'inline-grid','alignItems':'center','position':'relative'}),
                            dash_table.DataTable(
                                id='user_activity_detail',
                                columns=[
                                    {
                                        'name': 'Tên hoạt động', 
                                        'id': 'c.label',
                                        'presentation': 'markdown'
                                    },
                                    {
                                        'name': 'NV được phân công', 
                                        'id': 'u.user_name',
                                    },
                                    {
                                        'name': 'Loại hoạt động', 
                                        'id': 'a.activitytype',
                                    },
                                    {
                                        'name': 'Trạng thái', 
                                        'id': 'a.status',
                                    },
                                    {
                                        'name': 'Ngày tạo', 
                                        'id': 'DATE(c.createdtime)',
                                    },
                                    {
                                        'name': 'Ngày bắt đầu', 
                                        'id': 'a.date_start',
                                    },
                                    {
                                        'name': 'Ngày đáo hạn', 
                                        'id': 'a.due_date',
                                    },
                                    {
                                        'name': 'Ngày sửa', 
                                        'id': 'DATE(c.modifiedtime)',
                                    },
                                    {
                                        'name': 'KH liên quan', 
                                        'id': 'c2.label',
                                        'presentation': 'markdown'
                                    },
                                ],
                                style_cell_conditional=[
                                    {
                                        'if': {'column_id': 'c.label'},
                                        'width': '29%',
                                        'vertical-align': 'text-top',
                                        'padding-left':'15px',

                                    },
                                    {
                                        'if': {'column_id': 'u.user_name'},
                                        'width': '6%',
                                        'textAlign': 'center',
                                        
                                    },
                                    {
                                        'if': {'column_id': 'a.activitytype'},
                                        'width': '6%',
                                        'textAlign': 'center',
                                        
                                    },
                                    {
                                        'if': {'column_id': 'a.status'},
                                        'width': '6%',
                                        'textAlign': 'center',
                                        
                                    },
                                    {
                                        'if': {'column_id': 'DATE(c.createdtime)'},
                                        'width': '6%',
                                        'textAlign': 'center',
                                        
                                    },
                                    {
                                        'if': {'column_id': 'a.date_start'},
                                        'width': '6%',
                                        'textAlign': 'center',
                                        
                                    },
                                    {
                                        'if': {'column_id': 'a.due_date'},
                                        'width': '6%',
                                        'textAlign': 'center',
                                        
                                    },
                                    {
                                        'if': {'column_id': 'DATE(c.modifiedtime)'},
                                        'width': '6%',
                                        'textAlign': 'center',
                                        
                                    },
                                    {
                                        'if': {'column_id': 'c2.label'},
                                        'width': '29%',
                                        'textAlign': 'left',
                                        
                                    },
                                    
                                ],
                                
                                css=[
                                        {
                                            'selector': '.dash-fixed-content',
                                            'rule': 'width: 100%;'
                                        },
                                        {
                                            'selector': 'p',
                                            'rule':'text-align : left'
                                        }                   
                                    ],
                                fixed_rows={'headers': True},
                                style_header=css.style_header,
                                style_cell=css.style_cell,
                                page_current=0,
                                page_size=50,
                                style_table={'height': '100%','width':'100%'},
                                page_action='custom',
                                
                                sort_mode='multi',
                                sort_action="custom",
                                sort_by=[],
                                
                                filter_action='custom',
                                filter_query='',
                                
                            )
                        ], className="au-card",style={'height':'100%'})
                    ], className="col-12 mb-3",style={'height':'75vh'})

    return layout

operators = [['ge ', '>='],
             ['le ', '<='],
             ['lt ', '<'],
             ['gt ', '>'],
             ['ne ', '!='],
             ['eq ', '='],
             ['contains '],
             ['datestartswith ']]

def split_filter_part(filter_part):
    for operator_type in operators:
        for operator in operator_type:
            if operator in filter_part:
                name_part, value_part = filter_part.split(operator, 1)
                name = name_part[name_part.find('{') + 1: name_part.rfind('}')]

                value_part = value_part.strip()
                v0 = value_part[0]
                if (v0 == value_part[-1] and v0 in ("'", '"', '`')):
                    value = value_part[1: -1].replace('\\' + v0, v0)
                else:
                    try:
                        value = float(value_part)
                    except ValueError:
                        value = value_part
                return name, operator_type[0].strip(), value
    return [None] * 3

@app_UsersCRM.callback(
    Output("user_activity_detail","data"),
    [Input('date-picker-range','start_date'),
    Input('date-picker-range','end_date'),
    Input('ddl_account','value'),
    Input('ddl_user_assign','value'),
    Input('ddl_dept','value'),
    Input('grh_parento_salesorder','clickData'),
    Input('grh_bar_task_created','selectedData'),
    Input('grh_bar_task_finished','selectedData'),
    Input('user_without_activity','active_cell'),
    Input('user_task_delay','active_cell'),
    Input('user_activity_detail','active_cell'),
    Input('user_without_login','active_cell'),
    Input('user_activity_detail', 'page_current'),
    Input('user_activity_detail', 'page_size'),
    Input('user_activity_detail', 'sort_by'),
    Input('user_activity_detail', 'filter_query'),
    ],
    [State('user_without_activity','data'),
    State('user_task_delay','data'),
    State('user_activity_detail','data'),
    State('user_without_login','data'),
    ]
    
)

def UPDATE_USER_ACTIVITY_DETAIL(start_date,end_date,ddl_account,ddl_user_assign,ddl_dept,salesorder,task_created,task_finished,ac_withoutactivity,ac_task_delay,ac_activity_detail,ac_without_login,page_current,page_size,sort_by, filter,data_withoutactivity,data_task_delay,data_activity_detail,data_without_login):
    ctx = dash.callback_context
    datatable = {'user_without_activity': data_withoutactivity, 
                'user_task_delay': data_task_delay,
                'user_activity_detail':data_activity_detail,
                'user_without_login':data_without_login
                }
    label, value = GParams_UsersCRM.Get_Value(ctx,datatable)
    df = DB_Users_CRM.GET_USERSCRM(('activity_detail',start_date,end_date,ddl_account,ddl_user_assign,ddl_dept,label,value))
    filtering_expressions = filter.split(' && ')
    if df.empty:
        dff = pd.DataFrame({'c.crmid':['NULL'],'c.label':['NULL'],'u.user_name':['NULL'],'a.activitytype':['NULL'],'a.status':['NULL'],'DATE(c.createdtime)':['NULL'],'a.date_start':['NULL'],'a.due_date':['NULL'],'DATE(c.modifiedtime)':['NULL'],'c2.crmid':['NULL'],'c2.label':['NULL']})
        
    else:
        dff=df
        dff['DATE(c.createdtime)'] = pd.DatetimeIndex(dff['DATE(c.createdtime)']).strftime("%d-%m-%Y")
        dff['a.date_start'] = pd.DatetimeIndex(dff['a.date_start']).strftime("%d-%m-%Y")
        dff['a.due_date'] = pd.DatetimeIndex(dff['a.due_date']).strftime("%d-%m-%Y")
        dff['DATE(c.modifiedtime)'] = pd.DatetimeIndex(dff['DATE(c.modifiedtime)']).strftime("%d-%m-%Y")
    for filter_part in filtering_expressions:
        col_name, operator, filter_value = split_filter_part(filter_part)

        if operator in ('eq', 'ne', 'lt', 'le', 'gt', 'ge'):
            dff = dff.loc[getattr(dff[col_name], operator)(filter_value)]
        elif operator == 'contains':
            dff = dff.loc[dff[col_name].str.contains(filter_value)]
        elif operator == 'datestartswith':
            dff = dff.loc[dff[col_name].str.startswith(filter_value)]
    if len(sort_by):
        dff = dff.sort_values(
            [col['column_id'] for col in sort_by],
            ascending=[
                col['direction'] == 'asc'
                for col in sort_by
            ],
            inplace=False
        )

    
    
    return dff.iloc[page_current * page_size:(page_current + 1)*page_size].to_dict('records')
        

@app_UsersCRM.callback(
    Output('download_detail_activity_user', 'href'),
    [Input('download_detail_activity_user', 'n_clicks'),
    Input('date-picker-range','start_date'),
    Input('date-picker-range','end_date'),
    Input('ddl_account','value'),
    Input('ddl_user_assign','value'),
    Input('ddl_dept','value'),
    Input('grh_parento_salesorder','clickData'),
    Input('grh_bar_task_created','selectedData'),
    Input('grh_bar_task_finished','selectedData'),
    Input('user_without_activity','active_cell'),
    Input('user_task_delay','active_cell'),
    Input('user_activity_detail','active_cell'),
    Input('user_without_login','active_cell'),
    Input('user_activity_detail', 'page_current'),
    Input('user_activity_detail', 'page_size'),
    Input('user_activity_detail', 'sort_by'),
    Input('user_activity_detail', 'filter_query'),
    ],
    [State('user_without_activity','data'),
    State('user_task_delay','data'),
    State('user_activity_detail','data'),
    State('user_without_login','data'),
    ]
)
def UPDATE_DOWNLOAD(click,start_date,end_date,ddl_account,ddl_user_assign,ddl_dept,salesorder,task_created,task_finished,ac_withoutactivity,ac_task_delay,ac_activity_detail,ac_without_login,page_current,page_size,sort_by, filter,data_withoutactivity,data_task_delay,data_activity_detail,data_without_login):
    ctx = dash.callback_context
    datatable = {'user_without_activity': data_withoutactivity, 
                'user_task_delay': data_task_delay,
                'user_activity_detail':data_activity_detail,
                'user_without_login':data_without_login
                }
    label, value = GParams_UsersCRM.Get_Value(ctx,datatable)
    df = DB_Users_CRM.GET_USERSCRM(('activity_detail',start_date,end_date,ddl_account,ddl_user_assign,ddl_dept,label,value))
    df = df.drop(columns=['c.crmid','c2.crmid'])
    filtering_expressions = filter.split(' && ')
    if df.empty:
         dff = pd.DataFrame({'c.label':['NULL'],'u.user_name':['NULL'],'a.activitytype':['NULL'],'a.status':['NULL'],'DATE(c.createdtime)':['NULL'],'a.date_start':['NULL'],'a.due_date':['NULL'],'DATE(c.modifiedtime)':['NULL'],'c2.label':['NULL']})
    else:
        dff=df
    for filter_part in filtering_expressions:
        col_name, operator, filter_value = split_filter_part(filter_part)

        if operator in ('eq', 'ne', 'lt', 'le', 'gt', 'ge'):
            dff = dff.loc[getattr(dff[col_name], operator)(filter_value)]
        elif operator == 'contains':
            dff = dff.loc[dff[col_name].str.contains(filter_value)]
        elif operator == 'datestartswith':
            dff = dff.loc[dff[col_name].str.startswith(filter_value)]
    if len(sort_by):
        dff = dff.sort_values(
            [col['column_id'] for col in sort_by],
            ascending=[
                col['direction'] == 'asc'
                for col in sort_by
            ],
            inplace=False
        )
    dff['c.label'] = dff['c.label'].apply(lambda x: x.split(']')[0][1:])
    dff['c2.label'] = dff['c.label'].apply(lambda x: x.split(']')[0][1:])
    csv_string = dff.to_csv(index=False, encoding='utf-8', header=['Tên hoạt động','NV được phân công','Loại hoạt động','Trạng thái','Ngày tạo','Ngày bắt đầu','Ngày đáo hạn','Ngày sửa','KH liên quan'])
    csv_string = "data:text/csv;charset=utf-8,%EF%BB%BF" + urllib.parse.quote(csv_string)
    return csv_string