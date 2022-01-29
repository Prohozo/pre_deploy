import dash
import dash_core_components as dcc
import dash_html_components as html
from DB import DB_Users_CRM
from dash.dependencies import Input, Output, State
from utils import GParams_UsersCRM
from utils import Graph_UsersCRM
from app import app_UsersCRM
from datetime import date, timedelta, datetime



def gen_layout():
    tab_style = {'borderTop': '1px solid #FEA57D',
                'borderLeft': '1px solid #FEA57D',
                'borderRight': '1px solid #FEA57D',
                'borderBottom': '1px solid  #FEA57D',
                'backgroundColor':'#FEA57D',
                'color':'black',
                'fontWeight': 'bold',
                'text-align': 'center',
                'align-items': 'center',
                'padding':'9px 25px',
                }

    tab_selected_style= {'borderTop': '1px solid #F07E4F',
                        'borderLeft': '1px solid #F07E4F',
                        'borderRight': '1px solid #F07E4F',
                        'borderBottom': '1px solid  #F07E4F',
                        'backgroundColor':'#F07E4F',
                        'color':'white',
                        'padding':'9px 25px',
                        }
    layout = html.Div([
                html.Div([
                    dcc.Tabs(value='month',
                        children =[
                            dcc.Tab(label='Ngày',
                                    value='day',
                                    children = [
                                        dcc.Graph(id='user_activity_day',style={'width': '100%', 'height': '100%'}),
                                    ],
                                    style=tab_style, 
                                    selected_style=tab_selected_style, className = 'col-3'),
                            dcc.Tab(label='Tháng',
                                    value='month',
                                    children = [
                                        dcc.Graph(id='user_activity_month',style={'width': '100%', 'height': '100%'}),
                                    ],                            
                                    style=tab_style,
                                    selected_style=tab_selected_style, className = 'col-3'),
                            dcc.Tab(label='Quý',
                                    value='quarter',
                                    children = [
                                        dcc.Graph(id='user_activity_quarter',style={'width': '100%', 'height': '100%'}),
                                    ],                            
                                    style=tab_style,
                                    selected_style=tab_selected_style, className = 'col-3'),
                            dcc.Tab(label='Năm',
                                    value='year',
                                    children = [
                                        dcc.Graph(id='user_activity_year',style={'width': '100%', 'height': '100%'}),
                                    ], 
                                    style=tab_style,
                                    selected_style=tab_selected_style, className = 'col-3'),
                        ],style={'height':'6vh','width':'100%'},className='row'),
                ],className='au-card' ,style={'width': '100%', 'height': '100%'})
            ], className="col-sm-12 col-md-12 col-lg-12 mb-3", style={'height':'60vh'})

    return layout

@app_UsersCRM.callback(
    Output("user_activity_day","figure"),
    Output("user_activity_month","figure"),
    Output("user_activity_quarter","figure"),
    Output("user_activity_year","figure"),
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
    ],
    [State('user_without_activity','data'),
    State('user_task_delay','data'),
    State('user_activity_detail','data'),
    State('user_without_login','data'),
    ]

)

def UPDATE_USER_ACTIVITY(start_date,end_date,ddl_account,ddl_user_assign,ddl_dept,salesorder,task_created,task_finished,ac_withoutactivity,ac_task_delay,ac_activity_detail,ac_without_login,data_withoutactivity,data_task_delay,data_activity_detail,data_without_login):
    ctx = dash.callback_context
    datatable = {'user_without_activity': data_withoutactivity, 
                'user_task_delay': data_task_delay,
                'user_activity_detail':data_activity_detail,
                'user_without_login':data_without_login
                }
    label, value = GParams_UsersCRM.Get_Value(ctx,datatable)

    df1 = DB_Users_CRM.GET_USERSCRM(('user_activity_day',start_date,end_date,ddl_account,ddl_user_assign,ddl_dept,label,value))
    figure1 = Graph_UsersCRM.grh_LineChart(df1['day'],df1['Số lượng hoạt động'],mode='lines+markers',title='SỐ LƯỢNG HOẠT ĐỘNG THEO NGÀY',margin = [40, 170, 35, 35],color ='#FEA57D')



    df2 = DB_Users_CRM.GET_USERSCRM(('user_activity_month',start_date,end_date,ddl_account,ddl_user_assign,ddl_dept,label,value))
    figure2 = Graph_UsersCRM.grh_LineChart(df2['month'],df2['Số lượng hoạt động'],mode='lines+markers',title='SỐ LƯỢNG HOẠT ĐỘNG THEO THÁNG',margin = [40, 150, 35, 35],color ='#FEA57D')


    df3 = DB_Users_CRM.GET_USERSCRM(('user_activity_quarter',start_date,end_date,ddl_account,ddl_user_assign,ddl_dept,label,value)) 
    figure3 = Graph_UsersCRM.grh_LineChart(df3['quarter'],df3['Số lượng hoạt động'],mode='lines+markers',title='SỐ LƯỢNG HOẠT ĐỘNG THEO QUÝ',margin = [40, 170, 35, 35],color ='#FEA57D')

    df4 = DB_Users_CRM.GET_USERSCRM(('user_activity_year',start_date,end_date,ddl_account,ddl_user_assign,ddl_dept,label,value)) 
    figure4 = Graph_UsersCRM.grh_LineChart(df4['year'],df4['Số lượng hoạt động'],mode='lines+markers',title='SỐ LƯỢNG HOẠT ĐỘNG THEO NĂM',margin = [40, 150, 35, 35],color ='#FEA57D')
    
    return figure1,figure2,figure3,figure4




