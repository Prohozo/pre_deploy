import dash
import dash_core_components as dcc
import dash_html_components as html
from DB import DB_DuAn
from utils import GParams_PJ_Multile_getTime
from app import app_DuAn
from dash.dependencies import Input, Output, State
from dash.exceptions import PreventUpdate
import datetime as dt
from datetime import date, timedelta, datetime

def gen_ddl(data ,id_ddl, placeholder):
    if id_ddl in ['ddl_name', 'ddl_dept']:
        options = [{'value': data.values[i][0], 'label': data.values[i][1]} for i in range(data.shape[0])]
    else:
        options = [{'value': data.values[i][0], 'label': data.values[i][0]} for i in range(data.shape[0])]
        
    return dcc.Dropdown(
                id=id_ddl,
                options = options,
                placeholder=placeholder
            )

def gen_layout():
    now = dt.datetime.today().strftime(r'%Y/%m/%d')

    data_1 = DB_DuAn.GET_DDL(('ddl_name',))
    data_dept = DB_DuAn.GET_DDL_dept(('ddl_dept',))
    
    layout =html.Div([
                html.Div([
                        html.Div(style={'margin-bottom': '10px'}),
                        html.Div('Ngày bắt đầu', style={
                                 'margin-bottom': '30px', 'font-size': '15px', 'color': 'black', 'font-weight': 'bold'}),
                        html.Div('Ngày kết thúc', style={
                                 'font-size': '15px', 'color': 'black', 'font-weight': 'bold'}),
                ], className='col-4'),
                html.Div([
                  dcc.DatePickerRange(
                           id='filter_date',
                           # day_size = 42,
                           display_format = 'DD/MM/YYYY',
                           clearable=True,
                           start_date_placeholder_text='Ngày bắt đầu',
                           end_date_placeholder_text='Ngày kết thúc',
                           number_of_months_shown=3,
                           minimum_nights=0,
                           
                           start_date_id='start_date',
                           end_date_id='end_date',
                           start_date='2019/01/01',
                           end_date=now)
               ], className ='col-8 m-b-15'),
                html.Div([
                   dcc.Dropdown(
                        id='ddl_time_range',
                        options=[
                            {'label': 'Ngày trước', 'value': 0},
                            {'label': 'Ngày hiện tại', 'value': 1},
                            {'label': 'Tuần trước', 'value': 2},
                            {'label': 'Tuần hiện tại', 'value': 3},
                            {'label': 'Tháng trước', 'value': 8},
                            {'label': 'Tháng hiện tại', 'value': 9},
                            {'label': 'Quý trước', 'value': 6},
                            {'label': 'Quý hiện tại', 'value': 7},
                            {'label': 'Năm trước', 'value': 4},
                            {'label': 'Năm hiện tại', 'value': 5},
                        ],
                        value=5,
                        placeholder='Khoảng thời gian',
                        style={'width': '100%'}
                    ),

                ],className="col-lg-12 col-md-12 col-xs-12 m-b-15"),
                html.Div([
                    gen_ddl(data_1 ,"ddl_name", "Dự án"),
                ], style={'display':'inline-grid', 'verticalAlign':'middle', 'alignItems':'center'},className="col-lg-12 col-md-12 col-xs-12 m-b-15"),
                html.Div([
                    gen_ddl(data_dept, "ddl_dept", "Chọn bộ phận"),
                ],className="col-lg-12 col-md-12 col-xs-12 m-b-15")
            ],className="row")
    return layout


