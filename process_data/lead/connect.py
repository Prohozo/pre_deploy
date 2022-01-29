import mysql.connector
import pandas as pd


class Connect_MySQL:

    def __init__(self, host, database, uid, pwd):
        '''Khởi tạo các tham số cần thiết để kết nối database(id, password, host, tên database)'''

        self.user = uid
        self.password = pwd
        self.host = host
        self.database = database
    
    # Chuyển tham số được nhập từ tuple thành list
    def convert_params_mysql(self, params):
        r = []
        for val in params:
            r.append(None) if val is None else r.append(""+str(val)+"")
        return r

    def Call_Procedure(self, proc, params):
        '''Kết nối đến CSDL và thực thi Procedure'''

        conn = mysql.connector.connect(host=self.host, user=self.user, password=self.password, database=self.database)
        cursor = conn.cursor()

        # Nếu thủ tục gọi là 1 dropdown list thì không chỉnh sửa 
        # (vì chỉ nhập 1 giá trị id của thủ tục, k có tham số)
        if 'ddl' in proc:
            r = []
            r.append(params)
            params_proc = r
        else:
            # Còn thủ tục bình thường có tham số thì cần chuyển về dạng list
            params_proc = self.convert_params_mysql(params)
            
        cursor.callproc(proc, params_proc)
        return cursor

    def Convert_DataFrame(self, cursor):
        '''Chuyển đổi dữ liệu lấy được về dạng DataFrame'''
        
        for i in cursor.stored_results():
            # Lấy tên các cột
            columns_list = [k[0] for k in i.description]
            # Lấy giá trị của thủ tục trả về
            result = i.fetchall()
        df = pd.DataFrame(result, columns=columns_list)
        return df

    # def convert_params(self, params):
    #     r = []
    #     for val in params:
    #         r.append('NULL') if val is None else r.append("'"+val+"'")
    #     return r
