import config as cf

class Get_Params:
    def Get_Value(self, ctx, data=None):
        '''Lấy giá trị của các loại biểu đồ, datatable'''

        info = ctx.triggered[0]
        self._id_ = info['prop_id'].split('.')[0]
        value = info['value']

        if self._id_ in cf.MultiLine_Chart.keys() and value is not None:
            value = value['points'][0]['x']
            return cf.MultiLine_Chart[self._id_], value
        
        return None, None