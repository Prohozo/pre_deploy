from app import server, db
from flask_admin import Admin, helpers as admin_helpers
from views import UserView as UV, RolesView as RV
from models import Users, Roles
from flask_security import Security, SQLAlchemyUserDatastore
from flask import url_for

# Setup Flask-Admin
admin = Admin(server, base_template='layout.html', template_mode='bootstrap3', url='/admin/home')
admin.add_view(UV.UserView(Users, db.session, url='/admin'))
admin.add_view(RV.RolesView(Roles, db.session, url='/admin/roles'))

# Setup Flask-Security
user_datastore = SQLAlchemyUserDatastore(db, Users, Roles)
security = Security(server, user_datastore, login_form=UV.CustomLoginForm)

# Define a context processor for merging flask-admin's template context into the flask-security views.
@security.context_processor
def security_context_processor():
    return dict(
        admin_base_template=admin.base_template,
        admin_view=admin.index_view,
        h=admin_helpers,
        get_url=url_for
    )