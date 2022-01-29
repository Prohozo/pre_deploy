import config as cf

class Get_Params:

    def Get_Value_DT(self, active_cell, data, cols):
        '''Hỗ trợ lấy giá trị (col,val) của datatable'''

        label = active_cell['column_id']
        # Tách link ra khỏi tương tác
        if label in cols.keys() and label in ['p.potentialname', 'company']:
            value = data[active_cell['row']][cols[label]].split(']')[0][1:].split(' (')[0]
            return label, value

        elif label in cols.keys() and label not in ['p.potentialname', 'company']:
            value = data[active_cell['row']][cols[label]]
            return label, value
        else:
            return None, None

    def Get_Value(self, ctx, data=None):
        '''Lấy giá trị (col,val) của các loại biểu đồ, datatable'''

        info = ctx.triggered[0]
        
        if info['prop_id'].split('.')[1] in ("'page_current','page_size','sort_by','filter_query'") :
            self._id_ = info['prop_id']
        else: 
            self._id_ = info['prop_id'].split('.')[0] 
        value = info['value']


        if value is None:
            return None, None

        # info = ctx.triggered[0]
        # self._id_ = info['prop_id'].split('.')[0]
        # value = info['value']
        # if value is None:
        #     return None, None

        if self._id_.split('_')[0] == 'ddl':
            return None, None

        if self._id_ in cf.Bar_Chart.keys() and value is not None:
            value = value['points'][0]['label']
            return cf.Bar_Chart[self._id_], value

        # if self._id_ in cf.Bar_Chart.keys() and value is not None:
        #     value = value['points'][0]['label']

        #     return cf.Bar_Chart[self._id_], value

        if self._id_ in cf.Line_Chart.keys() and value is not None:
            value = value['points'][0]['x']
            return cf.Line_Chart[self._id_], value

        # if self._id_ in cf.MultiLine_Chart.keys() and value is not None:
        #     value = value['points'][0]['curveNumber']
        #     return cf.MultiLine_Chart[self._id_], value

        if self._id_ in cf.Pie_Charts.keys() and value is not None:

            return cf.Pie_Charts[self._id_], value['points'][0]['label']

        if self._id_ in cf.Datatable.keys():
            if type(data) == dict:
                data = data[self._id_]
            label, value = self.Get_Value_DT(value, data, cf.Datatable[self._id_])
            return label, value

        return None, None
