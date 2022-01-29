import dash
import dash_core_components as dcc
import dash_html_components as html
from DB import DB_Users_CRM
from dash.dependencies import Input, Output, State
from utils import GParams_UsersCRM
from utils import Graph_UsersCRM
from static.system_dashboard.css import css_define as css
import pandas as pd
from app import app_UsersCRM

def gen_layout():

    layout = html.Div([
                html.Div([
                        html.Div([
                            html.Button(
                                html.I(className='fas fa-sync-alt'),
                                id='btn_R',
                                style={'paddingBottom':'0 !important', 'paddingTop':'0 !important','marginTop':'1%','marginLeft':'90%','backgroundColor':'#FFDC7D','borderColor':'#FFDC7D'},
                                className='btn_in_title btn btn-primary col-1')
                    ],style={'height': '5%','width':'100%','backgroundColor':'white','display':'flex','justifyContent':'end'}),
                    dcc.Graph(id="grh_parento_salesorder", style={'width': '100%', 'height': '100%'})
                ],className='au-card' ,style={'width': '100%', 'height': '100%'})
            ], className="col-sm-12 col-md-6 col-lg-6 mb-3" , style={'height':'55vh'})
           
    return layout


@app_UsersCRM.callback(
     Output("grh_parento_salesorder", "clickData"),
    [Input('btn_R', 'n_clicks')]
)
def reset_dt_bp(rs):
    return None
@app_UsersCRM.callback(
    Output("grh_parento_salesorder","figure"),
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

def UPDATE_PARENTO_SALESORDER(start_date,end_date,ddl_account,ddl_user_assign,ddl_dept,salesorder,task_created,task_finished,ac_withoutactivity,ac_task_delay,ac_activity_detail,ac_without_login,data_withoutactivity,data_task_delay,data_activity_detail,data_without_login):
    ctx = dash.callback_context
    datatable = {'user_without_activity': data_withoutactivity, 
                'user_task_delay': data_task_delay,
                'user_activity_detail':data_activity_detail,
                'user_without_login':data_without_login
                }
    label, value = GParams_UsersCRM.Get_Value(ctx,datatable)
    print(label)
    print(value)
    df = DB_Users_CRM.GET_USERSCRM(('user_salesorder',start_date,end_date,ddl_account,ddl_user_assign,ddl_dept,label,value))
    df['cumulative_sum'] = df['Số lượng đơn hàng'].cumsum()
    df['cumulative_perc'] = round(df['cumulative_sum']/df['Số lượng đơn hàng'].sum()*100,2)

    if df.empty:
        df = pd.DataFrame({'Nhân viên': ['NULL'], 'Số lượng đơn hàng': [0], 'cumulative_sum': [0], 'cumulative_perc': [0]})
    return  Graph_UsersCRM.grh_ParetoChart(df['Nhân viên'],df['Số lượng đơn hàng'],df['Nhân viên'],df['cumulative_perc'],label_x='NHÂN VIÊN',label_y='SỐ LƯỢNG ĐƠN HÀNG',marker_color=['#FFDC7D','#FFDC7D'],color_line='#F2807D',mode='lines+markers',title='SỐ LƯỢNG ĐƠN HÀNG THEO NHÂN VIÊN',margin = [50, 170, 50, 50],customdata= [i+1 for i in df.index.values])


