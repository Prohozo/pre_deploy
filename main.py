# coding=utf-8

from app import server
from admin import security

''' Import layout main of each dash: '''
# from task import app_Task
# from Users import app_User
# from Project import app_DuAn
from lead import app_Lead
# from Accounts import app_Accounts
from potential import app_Potential
# from Users_CRM import app_UsersCRM
from Support import app_Support

from flask_security import utils, current_user
from flask import url_for, redirect, request, send_from_directory, render_template
from flask_security.views import login_required
from flask_security.decorators import roles_accepted
from utils import change_pwd_next, get_random_string
from controller.gen_item_menu import item_menu
from models import Users
from app import db
import os
from functools import wraps
# from controller.hipa import hapa, enpa


@server.route("/")
@change_pwd_next
def load_web():
    if current_user.is_authenticated:
        return redirect(url_for('load_home'))
    else:
        return redirect(url_for('security.login'))


@server.route("/home/")
@login_required
@change_pwd_next
def load_home():
    return render_template('home.html')

# Route page password next


@server.route("/change_pwd/")
@login_required
def change_password():
    if current_user.change_pwd:
        return render_template('change_pass.html')
    return redirect(url_for('load_home'))

# Process reset password


@server.route("/reset_pwd", methods=['POST'])
@login_required
@roles_accepted('Quản trị hệ thống')
def reset_pwd():
    pwd_cf = request.get_json()['pw_cf']
    if not utils.verify_password(pwd_cf, current_user.password):
        return 'NCF'
    else:
        uid = request.get_json()['id']
        pwd = get_random_string(8)
        ha_pwd = pwd
        user = Users.query.filter_by(id=uid)
        user.update(dict(password=utils.encrypt_password(ha_pwd), change_pwd=1))
        db.session.commit()
        return pwd

# Confirm password of current user


@server.route("/confirm_pwd", methods=['POST'])
@login_required
def confirm_pwd():
    pwd_cf = request.get_json()['pwd_cf']
    if utils.verify_password(pwd_cf, current_user.password):
        return "CF"
    return "NCF"

# Change password next


@server.route("/change_pwd_next", methods=['POST'])
@login_required
def changing_pwd_next():
    pwd = request.form['password']
    user = Users.query.filter_by(id=current_user.id)
    user.update(dict(password=utils.encrypt_password(pwd), change_pwd=0))
    db.session.commit()
    return redirect(url_for('security.logout'))


@server.route("/checking_info", methods=['POST'])
@login_required
def check_info():
    type_form = request.get_json()['type']
    uid = request.get_json()['id']
    usn = request.get_json()['usn']

    uq = Users.query
    if type_form == 'C' and uq.filter_by(email=usn).first():
        return 'EXISTS'
    if uq.filter_by(email=usn).first() and uq.filter_by(id=uid).first().email != usn:
        return 'EXISTS'
    return 'N_EXISTS'

# Generator menu


@server.route("/get_menu", methods=['GET'])
@login_required
def get_menu():
    return item_menu()

# Lock file important


@server.route('/protected/<path:filename>')
@login_required
@roles_accepted('Quản trị hệ thống')
def protected(filename):
    return send_from_directory(os.path.join(server.instance_path, ''), filename)


if __name__ == '__main__':
    ''' Change ip (host) server and port: '''
    server.run(debug=True, use_reloader=True,port=5000)
