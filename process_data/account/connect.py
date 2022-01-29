import mysql.connector
import pandas as pd


class Connect_MySQL:

    def __init__(self, host, database, uid, pwd):
        '''Khởi tạo các tham số cần thiết để kết nối database'''
        self.user = uid
        self.password = pwd
        self.host = host
        self.database = database

    def convert_params(self, params):
        r = []
        for val in params:
            r.append(None) if val is None else r.append(""+str(val)+"")
        return r

    def Convert_params_mysql(self, params):
        r = []
        for val in params:
            r.append(None) if val == 'None' else r.append(""+str(val)+"")
        return r

    def Call_Procedure(self, proc, params):
        '''Kết nối đến CSDL và thực thi Procedure'''

        conn = mysql.connector.connect(
            host=self.host, user=self.user, password=self.password, database=self.database)
        cursor = conn.cursor()
        params_split = params.split(', ')
        params_proc = self.Convert_params_mysql(params_split)
        cursor.callproc(proc, params_proc)
        return cursor

    def Convert_DataFrame(self, cursor, cols):
        '''Chuyển đổi dữ liệu lấy được về dạng DataFrame'''
        for result in cursor.stored_results():
            results = result.fetchall()
        df = pd.DataFrame.from_records(results, columns=cols)
        return df
