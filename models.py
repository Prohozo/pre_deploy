from app import db
import datetime
from flask_security import UserMixin, RoleMixin

roles_users = db.Table(
    'roles_users',
    db.Column('user_id', db.Integer(), db.ForeignKey('users.id'), nullable=False),
    db.Column('role_id', db.Integer(), db.ForeignKey('roles.id'), nullable=False)
)

class Users(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(20), nullable=False, unique=True) # , unique=True
    password = db.Column(db.String(255), nullable=False)
    name = db.Column(db.Unicode(30), nullable=False)
    created_date = db.Column(db.DateTime(), nullable=False, default=datetime.datetime.now)
    active = db.Column(db.Boolean(), nullable=False)
    change_pwd = db.Column(db.Boolean(), nullable=False)
    roles = db.relationship('Roles', secondary=roles_users, backref=db.backref('users', lazy='dynamic'))

    def __str__(self):
        return self.email

class Roles(db.Model, RoleMixin): # Category permission
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.Unicode(30), nullable=False)
    description = db.Column(db.Unicode(100))

    def __str__(self):
        return self.name

# db.drop_all()
# db.create_all()