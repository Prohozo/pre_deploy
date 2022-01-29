import dash
from dash import dcc
from dash import html
from utils import GParams_Accounts
from DB import DB_Accounts
from dash.dependencies import Input, Output, State
import pandas as pd
from datetime import date, timedelta, datetime
from app import app_Accounts


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
            value=5,
            placeholder='Khoảng thời gian',
            style={'height': '50px', 'width': '100%'},
        )
    ], className="col-sm-12 col-md-6 col-lg-2 mb-3")

    return layout


@app_Accounts.callback(
    Output('date-picker-range', 'start_date'),
    Output('date-picker-range', 'end_date'),
    Input('ddl_time_range', 'value'),
    Input('account_day', 'clickData'),
    Input('account_month', 'clickData'),
    Input('account_year', 'clickData'),
    Input('account_quarter', 'clickData'),
)
def update_date_filter(date_value, day_account, month_account, year_account, quarter_account):
    ctx = dash.callback_context
    label, value = GParams_Accounts.Get_Value(ctx)
    # Thay doi drop down list Khoang thoi gian
    ctx = dash.callback_context
    label, value = GParams_Accounts.Get_Value(ctx)

    # Thay doi dropdown list (Khoang thoi gian)
    if date_value is not None and label not in ('day', 'month', 'year', 'quarter'):
        if date_value == 0:
            yesterday = (date.today() - timedelta(days=1)).strftime("%Y-%m-%d")
            return yesterday, yesterday

        elif date_value == 1:
            today = date.today().strftime("%Y-%m-%d")
            return today, today

        elif date_value == 2:
            date_ = date.today()
            while(date_.weekday() != 6):
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
            date_1 = datetime.strptime(
                year+'-1-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(
                year+'-12-31', "%Y-%m-%d").strftime("%Y-%m-%d")
            return date_1, date_2

        elif date_value == 5:
            year = str(date.today().year)
            date_1 = datetime.strptime(
                year+'-1-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.today().strftime('%Y-%m-%d')
            return date_1, date_2

        elif date_value == 6:
            month = str(date.today().month)
            year = date.today().year
            if month in ['1', '2', '3']:
                date_1 = datetime.strptime(
                    str(year-1)+'-10-1', "%Y-%m-%d").strftime("%Y-%m-%d")
                date_2 = datetime.strptime(
                    str(year)+'-12-31', "%Y-%m-%d").strftime("%Y-%m-%d")
            elif month in ['4', '5', '6']:
                date_1 = datetime.strptime(
                    str(year)+'-1-1', "%Y-%m-%d").strftime("%Y-%m-%d")
                date_2 = datetime.strptime(
                    str(year)+'-3-31', "%Y-%m-%d").strftime("%Y-%m-%d")
            elif month in ['7', '8', '9']:
                date_1 = datetime.strptime(
                    str(year)+'-4-1', "%Y-%m-%d").strftime("%Y-%m-%d")
                date_2 = datetime.strptime(
                    str(year)+'-6-30', "%Y-%m-%d").strftime("%Y-%m-%d")
            elif month in ['10', '11', '12']:
                date_1 = datetime.strptime(
                    str(year)+'-7-1', "%Y-%m-%d").strftime("%Y-%m-%d")
                date_2 = datetime.strptime(
                    str(year)+'-9-30', "%Y-%m-%d").strftime("%Y-%m-%d")
            return date_1, date_2

        elif date_value == 7:
            month = str(date.today().month)
            year = str(date.today().year)
            if month in ['1', '2', '3']:
                date_1 = datetime.strptime(
                    year+'-1-1', "%Y-%m-%d").strftime("%Y-%m-%d")
                date_2 = datetime.strptime(
                    year+'-3-31', "%Y-%m-%d").strftime("%Y-%m-%d")
            elif month in ['4', '5', '6']:
                date_1 = datetime.strptime(
                    year+'-4-1', "%Y-%m-%d").strftime("%Y-%m-%d")
                date_2 = datetime.strptime(
                    year+'-6-30', "%Y-%m-%d").strftime("%Y-%m-%d")
            elif month in ['7', '8', '9']:
                date_1 = datetime.strptime(
                    year+'-7-1', "%Y-%m-%d").strftime("%Y-%m-%d")
                date_2 = datetime.strptime(
                    year+'-9-30', "%Y-%m-%d").strftime("%Y-%m-%d")
            elif month in ['10', '11', '12']:
                date_1 = datetime.strptime(
                    year+'-10-1', "%Y-%m-%d").strftime("%Y-%m-%d")
                date_2 = datetime.strptime(
                    year+'-12-31', "%Y-%m-%d").strftime("%Y-%m-%d")
            return date_1, date_2

        elif date_value == 8:
            month = date.today().month - 1
            year = date.today().year
            if month == 2 and year % 4 == 0:
                date_1 = datetime.strptime(
                    str(year)+'-2-1', "%Y-%m-%d").strftime("%Y-%m-%d")
                date_2 = datetime.strptime(
                    str(year)+'-2-29', "%Y-%m-%d").strftime("%Y-%m-%d")
            elif month == 2:
                date_1 = datetime.strptime(
                    str(year)+'-2-1', "%Y-%m-%d").strftime("%Y-%m-%d")
                date_2 = datetime.strptime(
                    str(year)+'-2-28', "%Y-%m-%d").strftime("%Y-%m-%d")
            elif month in [1, 3, 5, 7, 8, 10, 12]:
                date_1 = datetime.strptime(
                    str(year)+'-'+str(month)+'-1', "%Y-%m-%d").strftime("%Y-%m-%d")
                date_2 = datetime.strptime(
                    str(year)+'-'+str(month)+'-31', "%Y-%m-%d").strftime("%Y-%m-%d")
            elif month in [4, 6, 9, 11]:
                date_1 = datetime.strptime(
                    str(year)+'-'+str(month)+'-1', "%Y-%m-%d").strftime("%Y-%m-%d")
                date_2 = datetime.strptime(
                    str(year)+'-'+str(month)+'-30', "%Y-%m-%d").strftime("%Y-%m-%d")
            return date_1, date_2

        elif date_value == 9:
            month = date.today().month
            year = date.today().year
            if month == 2 and year % 4 == 0:
                date_1 = datetime.strptime(
                    str(year)+'-2-1', "%Y-%m-%d").strftime("%Y-%m-%d")
                date_2 = datetime.strptime(
                    str(year)+'-2-29', "%Y-%m-%d").strftime("%Y-%m-%d")
            elif month == 2:
                date_1 = datetime.strptime(
                    str(year)+'-2-1', "%Y-%m-%d").strftime("%Y-%m-%d")
                date_2 = datetime.strptime(
                    str(year)+'-2-28', "%Y-%m-%d").strftime("%Y-%m-%d")
            elif month in [1, 3, 5, 7, 8, 10, 12]:
                date_1 = datetime.strptime(
                    str(year)+'-'+str(month)+'-1', "%Y-%m-%d").strftime("%Y-%m-%d")
                date_2 = datetime.strptime(
                    str(year)+'-'+str(month)+'-31', "%Y-%m-%d").strftime("%Y-%m-%d")
            elif month in [4, 6, 9, 11]:
                date_1 = datetime.strptime(
                    str(year)+'-'+str(month)+'-1', "%Y-%m-%d").strftime("%Y-%m-%d")
                date_2 = datetime.strptime(
                    str(year)+'-'+str(month)+'-30', "%Y-%m-%d").strftime("%Y-%m-%d")
            return date_1, date_2
        else:
            return None, None

    # Tuong tac bieu do line chart
    elif label in ('day', 'month', 'year', 'quarter'):
        if label == 'day':
            start_date = datetime.strptime(
                value, '%d/%m/%Y').strftime('%Y/%m/%d')
            end_date = start_date

        elif label == 'month':
            month = value[0:2]
            year = value[-4:]

            start_date = year + '/' + month + '1'
            if month in ('1/', '3/', '5/', '7/', '8/', '10', '12'):
                if month in ('10', '12'):
                    start_date = year + '/' + month + '/1'
                    end_date = year + '/' + month + '/31'
                else:
                    end_date = year + '/' + month + '31'

            elif month in ('4/', '6/', '9/', '11'):
                if month == '11':
                    start_date = year + '/' + month + '/1'
                    end_date = year + '/' + month + '/30'
                else:
                    end_date = year + '/' + month + '30'

            elif month == '2/' and int(year) % 4 != 0:
                end_date = year + '/' + month + '28'

            elif month == '2/' and int(year) % 4 == 0:
                end_date = year + '/' + month + '29'

            else:
                return None, None

        elif label == 'quarter':
            year = value[0:4]
            quarter = value[-2:]

            if quarter == 'Q1':
                start_date = year + '/' + '1/' + '1'
                end_date = year + '/' + '3/' + '31'
            elif quarter == 'Q2':
                start_date = year + '/' + '4/' + '1'
                end_date = year + '/' + '6/' + '30'
            elif quarter == 'Q3':
                start_date = year + '/' + '7/' + '1'
                end_date = year + '/' + '9/' + '30'
            elif quarter == 'Q4':
                start_date = year + '/' + '10/' + '1'
                end_date = year + '/' + '9/' + '31'
            else:
                return None, None

        elif label == 'year':
            year = str(value)
            start_date = year + '/' + '/1/1'
            end_date = year + '/' + '/12/31'

        return start_date, end_date
    else:
        date_1 = date(2016, 9, 15)
        date_2 = datetime.today().strftime('%Y-%m-%d')
        return date_1, date_2
