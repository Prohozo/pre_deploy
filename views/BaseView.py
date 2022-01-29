from views.SecurityView import SecurityModelView

class BaseModelView(SecurityModelView):

    create_modal = True
    edit_modal = True
    details_modal = True
    can_view_details = True
    can_delete = False

    list_template = 'list.html'
    create_modal_template = 'modals/create.html'
    edit_modal_template = 'modals/edit.html'
    details_modal_template = 'modals/details.html'