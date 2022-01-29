import dash
import dash_core_components as dcc
import dash_html_components as html
import dash_table
import urllib.parse
import pandas as pd
from static.system_dashboard.css import css_define as css
from dash_table.Format import Format, Scheme
import dash_table.FormatTemplate as FormatTemplate
from DB import DB_User
from dash.dependencies import Input, Output, State
from utils import GParams_User as GParams
from utils import Graph_User as Graph
from app import app_User
from datetime import date, timedelta, datetime


def gen_layout():

    layout =html.Div([
                        html.Div([
                            html.Div([
                                html.Div("CHI TIẾT WORKLOAD THEO NHÂN VIÊN", style={'width':'100%','fontWeight': 'bold','background': '#FFD45D'}),
                                html.A(
                                    children=[
                                        html.I(className="fas fa-file-download")
                                    ],
                                    id='download_detail_user_workload',
                                    download="DETAIL_USERS_WORKLOAD.csv",
                                    target="_blank",
                                    href = '',
                                    className='btn btn-primary',
                                    style={'position':'absolute','top':'0','right':'0','paddingTop':'0','paddingBottom':'0','marginTop': '2%','marginRight':'3%','height': '50%','display': 'inline-grid','alignItems': 'center','backgroundColor':'#FFD45D','borderColor':'#FFD45D'}
                                ),
                            ],style={'height': '10%','width':'100%','background': '#FFD45D','textAlign':'center','display':'inline-grid','alignItems':'center','position':'relative'}),
                            dash_table.DataTable(
                                id='detail_user_workload',
                                columns=[
                                    {
                                        'name': 'Nhân viên', 
                                        'id': 'u.account',
                                    },
                                    {
                                        'name': 'Số task còn lại', 
                                        'id': 'num_task_left',
                                    },
                                    {
                                        'name': 'Số giờ dự kiến', 
                                        'id': 'num_est',
                                    },
                                    {
                                        'name': 'Workload', 
                                        'id': 'workload',    
                                        'type':'numeric',                                    
                                        'format': FormatTemplate.percentage(2)
                                    },
                                ],
                                style_cell_conditional=[
                                    {
                                        'if': {'column_id': 'u.account'},
                                        'width': '25%',
                                        'vertical-align': 'text-top',

                                    },
                                    {
                                        'if': {'column_id': 'num_task_left'},
                                        'width': '25%',
                                        'textAlign': 'center',
                                        
                                        
                                    },
                                    {
                                        'if': {'column_id': 'num_est'},
                                        'width': '25%',
                                        'textAlign': 'center',
                                        
                                        
                                    },
                                    {
                                        'if': {'column_id': 'workload'},
                                        'width': '25%',
                                        'textAlign': 'center',
                                        
                                        
                                        
                                    },
                                ],
                                css=[
                                        {
                                            'selector': '.dash-fixed-content',
                                            'rule': 'width: 100%;'
                                        }
                                    ],
                                fixed_rows={'headers': True},
                                style_header=css.style_header,
                                style_cell=css.style_cell,
                                page_action='none',
                                style_table={'height': '100%','width':'100%'},
                                sort_action="native",
                                # sort_mode="multi",
                            )
                        ], className="au-card",style={'height':'100%'})
                    ], className="col-sm-12 col-md-12 col-lg-12 mb-3",style={'height':'60vh'})

    return layout

@app_User.callback(
    Output("detail_user_workload", "data"),
    Output("detail_user_workload", "style_data_conditional"),
    [Input('date-picker-range','start_date'),
    Input('date-picker-range','end_date'),
    Input('ddl_project','value'),
    Input('ddl_user','value'),
    Input('ddl_dept','value'),
    Input('grh_bar_taskopened','selectedData'),
    Input('grh_bar_taskdone','selectedData'),
    Input('grh_bar_project','selectedData'),
    Input('grh_bar_taskstarted','selectedData'),
    Input('grh_bar_project_task','selectedData'),
    Input('detail_PROJECT','active_cell'),
    Input('user_0_task','active_cell'),
    Input('user_0_login','active_cell'),
    Input('detail_project_task','active_cell'),
    Input('detail_user_workload','active_cell'),
    ],
    [State('detail_PROJECT','data'),
    State('user_0_task','data'),
    State('user_0_login','data'),
    State('detail_project_task','data'),
    State('detail_user_workload','data'),],

)

def UPDATE_DETAIL_USER_WORKLOAD(start_date,end_date,ddl_project,ddl_user,ddl_dept,user_opened,user_done,user_project,user_started,user_project_task,ac_project,ac_user,ac_log,ac_project_task,ac_workload,data_project, data_user,data_log,data_project_task,data_workload):
    ctx = dash.callback_context
    datatable = {'detail_PROJECT':data_project,
                 'user_0_task': data_user,
                 'user_0_login': data_log,
                 'detail_project_task':data_project_task,
                 'detail_user_workload':data_workload}
    label, value = GParams.Get_Value(ctx,datatable)
    df =DB_User.GET_USER(('table_user_workload',start_date,end_date,ddl_project,ddl_user,ddl_dept,label,value,None,None,None,None))


    date_range = (datetime.strptime(end_date, "%Y-%m-%d") - datetime.strptime(start_date, "%Y-%m-%d"))
    df['workload'] = round(df['num_est']/(date_range.days*8),4) 
    sdc =   (
                
                [{
                    'if': {'row_index': 'odd'},
                    'color':'#646464', 
                    'backgroundColor': '#f9f9f9'
                }]
            )
    if df.empty:
        dff = pd.DataFrame({'u.account':['Không có ai'],'num_task_left':['NULL'],'num_est':['NULL'],'workload':['NULL']})
        return [dff.to_dict(orient='records'),sdc]
    else: return [df.to_dict(orient='records'),sdc]

@app_User.callback(
     Output('download_detail_user_workload', 'href'),
    [Input('download_detail_user_workload','n_clicks'),
     Input('detail_user_workload','data')]
)
def UPDATE_DOWNLOAD(click,data):
    df = pd.DataFrame.from_dict(data)
    csv_string = df.to_csv(index=False, encoding='utf-8',header=['Nhân viên','Số task còn lại','Số giờ dự kiến','Workload'])
    csv_string = "data:text/csv;charset=utf-8,%EF%BB%BF" + urllib.parse.quote(csv_string)
    return csv_string