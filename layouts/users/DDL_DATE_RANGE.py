import dash
import dash_core_components as dcc
import dash_html_components as html
from utils import GParams_User as GParams
from DB import DB_User
from dash.dependencies import Input, Output, State
import pandas as pd
from datetime import date, timedelta, datetime
from app import app_User

def gen_layout():
    
    layout = html.Div([                    
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
                    value = 5,
                    placeholder='Khoảng thời gian',
                    style={'height': '50px', 'width': '100%', 'margin-bottom':'10px'}
                    ),

            ],className="col-sm-12 col-md-12 col-lg-4 mb-3")
 
    return layout


@app_User.callback(
    Output('date-picker-range', 'start_date'),
    Output('date-picker-range', 'end_date'),
    Input('ddl_time_range', 'value'),
)
def update_date_filter(date_value):
        # Thay doi drop down list Khoang thoi gian
    if date_value == 0:
        yesterday = (date.today() - timedelta(days=1)).strftime("%Y-%m-%d")
        return yesterday, yesterday

    elif date_value == 1:
        today = date.today().strftime("%Y-%m-%d")
        return today, today

    elif date_value == 2:
        date_ = date.today()
        while(date_.weekday()!=6):
            date_ -= timedelta(days=1)
        return (date_-timedelta(6)).strftime("%Y-%m-%d"), date_.strftime("%Y-%m-%d")

    elif date_value == 3:
        date_1 = date.today()
        date_2 = date.today()
        while(date_2.weekday() != 6):
            date_2 += timedelta(days=1)
        while(date_1.weekday() != 0):
            date_1 -= timedelta(days=1)
        return date_1.strftime("%Y-%m-%d"), date_2.strftime("%Y-%m-%d")

    elif date_value == 4:
        year = str(date.today().year - 1)
        date_1 = datetime.strptime(year+'-1-1', "%Y-%m-%d").strftime("%Y-%m-%d")
        date_2 = datetime.strptime(year+'-12-31', "%Y-%m-%d").strftime("%Y-%m-%d")
        return date_1, date_2

    elif date_value == 5:
        year = str(date.today().year)
        date_1 = datetime.strptime(year+'-1-1', "%Y-%m-%d").strftime("%Y-%m-%d")
        date_2 = datetime.today().strftime('%Y-%m-%d')
        return date_1, date_2

    elif date_value == 6:
        month = str(date.today().month)
        year = date.today().year
        if month in ['1','2','3']:
            date_1 = datetime.strptime(str(year-1)+'-10-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(str(year)+'-12-31', "%Y-%m-%d").strftime("%Y-%m-%d")
        elif month in ['4', '5', '6']:
            date_1 = datetime.strptime(str(year)+'-1-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(str(year)+'-3-31', "%Y-%m-%d").strftime("%Y-%m-%d")
        elif month in ['7', '8', '9']:
            date_1 = datetime.strptime(str(year)+'-4-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(str(year)+'-6-30', "%Y-%m-%d").strftime("%Y-%m-%d")
        elif month in ['10', '11', '12']:
            date_1 = datetime.strptime(str(year)+'-7-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(str(year)+'-9-30', "%Y-%m-%d").strftime("%Y-%m-%d")
        return date_1, date_2
        
    elif date_value == 7:
        month = str(date.today().month)
        year = str(date.today().year)
        if month in ['1', '2', '3']:
            date_1 = datetime.strptime(year+'-1-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(year+'-3-31', "%Y-%m-%d").strftime("%Y-%m-%d")
        elif month in ['4', '5', '6']:
            date_1 = datetime.strptime(year+'-4-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(year+'-6-30', "%Y-%m-%d").strftime("%Y-%m-%d")
        elif month in ['7', '8', '9']:
            date_1 = datetime.strptime(year+'-7-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(year+'-9-30', "%Y-%m-%d").strftime("%Y-%m-%d")
        elif month in ['10', '11', '12']:
            date_1 = datetime.strptime(year+'-10-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(year+'-12-31', "%Y-%m-%d").strftime("%Y-%m-%d")
        return date_1, date_2
    
    elif date_value == 8:
            month = date.today().month
            year = date.today().year
            if month == 2 and year % 4 == 0:
                date_1 = datetime.strptime(str(year)+'-2-1', "%Y-%m-%d").strftime("%Y-%m-%d")
                date_2 = datetime.strptime(str(year)+'-2-29', "%Y-%m-%d").strftime("%Y-%m-%d")
            elif month == 2:
                date_1 = datetime.strptime(str(year)+'-2-1', "%Y-%m-%d").strftime("%Y-%m-%d")
                date_2 = datetime.strptime(str(year)+'-2-28', "%Y-%m-%d").strftime("%Y-%m-%d")
            elif month in [1,3,5,7,8,10,12]:
                date_1 = datetime.strptime(str(year)+'-'+str(month)+'-1', "%Y-%m-%d").strftime("%Y-%m-%d")
                date_2 = datetime.strptime(str(year)+'-'+str(month)+'-31', "%Y-%m-%d").strftime("%Y-%m-%d")
            elif month in [4, 6, 9, 11]:
                date_1 = datetime.strptime(str(year)+'-'+str(month)+'-1', "%Y-%m-%d").strftime("%Y-%m-%d")
                date_2 = datetime.strptime(str(year)+'-'+str(month)+'-30', "%Y-%m-%d").strftime("%Y-%m-%d")
            return date_1, date_2

    elif date_value == 9:
        month = date.today().month
        year = date.today().year
        if month == 2 and year % 4 == 0:
            date_1 = datetime.strptime(str(year)+'-2-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(str(year)+'-2-29', "%Y-%m-%d").strftime("%Y-%m-%d")
        elif month == 2:
            date_1 = datetime.strptime(str(year)+'-2-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(str(year)+'-2-28', "%Y-%m-%d").strftime("%Y-%m-%d")
        elif month in [1, 3, 5, 7, 8, 10, 12]:
            date_1 = datetime.strptime(str(year)+'-'+str(month)+'-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(str(year)+'-'+str(month)+'-31', "%Y-%m-%d").strftime("%Y-%m-%d")
        elif month in [4, 6, 9, 11]:
            date_1 = datetime.strptime(str(year)+'-'+str(month)+'-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(str(year)+'-'+str(month)+'-30', "%Y-%m-%d").strftime("%Y-%m-%d")
        return date_1, date_2
    else:
        date_1 =  date(2019,7,13)
        date_2 = datetime.today().strftime('%Y-%m-%d')
        return date_1,date_2 

 

