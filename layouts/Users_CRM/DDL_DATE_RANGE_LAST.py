from datetime import date, timedelta, datetime

def last_time(date_value):
    # Ngày hôm qua
    if date_value == 0:
        date_1 = (date.today() - timedelta(days=2)).strftime("%Y-%m-%d")
        date_2 = date_1
        return date_1, date_2
    # Ngày hôm nay
    elif date_value == 1:
        date_1 = (date.today() - timedelta(days=1)).strftime("%Y-%m-%d")
        date_2 = date_1
        return date_1, date_2
    # Tuần trước
    elif date_value == 2:
        date_ = date.today()
        while(date_.weekday()!=6):
            date_ -= timedelta(days=1)
        return (date_-timedelta(13)).strftime("%Y-%m-%d"), (date_- timedelta(7)).strftime("%Y-%m-%d")
    # Tuần hiện tại
    elif date_value == 3:
        date_1 = date.today()
        date_2 = date.today()
        while(date_2.weekday() != 6):
            date_2 += timedelta(days=1)
        while(date_1.weekday() != 0):
            date_1 -= timedelta(days=1)
        return (date_1-timedelta(7)).strftime("%Y-%m-%d"), (date_2-timedelta(7)).strftime("%Y-%m-%d")
    # Năm trước
    elif date_value == 4:
        year = str(date.today().year - 2)
        date_1 = datetime.strptime(year+'-1-1', "%Y-%m-%d").strftime("%Y-%m-%d")
        date_2 = datetime.strptime(year+'-12-31', "%Y-%m-%d").strftime("%Y-%m-%d")
        return date_1, date_2
    # Năm hiện tại
    elif date_value == 5:
        year = str(date.today().year -1)
        date_1 = datetime.strptime(year+'-1-1', "%Y-%m-%d").strftime("%Y-%m-%d")
        date_2 = datetime.strptime(year+'-12-31', "%Y-%m-%d").strftime("%Y-%m-%d")
        return date_1, date_2
    # Quý trước
    elif date_value == 6:
        month = str(date.today().month)
        year = date.today().year
        if month in ['1','2','3']:
            date_1 = datetime.strptime(str(year-1)+'-7-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(str(year-1)+'-9-30', "%Y-%m-%d").strftime("%Y-%m-%d")
        elif month in ['4', '5', '6']:
            date_1 = datetime.strptime(str(year-1)+'-10-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(str(year-1)+'-12-31', "%Y-%m-%d").strftime("%Y-%m-%d")
        elif month in ['7', '8', '9']:
            date_1 = datetime.strptime(str(year)+'-1-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(str(year)+'-3-31', "%Y-%m-%d").strftime("%Y-%m-%d")
        elif month in ['10', '11', '12']:
            date_1 = datetime.strptime(str(year)+'-4-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(str(year)+'-6-30', "%Y-%m-%d").strftime("%Y-%m-%d")
        return date_1, date_2
    # Quý hiện tại
    elif date_value == 7:
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
    # Tháng trước
    elif date_value == 8:
        month = date.today().month - 2
        year = date.today().year
        if month == 2 and year % 4 == 0:
            date_1 = datetime.strptime(str(year)+'-2-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(str(year)+'-2-29', "%Y-%m-%d").strftime("%Y-%m-%d")
        elif month == 0:
            date_1 = datetime.strptime(str(year-1)+'-12-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(str(year-1)+'-12-31', "%Y-%m-%d").strftime("%Y-%m-%d")
        elif month == -1:
            date_1 = datetime.strptime(str(year-1)+'-11-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(str(year-1)+'-11-30', "%Y-%m-%d").strftime("%Y-%m-%d")
        elif month == 2:
            date_1 = datetime.strptime(str(year-1)+'-2-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(str(year-1)+'-2-28', "%Y-%m-%d").strftime("%Y-%m-%d")
        elif month in [1,3,5,7,8,10]:
            date_1 = datetime.strptime(str(year)+'-'+str(month)+'-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(str(year)+'-'+str(month)+'-31', "%Y-%m-%d").strftime("%Y-%m-%d")
        elif month in [4, 6, 9]:
            date_1 = datetime.strptime(str(year)+'-'+str(month)+'-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(str(year)+'-'+str(month)+'-30', "%Y-%m-%d").strftime("%Y-%m-%d")
        return date_1, date_2
    # Tháng hiện tại
    elif date_value == 9:
        month = date.today().month - 1
        year = date.today().year
        if month == 2 and year % 4 == 0:
            date_1 = datetime.strptime(str(year)+'-2-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(str(year)+'-2-29', "%Y-%m-%d").strftime("%Y-%m-%d")
        elif month == 2:
            date_1 = datetime.strptime(str(year)+'-2-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(str(year)+'-2-28', "%Y-%m-%d").strftime("%Y-%m-%d")
        elif month == 0:
            date_1 = datetime.strptime(str(year-1)+'-12-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(str(year-1)+'-12-31', "%Y-%m-%d").strftime("%Y-%m-%d")
        elif month in [1,3,5,7,8,10]:
            date_1 = datetime.strptime(str(year)+'-'+str(month)+'-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(str(year)+'-'+str(month)+'-31', "%Y-%m-%d").strftime("%Y-%m-%d")
        elif month in [4, 6, 9, 11]:
            date_1 = datetime.strptime(str(year)+'-'+str(month)+'-1', "%Y-%m-%d").strftime("%Y-%m-%d")
            date_2 = datetime.strptime(str(year)+'-'+str(month)+'-30', "%Y-%m-%d").strftime("%Y-%m-%d")
        return date_1, date_2
    else:
        return None, None
