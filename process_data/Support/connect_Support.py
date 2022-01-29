from process_data.Support.connect import Connect_MySQL

class Data_Support(Connect_MySQL):

    
    def get_Support(self, params):
        '''Gọi thủ tục con'''

        # Tên thủ tục tổng
        proc_name = 'dsa_support_all'
        # Gọi thủ tục tổng
        cursor = self.Call_Procedure(proc_name, params)
        # Trả kết quả về dataFrame
        return self.Convert_DataFrame(cursor)
    
    def Get_ddl_Support(self, params):
        '''Gọi thủ tục dropdown list con'''
        
        proc_name = 'dsa_support_ddl_all'
        cursor = self.Call_Procedure(proc_name, params)
        return self.Convert_DataFrame(cursor)
