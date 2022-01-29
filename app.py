from flask import Flask, redirect
from flask_sqlalchemy import SQLAlchemy
from dash import Dash
import random
import string
from utils import protect_views, dashboard_name
from dash import html

''' Change dir path: '''
server = Flask(
    __name__, instance_path='/mnt/e/Project/Permission_Material_Frame/protected')
server.config.from_pyfile('config.py')

db = SQLAlchemy(server)

# app_Task = Dash(
#     __name__,
#     server=server,
#     url_base_pathname='/Task/',
#     suppress_callback_exceptions=True
# )

# app_User = Dash(
#     __name__,
#     server=server,
#     url_base_pathname='/User/',
#     suppress_callback_exceptions=True
# )

# app_DuAn = Dash(
#     __name__,
#     server=server,
#     url_base_pathname='/Projects/',
#     suppress_callback_exceptions=True
# )

app_Accounts = Dash(
    __name__,
    server=server,
    url_base_pathname='/Accounts/',
    suppress_callback_exceptions=True
)
app_Lead = Dash(
    __name__,
    server=server,
    url_base_pathname='/Lead/',
    suppress_callback_exceptions=True
)

app_Potential = Dash(
    __name__,
    server=server,
    url_base_pathname='/Potential/',
    suppress_callback_exceptions=True
)

# app_UsersCRM = Dash(
#     __name__,
#     server=server,
#     url_base_pathname='/UserCRM/',
#     suppress_callback_exceptions=True
# )
app_Support = Dash(
    __name__,
    server=server,
    url_base_pathname='/Support/',
    suppress_callback_exceptions=True
)
''' Lock link dash: '''
# app_Task = protect_views(app_Task, 'Task', dashboard_name['Task'])
# app_User = protect_views(app_User, 'User', dashboard_name['User'])
# app_DuAn = protect_views(app_DuAn, 'Quản trị hệ thống',
#                          dashboard_name['Projects'])
# app_Accounts = protect_views(
#     app_Accounts, 'Khách hàng', dashboard_name['Accounts'])
# app_Lead = protect_views(app_Lead, 'Tiềm năng', dashboard_name['Lead'])
# app_Potential = protect_views(
#     app_Potential, 'Cơ hội', dashboard_name['Potential'])
# app_UsersCRM = protect_views(
#     app_UsersCRM, 'User CRM', dashboard_name['UserCRM'])
# app_Support = protect_views(app_Support, 'Hỗ trợ', dashboard_name['Support'])
