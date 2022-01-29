from process_data.project.connect import Connect_SQLServer
# import pymssql
import pandas as pd

class Data_DuAn(Connect_SQLServer):

    def __init__(self, host, database, uid, pw):
        super().__init__(host, database, uid, pw)
        self.ACTION = { 'grh_action_TG_year': [],
                        'grh_action_TG_month': [],
                        'grh_action_TG_day': [],}

    def GET_DDL(self, params):
        '''Lấy dữ liệu ddl tên project'''

        params = self.convert_params(params)
        proc = "Call dsa_sp_ddl_project ({0})".format(*params)
        
        cursor = self.Call_Procedure(proc)
        if params[0] == "'ddl_name'":
            cols = ['id','name']
        else:
            cols = ['action']
        return self.Convert_DataFrame(cursor, cols)

    def GET_overview_DuAN(self, params):
        '''Lấy dữ liệu tổng số dự án'''

        params = self.convert_params(params)
        proc = "Call dsa_sp_overview_DuAn ({0},{1},{2},{3})".format(*params) 
        print(proc)
        cursor = self.Call_Procedure(proc)
        cols = ['value']
        return self.Convert_DataFrame(cursor, cols)

    def GET_status_duan_tron(self, params):
        '''Lấy dữ liệu tỷ lệ trạng thái dự án'''

        params = self.convert_params(params)
        proc = "Call dsa_sp_status_DuAn_tron ({0}, {1}, {2},{3})".format(*params)
        cursor = self.Call_Procedure(proc)
        cols = ['LoaiHinh','tong']
        return self.Convert_DataFrame(cursor, cols)

    def GET_detail_duan_bang(self, params):
        '''Lấy dữ liệu detail dự án'''

        params = self.convert_params(params)
        proc = "Call dsa_sp_detail_DuAn_Bang ({0}, {1}, {2},{3})".format(*params)
        cursor = self.Call_Procedure(proc)
        cols = ['name','tt_date','story_num', 'LoaiHinh']
        data = self.Convert_DataFrame(cursor, cols)
        return data

    def GET_tt_duan_bang(self, params):
        '''Lấy dữ liệu detail dự án'''

        params = self.convert_params(params)
        proc = "Call dsa_sp_status_MucdoTT_DuAn_BANG ({0}, {1}, {2},{3})".format(*params)
        cursor = self.Call_Procedure(proc)
        cols = ['name','tt_date','LoaiHinh']
        data = self.Convert_DataFrame(cursor, cols)
        return data

    def GET_action_duan_tron(self, params):
        '''Lấy dữ liệu tỷ lệ action dự án'''

        params = self.convert_params(params)
        proc = "Call dsa_sp_action_tron ({0}, {1}, {2})".format(*params)
        cursor = self.Call_Procedure(proc)
        cols = ['action','Soluot']
        return self.Convert_DataFrame(cursor, cols)

    def GET_detail_trangthai_bang(self, params):
        '''Lấy dữ liệu detail trạng thái dự án'''

        params = self.convert_params(params)
        proc = "Call dsa_sp_ThongKe_DuAn_BANG ({0}, {1}, {2}, {3})".format(*params)
        print(proc)
        cursor = self.Call_Procedure(proc)
        cols = ['name','LoaiHinh', 'SoNgay','SoNguoi','SoTask']
        data = self.Convert_DataFrame(cursor, cols)
        return data

    def GET_overview_DuAN_doing(self, params):
        '''Lấy dữ liệu tổng số dự án doing'''

        params = self.convert_params(params)
        proc = "Call dsa_sp_overview_DuAn_doing ({0},{1},{2},{3})".format(*params) 
        cursor = self.Call_Procedure(proc)
        cols = ['value']
        return self.Convert_DataFrame(cursor, cols)

    def GET_overview_DuAN_wait(self, params):
        '''Lấy dữ liệu tổng số dự án wait'''

        params = self.convert_params(params)
        proc = "Call dsa_sp_overview_DuAn_wait ({0},{1},{2},{3})".format(*params) 
        cursor = self.Call_Procedure(proc)
        cols = ['value']
        return self.Convert_DataFrame(cursor, cols)

    def GET_overview_DuAN_suspended(self, params):
        '''Lấy dữ liệu tổng số dự án suspended '''

        params = self.convert_params(params)
        proc = "Call dsa_sp_overview_DuAn_suspended ({0},{1},{2},{3})".format(*params) 
        cursor = self.Call_Procedure(proc)
        cols = ['value']
        return self.Convert_DataFrame(cursor, cols)
    
    def GET_DDL_dept(self, params):
        '''Lấy dữ liệu ddl tên bộ phận'''

        params = self.convert_params(params)
        proc = "Call dsa_sp_ddl_dept ({0})".format(*params)
        
        cursor = self.Call_Procedure(proc)
        cols = ['id','name']
        return self.Convert_DataFrame(cursor, cols)

    def GET_DuAn_dept_bang(self, params):
        '''Lấy dữ liệu dự án theo bộ phận'''

        params = self.convert_params(params)
        proc = "Call dsa_sp_SoDuAn_dept ({0}, {1}, {2},{3})".format(*params)
        cursor = self.Call_Procedure(proc)
        cols = ['dept','SoDA']
        data = self.Convert_DataFrame(cursor, cols)
        return data

    def GET_TL_DA_dept(self, params):
        '''Lấy dữ liệu tỷ lệ dự án theo bộ phận'''

        params = self.convert_params(params)
        proc = "Call dsa_sp_TL_DuAn_dept ({0}, {1}, {2}, {3})".format(*params)
        cursor = self.Call_Procedure(proc)
        cols = ['TiLe','dept','text_tile']
        data = self.Convert_DataFrame(cursor, cols)
        return data

    def GET_Tiendo_duan_bang(self, params):
        '''Lấy dữ liệu detail dự án'''

        params = self.convert_params(params)
        proc = "Call dsa_sp_Tiendo_duan ({0}, {1}, {2},{3})".format(*params)
        cursor = self.Call_Procedure(proc)
        cols = ['name','left','cost', 'Progress']
        data = self.Convert_DataFrame(cursor, cols)
        return data

    def GET_countAction_multiline(self, params):
        '''Lấy dữ liệu multile hành động'''

        params = self.convert_params(params)
        proc = "Call dsa_sp_action_multiline ({0}, {1}, {2}, {3}, {4}, {5}, {6})".format(*params)
        print(proc)
        cursor = self.Call_Procedure(proc)
        cols = ['count','action','time']
        data = self.Convert_DataFrame(cursor, cols)
        return data