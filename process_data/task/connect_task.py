from process_data.task.connect import Connect_MySQL
import pandas as pd

class Data_Task(Connect_MySQL):

    
    def Get_task(self, params):
        '''Gọi thủ tục con'''
        # Tên thủ tục tổng
        proc_name = 'dsa_task_all'
        # Gọi thủ tục tổng
        cursor = self.Call_Procedure(proc_name, params)
        # Trả kết quả về dataFrame
        return self.Convert_DataFrame(cursor)
    
    def Get_ddl_task(self, params):
        '''Gọi thủ tục dropdown list con'''
        proc_name = 'dsa_task_ddl_all'
        cursor = self.Call_Procedure(proc_name, params)
        return self.Convert_DataFrame(cursor)
