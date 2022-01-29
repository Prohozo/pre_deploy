from flask_security.views import login_required
from functools import wraps
from flask_security import current_user
from flask import url_for, redirect
from flask_principal import Permission, RoleNeed

import random
import string
from controller.task import get_params as get_params_task
from controller.task import graph as graph_task
from controller.user import get_params as get_params_user
from controller.user import graph as graph_user
from controller.Project import graph, get_params as gp, gp_custom as gp_custom, gp_custom_getTime as gp_custom_time

from controller.account import graph as graph_account
from controller.account import get_params as gp_account 
from controller.lead import graph as graph_lead
from controller.lead import get_params as gp_lead 
from controller.potential import get_params as get_params_potential
from controller.potential import graph as graph_potential
from controller.Users_CRM import graph as graph_usersCRM
from controller.Users_CRM import get_params as gp_usersCRM
from controller.Support import graph as graph_Support
from controller.Support import get_params as gp_Support

GParams_PJ_Multile_getTime = gp_custom_time.Get_Params()
GParams_Task = get_params_task.Get_Params()
Graph_Task = graph_task.gen_graph()
GParams_User = get_params_user.Get_Params()
Graph_User = graph_user.gen_graph()
Graph = graph.gen_graph()
GParams_PJ = gp.Get_Params()
GParams_PJ_Multile = gp_custom.Params_project()

Graph_Accounts = graph_account.gen_graph()
GParams_Accounts = gp_account.Get_Params()
Graph_Lead = graph_lead.gen_graph()
GParams_Lead = gp_lead.Get_Params()
GParams_Potential = get_params_potential.Get_Params()
Graph_Potential = graph_potential.gen_graph()
Graph_UsersCRM = graph_usersCRM.gen_graph()
GParams_UsersCRM = gp_usersCRM.Get_Params()
Graph_Support = graph_Support.gen_graph()
GParams_Support = gp_Support.Get_Params()


# Check to change password next
def change_pwd_next(func):
    @wraps(func)
    def wrapper_change_pwd(*args, **kwargs):
        if current_user.is_authenticated:
            if current_user.change_pwd:
                return redirect('/change_pwd/')
        return func(*args, **kwargs)
    return wrapper_change_pwd

def roles_accepted(*roles):
    perm = Permission(*[RoleNeed(role) for role in roles])
    if perm.can():
        return True
    return False

def lock_dashboard(func, *roles):
    @wraps(func)
    def wrapper_lock_view(*args, **kwargs):
        if current_user.is_authenticated:
            if roles_accepted(*roles):
                return func(*args, **kwargs)
            else:
                return redirect(url_for('load_home'))
        return redirect(url_for('security.login'))
    return wrapper_lock_view

# Lock url dashboard
def protect_views(app, *roles):
    for view_func in app.server.view_functions:
        if view_func.startswith(app.config.url_base_pathname):
            app.server.view_functions[view_func] = change_pwd_next(app.server.view_functions[view_func])
            app.server.view_functions[view_func] = lock_dashboard(app.server.view_functions[view_func], *roles)
    
    return app

def get_random_string(length):
    letters = string.ascii_lowercase
    result_str = ''.join(random.choice(letters) for i in range(length))
    return result_str

'''  '''
dashboard_name = {'Projects': 'Dashboard Projects',
          'Task': 'Dashboard Task',
          'User': 'Dashboard User',
          'Accounts': 'Dashboard Accounts',
          'Lead': 'Dashboard Lead',
          'Potential': 'Dashboard Potential',
          'UserCRM': 'Dashboard UserCRM',
          'Support':'Dashboard Support'
          }