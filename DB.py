from process_data.task.connect_task import Data_Task
from process_data.user.connect_Users import Data_User
from process_data.project.connect_PJ import Data_DuAn
from process_data.lead.connect_lead import Data_Lead
from process_data.account.connect_accounts import Data_Accounts
from process_data.potential.connect_potential import Data_Potential
from process_data.Users_CRM.connect_user_crm import Data_Users_CRM
from process_data.Support.connect_Support import Data_Support

# host = '127.0.0.1'
# db_name = 'fpms'
# uid = 'root'
# pwd = 'Fast@2019!)'

# db_name_CRM = 'fcrm20'

host = 'localhost'
db_name = 'fpms'
uid = 'root'
pwd = 'Bk_0935760385'

db_name_CRM = 'crm'

DB_Task = Data_Task(host, db_name, uid, pwd)
DB_User = Data_User(host, db_name, uid, pwd)
DB_DuAn = Data_DuAn(host, db_name, uid, pwd)


DB_Lead = Data_Lead(host, db_name_CRM, uid, pwd)
DB_Accounts = Data_Accounts(host, db_name_CRM, uid, pwd)
DB_potential = Data_Potential(host, db_name_CRM, uid, pwd)
DB_Users_CRM = Data_Users_CRM(host, db_name_CRM, uid, pwd)
DB_Support = Data_Support(host, db_name_CRM, uid, pwd)
