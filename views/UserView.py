from views.BaseView import BaseModelView
from wtforms.fields import PasswordField, DateTimeField, StringField, BooleanField, TextField
from wtforms.validators import required, ValidationError
from flask_security import utils, current_user
import datetime
from flask_security.forms import LoginForm, Required
from models import Users
from flask_admin.form import rules
import hashlib

class UserView(BaseModelView):
    column_list = ['id', 'email', 'name', 'created_date', 'active']
    column_labels = dict([('email', 'Tên đăng nhập'),
                          ('name', 'Họ tên'), ('created_date', 'Thời gian tạo'), ('active', 'Kích hoạt'),
                          ('roles', 'Quyền truy cập'), ('password', 'Mật khẩu'), ('change_pwd', 'Đổi mật khẩu lần tới')])
    column_searchable_list = column_list[:3]
    column_details_list = column_searchable_list[1:] + ['active', 'roles', 'created_date', 'change_pwd']
    column_default_sort = column_list[0]
    
    can_delete=True
    page_size = 15
    
    form_extra_fields = {
        'password': PasswordField('Mật khẩu', [required()]),
        'pw_again': PasswordField('Nhắc lại mật khẩu', [required()]),
        'created_date': DateTimeField('Thời gian tạo', default=datetime.datetime.now(), render_kw={'disabled': 'True'}),
        'pwd_cf': PasswordField('Xác nhận mật khẩu', [required()]),
        'change_pwd': BooleanField('Đổi mật khẩu lần đăng nhập tới')
    }
    form_columns = ('roles', 'email', 'password', 'pw_again', 'name', 'active', 'change_pwd', 'pwd_cf')

    def on_model_change(self, form, model, is_created):
        model.password = utils.encrypt_password(model.password)
        model.created_date = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')

    def update_model(self, form, model):
        model.email = form.email.data
        model.name = form.name.data
        model.active = form.active.data
        model.roles = form.roles.data
        model.change_pwd = form.change_pwd.data
        if form.password.data != '********':
            model.password = utils.encrypt_password(form.password.data)
        self.session.commit()
        return True

class CustomLoginForm(LoginForm):
    email = StringField('Tên đăng nhập', [Required()])
    password = PasswordField('Mật khẩu', [Required()])