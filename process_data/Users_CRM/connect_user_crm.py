import mysql.connector
from mysql.connector import Error
import pandas as pd
from process_data.Users_CRM.connect import Connect_MySQL


class Data_Users_CRM(Connect_MySQL):
    
    def GET_USERSCRM(self,params):
        params = self.convert_params(params)
        proc_name = 'dsa_user_all' 
        inputvals = '{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}' .format(*params)
        cursor = self.Call_Procedure(proc_name,inputvals)

        #OVERVIEW
        if params[0] == 'ov_user':
            cols = ["Tổng số lượng nhân viên"]
        elif params[0] == 'ov_activity':
            cols = ["Tổng số lượng hoạt động"]
        elif params[0] == 'ov_salesorder':
            cols = ["Tổng số lượng đơn hàng"]
        elif params[0] == 'ov_task_created':
            cols = ["Tổng số lượng task"]
        elif params[0] == 'ov_task_finished':
            cols = ["Tổng số lượng task hoàn thành"]
        elif params[0] == 'ov_task_delay':
            cols = ["Tổng số lượng task delay"]
        #Bar chart
        elif params[0] == 'user_salesorder':
            cols = ["c.smownerid","Nhân viên","Số lượng đơn hàng"]
        elif params[0] == 'user_task_created':
            cols = ["c.smownerid","Nhân viên","Số lượng task"]
        elif params[0] == 'user_task_finished':
            cols = ["c.smownerid","Nhân viên","Số lượng task"]


        #Table
        elif params[0] == 'activity_detail':
            cols = ["c.crmid","c.label","u.user_name","a.activitytype","a.status","DATE(c.createdtime)","a.date_start","a.due_date","DATE(c.modifiedtime)","c2.crmid","c2.label"]
        elif params[0] == 'without_activity':
            cols = ["u.user_name","date"]
        elif params[0] == 'task_delay_detail':
            cols = ["c.crmid","c.label","u.user_name","a.status","delay_days"]
        elif params[0] == 'without_login':
            cols = ["u.user_name"]
            
        #Line chart
        elif params [0] == 'user_activity_day':
            cols = ["day","Số lượng hoạt động"]
        elif params [0] == 'user_activity_month':
            cols = ["month","Số lượng hoạt động"]
        elif params [0] == 'user_activity_year':
            cols = ["year","Số lượng hoạt động"]
        elif params [0] == 'user_activity_quarter':
            cols = ["quarter","Số lượng hoạt động"]
        elif params [0] == 'user_productivity':
            cols = ["date","Năng suất"] 
        return self.Convert_DataFrame(cursor,cols)
    
    
    def GET_DDL_USERSCRM(self, params):
        proc_name = 'dsa_user_ddl_all'
        params = self.convert_params(params)
        inputvals = '{0}, {1}, {2}, {3}' .format(*params)
        cursor = self.Call_Procedure(proc_name,inputvals)
        if (params [0] == 'ddl_account') or (params [0] == 'ddl_dept') or (params [0] == 'ddl_user_assign'):
            cols = ["id", "Tên"]
        else:
            cols = ["Tên"]
        return self.Convert_DataFrame(cursor, cols)
    