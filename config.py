SECRET_KEY = 'SUPER_KEY_DSA_425'

# SQLALCHEMY_DATABASE_URI = "mssql+pyodbc://sa:NpatDN#72@localhost/Permission?driver=ODBC+Driver+17+for+SQL+Server"
SQLALCHEMY_TRACK_MODIFICATIONS = False
''' Change server contain database Permission: '''
# SQLALCHEMY_DATABASE_URI = "mysql://root:Fast@2019!)@127.0.0.1/Permission"
SQLALCHEMY_DATABASE_URI = "mysql://root:Bk_0935760385@localhost/permission"

SECURITY_URL_PREFIX = "/"
SECURITY_PASSWORD_HASH = "pbkdf2_sha512"
SECURITY_PASSWORD_SALT = "AKEHOIWDSAIqwoirwqpoqiroqpiroq"

SECURITY_LOGIN_URL = "/login/"
SECURITY_LOGOUT_URL = "/logout/"

SECURITY_POST_LOGIN_VIEW = "/home"
SECURITY_POST_LOGOUT_VIEW = "/login"

SECURITY_MSG_INVALID_PASSWORD = (
    ('Tài khoản hoặc mật khẩu không chính xác.'), 'error')
SECURITY_MSG_USER_DOES_NOT_EXIST = (
    ('Tài khoản hoặc mật khẩu không chính xác.'), 'error')


Bar_Chart = {
    # UserPMS
    'grh_bar_taskopened': "u.account",
    'grh_bar_taskdone': "u.account",
    'grh_bar_project': "u.account",
    'grh_bar_taskstarted': "u.account",

    # Project
    'grh_TL_DA_dept': 'dept',

    # Task
    'bar_taskopened': 't.openedBy',
    'bar_taskdone': 't.finishedBy',
    'num_task_bydept': 't.finishedBy',

    # Account
    'grh_bar_status': "acf.status",
    'grh_bar_user_assign': "c.smownerid",
    'grh_bar_user_marketing': "acf.user_marketing",
    'grh_bar_user_service': "acf.user_service",

    # lead
    'num_lead_bysource': 'ld.leadsource',
    'num_lead_bystatus': 'ld.leadstatus',
    'num_lead_byuser': 'u.user_name',

    # potential
    'num_potential_byuser': 'u.user_name',
    'potential_by_user_assign': 'u.user_name',
    'potential_by_user_status_assign':  'u.user_name',
    'potential_by_user_mkt': 'pcf.cf_985',
    'potential_by_user_status_mkt': 'pcf.cf_985',
    'potential_by_user_service': 'pcf.cf_901',
    'potential_by_user_status_service': 'pcf.cf_901',
    'num_potential_bysalestage': 'p.sales_stage',

    # UserCRM
    'grh_bar_task_created': 'u.user_name',
    'grh_bar_task_finished': 'u.user_name',

    # support
    'num_support_bystatus': 't.status',
    'grh_bar_project_task': 'u.account'}

Pie_Charts = {
    # UserPMS
    'grh_pie_taskdone': "t.TT_MORONG",

    # Task
    'task_num_pri': 't.pri',

    # Project
    'grh_status_duan_tron': 'LoaiHinh',
    'grh_action_duan_tron': 'action',

    # Support
    'num_Support_bypri': 't.priority',
    'num_Support_bylocation': 'tcf.cf_893'}