@app_DuAn.callback(
    [Output('filter_date', 'start_date'),
    Output('filter_date', 'end_date')],
    [Input('ddl_time_range', 'value'),
    Input('grh_action_TG_month', 'clickData'),
    Input('grh_action_TG_year', 'clickData'),
    Input('grh_action_TG_day', 'clickData')]
)
def update_date_filter(date_value, grh_action_TG_month, grh_action_TG_year, grh_action_TG_day):
    ctx = dash.callback_context
    label, value = GParams_PJ_Multile_getTime.Get_Value(ctx)

    if label in ('action_month', 'action_day', 'action_year'):
        label = label.split('_')[1]

    Quarter = {
        'Quy1':[1, 2, 3],
        'Quy2':[4, 5, 6],
        'Quy3':[7, 8, 9],
        'Quy4':[10, 11, 12],
    }
    
    def genDateRange(start, end):
        start_date = datetime.strptime(start, "%Y-%m-%d").strftime("%Y-%m-%d")
        end_date = datetime.strptime(end, "%Y-%m-%d").strftime("%Y-%m-%d")
        return [start_date, end_date]

    # Thay doi dropdown list (Khoang thoi gian)
    if date_value is not None and label not in ('day', 'month', 'year'):
        if date_value == 0:
            yesterday = (date.today() - timedelta(days=1)).strftime("%Y-%m-%d")
            return yesterday, yesterday

        elif date_value == 1:
            today = date.today().strftime("%Y-%m-%d")
            return [today, today]

        elif date_value == 2:
            today = date.today()
            sunday_before = today - timedelta(days= today.weekday() + 1)
            return [(sunday_before-timedelta(6)).strftime("%Y-%m-%d"), sunday_before.strftime("%Y-%m-%d")]
            
        elif date_value == 3:
            today = date.today()
            begin_wk = today - timedelta(days= today.weekday())
            end_wk = begin_wk + timedelta(days= 6)
            return [begin_wk.strftime("%Y-%m-%d"), end_wk.strftime("%Y-%m-%d")]

        elif date_value == 4:
            year = str(date.today().year - 1)
            date_1 = datetime.strptime(year+'-1-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(year+'-12-31', "%Y-%m-%d").strftime("%Y-%m-%d")
            return [date_1, date_2]

        elif date_value == 5:
            year = str(date.today().year)
            date_1 = datetime.strptime(year+'-1-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(year+'-12-31', "%Y-%m-%d").strftime("%Y-%m-%d")
            return [date_1, date_2]

        elif date_value == 6:
            month = date.today().month
            year = date.today().year
            if month in Quarter['Quy1']:
                date_1, date_2 = genDateRange(str(year-1)+'-10-1', str(year-1)+'-12-31')
            elif month in Quarter['Quy2']:
                date_1, date_2 = genDateRange(str(year)+'-1-1', str(year)+'-3-31')
            elif month in Quarter['Quy3']:
                date_1, date_2 = genDateRange(str(year)+'-4-1', str(year)+'-6-30')
            else:
                date_1, date_2 = genDateRange(str(year)+'-7-1', str(year)+'-9-30')

            return [date_1, date_2]

        elif date_value == 7:
            month = date.today().month
            year = date.today().year
            if month in Quarter['Quy1']:
                date_1, date_2 = genDateRange(str(year)+'-1-1', str(year)+'-3-31')
            elif month in Quarter['Quy2']:
                date_1, date_2 = genDateRange(str(year)+'-4-1', str(year)+'-6-30')
            elif month in Quarter['Quy3']:
                date_1, date_2 = genDateRange(str(year)+'-7-1', str(year)+'-9-30')
            else:
                date_1, date_2 = genDateRange(str(year)+'-10-1', str(year)+'-12-31')

            return [date_1, date_2]

        elif date_value == 8:
            month = date.today().month
            year = date.today().year

            if month == 1:
                month = 12
                year -= 1
            else:
                month -= 1
                

            if month == 2:
                if(year % 4 == 0):
                    if(year % 100 == 0 and year % 400 != 0):
                        date_1, date_2 = genDateRange(str(year)+'-2-1', str(year)+'-2-28')
                    else:
                        date_1, date_2 = genDateRange(str(year)+'-2-1', str(year)+'-2-29')
                else:
                    date_1, date_2 = genDateRange(str(year)+'-2-1', str(year)+'-2-28')

            elif month in [1,3,5,7,8,10,12]:
                date_1, date_2 = genDateRange(str(year)+'-'+str(month)+'-1', str(year)+'-'+str(month)+'-31')
            else:
                date_1, date_2 = genDateRange(str(year)+'-'+str(month)+'-1', str(year)+'-'+str(month)+'-30')

            return [date_1, date_2]

        elif date_value == 9:
            month = date.today().month
            year = date.today().year
            if month == 2:
                if(year % 4 == 0):
                    if(year % 100 == 0 and year % 400 != 0):
                        date_1, date_2 = genDateRange(str(year)+'-2-1', str(year)+'-2-28')
                    else:
                        date_1, date_2 = genDateRange(str(year)+'-2-1', str(year)+'-2-29')
                else:
                    date_1, date_2 = genDateRange(str(year)+'-2-1', str(year)+'-2-28')

            elif month in [1,3,5,7,8,10,12]:
                date_1, date_2 = genDateRange(str(year)+'-'+str(month)+'-1', str(year)+'-'+str(month)+'-31')
            else:
                date_1, date_2 = genDateRange(str(year)+'-'+str(month)+'-1', str(year)+'-'+str(month)+'-30')
            return [date_1, date_2]
        else:
            return ['2019/01/01', date.today().strftime("%Y-%m-%d")]

    # else:
    #     return ['2019/01/01', date.today().strftime("%Y-%m-%d")]
    #Tuong tac bieu do line chart
    elif label in ('day', 'month', 'year'):
        if label == 'day':
            start_date = datetime.strptime(value, '%Y-%m-%d')
            end_date = start_date

        elif label == 'month':
            month = value[5:7]
            year = value[:4]

            start_date = year + '/' + month + '/01'
            if month in ('01', '03', '05', '07', '08', '10', '12'):
                end_date = year + '/' + month + '/31'

            elif month in ('04', '06', '09', '11'):
                end_date = year + '/' + month + '/30'

                
            elif month == '02' and year not in ('2020', '2024', '2028'):
                end_date = year + '/' + month + '/28'

            elif month == '02' and year in ('2020', '2024', '2028'):
                end_date = year + '/' + month + '/29'
            
            else:
                return ['2019-01-01', date.today().strftime("%Y-%m-%d")]
        
        elif label == 'year':
            year = value[:4]
            start_date = datetime.strptime(value, '%Y-%m-%d')
            end_date = year + '-12-31'

        return [start_date, end_date]
    else:
        return ['2019-01-01', date.today().strftime("%Y-%m-%d")]
