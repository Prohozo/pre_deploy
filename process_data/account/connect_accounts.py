import mysql.connector
from mysql.connector import Error
import pandas as pd
from process_data.account.connect import Connect_MySQL


class Data_Accounts(Connect_MySQL):

    def GET_ACCOUNTS(self, params):
        params = self.convert_params(params)
        proc_name = 'dsa_account'
        inputvals = '{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}, {8}, {9}, {10}, {11}, {12}, {13}, {14}, {15}, {16}' .format(
            *params)
        cursor = self.Call_Procedure(proc_name, inputvals)

        # OVERVIEW

        if params[0] == 'ov_account':
            cols = ["Tổng số lượng khách hàng"]
        elif params[0] == 'ov_potential':
            cols = ["Tổng số lượng cơ hội"]
        elif params[0] == 'ov_contact':
            cols = ["Tổng số lượng liên hệ"]
        elif params[0] == 'ov_salesorder':
            cols = ["Tổng số lượng đơn hàng"]

        # Bar chart
        elif params[0] == 'user_assign':
            cols = ["c.smownerid", "Nhân viên", "Số lượng khách hàng"]
        # elif params[0] == 'user_marketing':
        #     cols = ["Nhân viên","Số lượng khách hàng"]
        # elif params[0] == 'user_service':
        #     cols = ["Nhân viên","Số lượng khách hàng"]

        elif params[0] == 'bar_status':
            cols = ["Trạng thái", "Số lượng khách hàng"]
        elif params[0] == 'industry':
            cols = ["Lĩnh vực", "Số lượng khách hàng"]

        # Table
        elif params[0] == 'user_detail':
            cols = ["c.crmid", "c.label", "c.smownerid", "NV_assign"]
        elif params[0] == 'contact':
            cols = ["c.label", "contact"]
        elif params[0] == 'potential_salesorder':
            cols = ["c.label", "potential", "salesorder"]
        elif params[0] == 'revenue_employee':
            cols = ["c.label", "revenue", "employee"]
        elif params[0] == 'contact_leadsource':
            cols = ["c.label", "contact", "leadsource"]
        elif params[0] == 'account_detail':
            cols = ["c.crmid", "c.label", "a.industry", "ad.ship_city", "SL_contact", "SL_potential",
                    "SL_salesorder", "revenue", "employee", "c.createdtime", "c.modifiedtime"]
        elif params[0] == 'city':
            cols = ["ad.ship_city", "num_account"]

        elif params[0] == 'account_day':
            cols = ["day", "Số lượng khách hàng"]
        elif params[0] == 'account_month':
            cols = ["month", "Số lượng khách hàng"]
        elif params[0] == 'account_year':
            cols = ["year", "Số lượng khách hàng"]
        elif params[0] == 'account_quarter':
            cols = ["quarter", "Số lượng khách hàng"]
        return self.Convert_DataFrame(cursor, cols)

    def GET_DDL_ACCOUNTS(self, params):
        proc_name = 'dsa_account_ddl'
        params = self.convert_params(params)
        inputvals = '{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}' .format(*params)
        cursor = self.Call_Procedure(proc_name, inputvals)
        if (params[0] == 'ddl_account') or (params[0] == 'ddl_dept') or (params[0] == 'ddl_user_assign'):
            cols = ["id", "Tên"]
        else:
            cols = ["Tên"]
        return self.Convert_DataFrame(cursor, cols)