Datatable = {
    # Task
    'detail_task_delay': {'p.name': 'p.name', 't.name': 't.name', 't.assignedTo': 't.assignedTo', 't.status': 't.status'},
    'detail_task_byproject': {'p.name': 'p.name'},
    'detail_task_bystory': {'s.title': 's.title'},

    # Project
    'detail_chitiet_duan': {'name': 'name'}, 'detail_chitiet_trangthai': {'name': 'name', 'LoaiHinh': 'LoaiHinh'}, 'detail_mucdott_duan': {'name': 'name', 'LoaiHinh': 'LoaiHinh'},
    'detail_PROJECT': {'u.account': 'u.account'},
    'detail_mucdott_duan': {'name': 'name', 'LoaiHinh': 'LoaiHinh'},
    'SoDuAn_dept': {'dept': 'dept'},
    'detail_tiendo_duan': {'name': 'name'},

    # UserPMS
    'user_0_task': {'u.account': 'u.account'},
    'user_0_login': {'u.account': 'u.account'},
    'detail_project_task': {'u.account': 'u.account'},
    'detail_user_workload': {'u.account': 'u.account'},


    # Account
    'user_detail': {'c.label': 'c.crmid', 'NV_assign': 'c.smownerid', 'acf.user_marketing': 'acf.user_marketing', 'acf.user_service': 'acf.user_service'},
    'account_detail': {'c.label': 'c.crmid', 'a.industry': 'a.industry', 'acf.status': 'acf.status', 'ad.ship_city': 'ad.ship_city'},
    'city': {'ad.ship_city': 'ad.ship_city'},

    # Lead
    'detail_lead_bycity': {'la.city': 'la.city'},
    'lead_detail': {'ld.company': 'ld.company', 'u.user_name': 'u.user_name', 'ld.leadsource': 'ld.leadsource', 'ld.leadstatus': 'ld.leadstatus', 'ld.industry': 'ld.industry', 'la.city': 'la.city'},

    # Potential
    'detail_potential_delay': {'p.potentialname': 'p.potentialname', 'u.user_name': 'u.user_name', 'p.sales_stage': 'p.sales_stage'},
    'detail_potential_delay_2': {'p.potentialname': 'p.potentialname', 'u.user_name': 'u.user_name', 'p.sales_stage': 'p.sales_stage'},
    'detail_potential': {'p.potentialname': 'p.potentialname', 'p.sales_stage': 'p.sales_stage', 'u.user_name': 'u.user_name', 'pcf.cf_901': 'pcf.cf_901', 'pcf.cf_985': 'pcf.cf_985', 'pcf.cf_987': 'pcf.cf_987'},
    'num_potential_byproduct': {'pr.productname': 'pr.productname'},
    'comment_detail': {'u.user_name': 'u.user_name'},
    'activity_detail': {'u.user_name': 'u.user_name'},

    # UserCRM
    'user_without_activity': {'u.user_name': 'u.user_name'},
    'user_task_delay': {'c.label': 'c.crmid', 'u.user_name': 'u.user_name', 'a.status': 'a.status'},
    'user_activity_detail': {'c.label': 'c.crmid', 'u.user_name': 'u.user_name', 'a.status': 'a.status', 'c2.label': 'c2.label'},
    'user_without_login': {'u.user_name': 'u.user_name'},

    # Suport
    'detail_Support_delay': {'c2.label': 'c2.crmid', 'u.user_name': 'u.user_name', 'a.cf_891': 'a.cf_891'},
    'detail_Support': {'c.label': 't.ticketid', 'u.user_name': 'u.user_name', 't.status': 't.status', 't.priority': 't.priority', 'c2.label': 'c2.crmid'},

}

Line_Chart = {
    # task
    'task_hour_by_time_date': 'date',
    'task_hour_by_time_month': 'month',
    'task_hour_by_time_quarter': 'quarter',
    'task_hour_by_time_year': 'year',
    'task_est_hour_by_time_date': 'date',
    'task_est_hour_by_time_month': 'month',
    'task_est_hour_by_time_quarter': 'quarter',
    'task_est_hour_by_time_year': 'year',
    'task_by_time_date': 'date',
    'task_by_time_month': 'month',
    'task_by_time_year': 'year',

    # account
    'grh_parento_industry': "a.industry",
    'account_day': "day",
    'account_month': "month",
    'account_year': "year",
    'account_quarter': "quarter",

    # lead
    'num_lead_byindustry': 'ld.industry',
    'lead_by_time_date': 'date',
    'lead_by_time_month': 'month',
    'lead_by_time_year': 'year',
    'lead_by_time_quarter': 'quarter',

    # potential
    'potential_by_time_date': 'date',
    'potential_by_time_month': 'month',
    'potential_by_time_quarter': 'quarter',
    'potential_by_time_year': 'year',
    'num_potential_byindustry': 'ld.industry',

    # userCRM
    'grh_parento_salesorder': 'u.user_name',

    # support
    'support_by_time_date': 'date',
    'support_by_time_month': 'month',
    'support_by_time_quarter': 'quarter',
    'support_by_time_year': 'year',
    'num_support_byuser': 'u.user_name', }

MultiLine_Chart = {
    # Project
    'grh_DTDV_THOIGIAN': 'ma_dvcs',
    'grh_CHIPHI_THOIGIAN': 'LOAI',
    'grh_action_TG_month': 'action',
    'grh_action_TG_day': 'action',
    'grh_action_TG_year': 'action'
}

Map = {
    # Account
    'grh_map_city': "ad.ship_city",

    # Lead
    'map_lead_bycity': 'la.city'
}


LOAI_DT = {'Doanh thu cung cấp dịch vụ- sửa chữa': 'Cung cấp dv - sửa chữa',
           'Doanh thu bán hàng hóa- phụ tùng, phụ kiện honda': 'BH - PT, PK honda',
           'Doanh thu bán hàng hóa- phụ tùng, phụ kiện ngoài': 'BH - PT, PK ngoài',
           'Doanh thu cung cấp dịch vụ- Hoa hồng TC': 'Cung cấp dv - Hoa hồng TC',
           'Doanh thu cung cấp dịch vụ- Khác': 'Cung cấp dv - Khác',
           'Doanh thu cung cấp dịch vụ- KP +BĐ': 'Cung cấp dv - KP +BĐ',
           'Doanh thu bán hàng hóa- khác': 'Bán hàng hóa- khác'}
