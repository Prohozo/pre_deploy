import pymysql
import pandas as pd
from datetime import datetime as dt

class Connect_SQLServer:

    def __init__(self, host, database, uid, pw):
        self.uid = uid
        self.pw = pw
        self.host = host
        self.database = database

    def Call_Procedure(self, proc):
        '''Kết nối đến CSDL và thực thi Procedure'''
        conn = pymysql.connect(host=self.host, user=self.uid, password=self.pw, db=self.database)
        cursor = conn.cursor()
        cursor.execute(proc)

        return cursor

    def Convert_DataFrame(self, cursor, cols):
        '''Chuyển đổi dữ liệu lấy được về dạng DataFrame'''
        
        results = cursor.fetchall()
        df = pd.DataFrame(results, columns=cols)
        return df

    def convert_params(self, params):
        r = []
        for val in params:
            r.append('NULL') if val is None else r.append("'"+str(val)+"'" if "'" not in str(val) else val)
        return r