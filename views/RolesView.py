from views.BaseView import BaseModelView
from wtforms.fields import StringField

class RolesView(BaseModelView):
    column_labels = dict([('name', 'Tên quyền'), ('users', 'Người dùng'), ('description', 'Mô tả')])
    column_searchable_list = ['name']
    
    can_view_details = False
    
    form_extra_fields = {
        'name': StringField('Tên quyền', render_kw={'disabled': 'True'}),
        'description': StringField('Mô tả')#, render_kw={'disabled': 'True'})
    }
    form_columns = ('name', 'description', 'users')