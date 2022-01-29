import mysql.connector
from mysql.connector import Error
import pandas as pd
from process_data.user.connect import Connect_MySQL


class Data_User(Connect_MySQL):
    
    def GET_USER(self,params):
        params = self.convert_params(params)
        proc_name = 'dsa_user' 
        inputvals = '{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}, {8}, {9}, {10}, {11}' .format(*params)
        cursor = self.Call_Procedure(proc_name,inputvals)
        if params[0] == 'ov_NV':
            cols = ["Tổng số lượng nhân viên"]
        elif params[0] == 'ov_taskopened':
            cols = ["Tổng số lượng task"]
        elif params[0] == 'ov_taskdone':
            cols = ["Tổng số lượng task hoàn thành"]
        elif params[0] == 'bar_taskopened':
            cols = ["account_nv","Nhân viên","Số lượng Task"]
        elif params[0] == 'bar_taskdone':
            cols = ["account_nv","Nhân viên","Số lượng Task"]
        elif params[0] == 'pie_taskdone':
            cols = ["Trạng thái","Số lượng Task"]
        elif params[0] == 'line_taskopened':
            cols = ["Thời gian","Số lượng Task"]
        elif params[0] == 'line_taskdone':
            cols = ["Thời gian","Số lượng Task"]  
        elif params[0] == 'bar_project':
            cols = ["account_nv","Số lượng project"]
        elif params[0] == 'table_project':
            cols = ["u.account","Project"]
        elif params[0] == 'line_productivity':
            cols = ["Thời gian","Năng suất"]
        elif params[0] == 'ov_taskdone_percentage':
            cols = ["Độ hoàn thành của task đã tạo (%)"]
        elif params [0] == 'ov_taskdone_byopenedby':
            cols = ["Số lượng task hoàn thành bởi nhân viên đã tạo"]
        elif params [0] == 'ov_taskdone_byothers':
            cols = ["Số lượng task đã tạo hoàn thành bởi nhân viên khác"] 
        elif params [0] == 'user_0_task':
            cols = ["u.account","Thời gian"]  
        elif params [0] == 'bar_taskstarted':
            cols = ["account_nv","Nhân viên","Số lượng Task"]
        elif params [0] == 'user_0_login':
            cols = ["u.account"]         
        elif params [0] == 'table_project_task':
            cols = ["u.account","project"]   
        elif params[0] == 'bar_project_task':
            cols = ["account_nv","status_project","num_project"]
        elif params[0] == 'table_user_workload':
            cols =["u.account","num_task_left","num_est"]
        return self.Convert_DataFrame(cursor,cols)
    
    
    def GET_DDL_USER(self, params):
        proc_name = 'dsa_user_ddl'
        inputvals = '{0}, {1}, {2}, {3}' .format(*params)
        cursor = self.Call_Procedure(proc_name,inputvals)
        if (params[0] == 'ddl_project') or (params[0] == 'ddl_user') or (params[0] == 'ddl_dept'):
            cols = ["id", "Tên"]
        else:
            cols = ["Tên"]
        return self.Convert_DataFrame(cursor, cols)

    