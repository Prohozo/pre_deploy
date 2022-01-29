from flask_security import current_user
from utils import roles_accepted, dashboard_name

def item_menu():
    item_1_level =  '''
            <li class="nav-item">
                <a id='{0}' href="/{0}/" class="nav-link js-arrow">
                    <i class="nav-icon fas fa-{1}"></i>
                    <p class="menu_content">{2}</p>
                </a>
            </li>
            '''
    
    item_multi_level_PMS =  '''
            <li id='PMS_d' class="nav-item has-treeview">
                <a id='PMS' href="#" class="nav-link js-arrow">
                    <i class="fas fa-people-arrows"></i>
                    <p>PMS</p>
                    <i id="arrow__" class="right fas fa-angle-left arr" style="visibility: visible;"></i>
                </a>

                <ul class="nav nav-treeview">
                    

                    
            '''
    item_multi_level_CRM =  '''
            <li id='CRM_d' class="nav-item has-treeview">
                <a id='CRM' href="#" class="nav-link js-arrow">
                    <i class="fas fa-check-double"></i>
                    <p>CRM</p>
                    <i id="arrow_" class="right fas fa-angle-left arr" style="visibility: visible;"></i>
                </a>

                <ul class="nav nav-treeview">
                    

                    
            '''    
    end =   '''
                </ul>
            </li>
            '''

    role_admin = 'Quản trị hệ thống'
    menu = ""

    if roles_accepted(role_admin, dashboard_name['Projects']):
        item_multi_level_PMS += item_1_level.format('Projects', 'analytics', 'Projects')
    if roles_accepted(role_admin, dashboard_name['Task']):
        item_multi_level_PMS += item_1_level.format('Task', 'chart-line', 'Task')
    if roles_accepted(role_admin, dashboard_name['User']):
        item_multi_level_PMS += item_1_level.format('User', 'user', 'User')
    if roles_accepted(role_admin, dashboard_name['Lead']):
        item_multi_level_CRM += item_1_level.format('Lead', 'handshake-alt', 'Tiềm năng')    
    if roles_accepted(role_admin, dashboard_name['Accounts']):
        item_multi_level_CRM += item_1_level.format('Accounts', 'hand-holding-usd', 'Khách hàng') 
    if roles_accepted(role_admin, dashboard_name['Potential']):
        item_multi_level_CRM += item_1_level.format('Potential', 'star', 'Cơ hội')   
    if roles_accepted(role_admin, dashboard_name['UserCRM']):
        item_multi_level_CRM += item_1_level.format('UserCRM', 'users', 'User CRM') 
    if roles_accepted(role_admin, dashboard_name['Support']):
        item_multi_level_CRM += item_1_level.format('Support', 'ticket-alt', 'Hỗ Trợ') 

    item_multi_level_PMS += end
    item_multi_level_CRM += end

    menu += item_multi_level_PMS
    menu += item_multi_level_CRM

    if roles_accepted(role_admin):
        menu += item_1_level.format('admin', 'cog', 'Quản trị hệ thống')
    
    return menu