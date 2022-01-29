import dash
from dash import dcc
from dash import html
from app import app_Support
from utils import GParams_Support
from DB import DB_Support
from dash.dependencies import Input, Output, State

# Ham tao dropdown list


def gen_ddl(id_ddl, placeholder, className):
    data = DB_Support.Get_ddl_Support((id_ddl))

    # Thêm option (Không xác định) cho ddl chỉ chứa label
    if id_ddl in ['ddl_potential_company', 'ddl_potential_sales_stage']:

        options = [{'value': data.values[i][0], 'label': data.values[i]
                    [0], 'title': data.values[i][0]} for i in range(data.shape[0])]
        options.append({'value': '', 'label': 'Không xác định',
                       'title': 'Không xác định'})

    # Thêm option (Không xác định) cho ddl chứa id, label
    elif id_ddl in ['ddl_potential_assign', 'ddl_potential_product']:
        options = [{'value': data.values[i][0], 'label': data.values[i]
                    [1], 'title': data.values[i][1]} for i in range(data.shape[0])]
        options.append(
            {'value': '', 'label': 'Không xác định ()', 'title': 'Không xác định ()'})

    elif id_ddl in ['ddl_status', 'ddl_account_status']:
        options = [{'value': data.values[i][0], 'label': data.values[i]
                    [0], 'title': data.values[i][0]} for i in range(data.shape[0])]

    # Không có option không xác định
    else:
        options = [{'value': data.values[i][0], 'label': data.values[i]
                    [1], 'title': data.values[i][1]} for i in range(data.shape[0])]
    return html.Div([
        dcc.Dropdown(
                    id=id_ddl,
                    options=options,
                    placeholder=placeholder,
                    value=None,
                    style={'height': '49px'}
                    )
    ], className=className)

# Tao layout cho dropdown list


def gen_layout():
    layout = html.Div([
        gen_ddl('ddl_account', "Chọn khách hàng",
                'col-sm-12 col-md-3 col-lg-3 mb-3'),
        # gen_ddl('ddl_account_status', "Chọn trạng thái khách hàng", 'col-sm-12 col-md-3 col-lg-3 mb-3'),
        gen_ddl('ddl_user_assign', "Chọn nhân viên",
                'col-sm-12 col-md-2 col-lg-2 mb-3'),
        gen_ddl('ddl_dept', "Chọn phòng ban",
                'col-sm-12 col-md-2 col-lg-2 mb-3'),
        gen_ddl('ddl_status', "Chọn trạng thái hỗ trợ",
                'col-sm-12 col-md-2 col-lg-2 mb-3'),
    ], className="row", style={'flexWrap': 'wrap'})
    return layout


# # Company
# @app_Support.callback(
#     Output('ddl_potential_company', 'value'),

#     Input('detail_potential_delay', 'active_cell'),
#     Input('detail_potential_delay_2', 'active_cell'),
#     Input('detail_potential', 'active_cell'),

#     State('ddl_potential_company', 'options'),
#     State('detail_potential_delay', 'data'),
#     State('detail_potential_delay_2', 'data'),
#     State('detail_potential', 'data'),
# )
# def update_ddl_source(ac_delay1, ac_delay2, ac_detail, company_options, data_delay1, data_delay2, data_detail):
#     ctx = dash.callback_context
#     datatable = {'detail_potential_delay':data_delay1,
#                  'detail_potential_delay_2':data_delay2,
#                  'detail_potential':data_detail
#                 }

#     label, value = GParams_Support.Get_Value(ctx, datatable)

#     # Tạo danh sách các label có trong dropdown list
#     labels = {option["label"]: option["value"]  for option in company_options}

#     # Nếu value tương tác nằm trong options của dropdown list thì trả về giá trị đó
#     if value in labels.keys():
#         return labels[value]
#     else:
#         return None

# # Sales stage
# @app_Support.callback(
#     Output('ddl_potential_sales_stage', 'value'),

#     Input('num_support_byuser', 'selectedData'),
#     Input('detail_potential_delay', 'active_cell'),
#     Input('detail_potential_delay_2', 'active_cell'),
#     Input('detail_potential', 'active_cell'),

#     State('ddl_potential_sales_stage', 'options'),
#     State('detail_potential_delay', 'data'),
#     State('detail_potential_delay_2', 'data'),
#     State('detail_potential', 'data'),
# )
# def update_ddl_source(sales_stage, ac_delay1, ac_delay2, ac_detail, sales_stage_options, data_delay1, data_delay2, data_detail):
#     ctx = dash.callback_context
#     datatable = {'detail_potential_delay':data_delay1,
#                  'detail_potential_delay_2':data_delay2,
#                  'detail_potential':data_detail
#                 }

#     label, value = GParams_Support.Get_Value(ctx, datatable)

#     # Tạo danh sách các label có trong dropdown list
#     labels = {option["label"]: option["value"]  for option in sales_stage_options}

#     # Nếu value tương tác nằm trong options của dropdown list thì trả về giá trị đó
#     if value in labels.keys():
#         return labels[value]
#     else:
#         return None

# # Product
# @app_Support.callback(
#     Output('ddl_potential_product', 'value'),

#     Input('num_potential_byproduct', 'active_cell'),

#     State('ddl_potential_product', 'options'),
#     State('num_potential_byproduct', 'data'),
# )
# def update_ddl_product(ac_potential, product_options, data_product):
#     ctx = dash.callback_context
#     datatable = {'num_potential_byproduct':data_product}

#     label, value = GParams_Support.Get_Value(ctx, datatable)

#     # Tạo danh sách các label có trong dropdown list
#     labels = {option["label"]: option["value"]  for option in product_options}

#     # Nếu value tương tác nằm trong options của dropdown list thì trả về giá trị đó
#     if value in labels.keys():
#         return labels[value]
#     else:
#         return None

# # User assign
# @app_Support.callback(
#     Output('ddl_potential_assign', 'value'),

#     Input('detail_potential_delay', 'active_cell'),
#     Input('detail_potential_delay_2', 'active_cell'),
#     Input('detail_potential', 'active_cell'),
#     Input('potential_by_user_assign', 'clickData'),
#     Input('potential_by_user_status_assign', 'selectedData'),

#     State('ddl_potential_assign', 'options'),
#     State('detail_potential_delay', 'data'),
#     State('detail_potential_delay_2', 'data'),
#     State('detail_potential', 'data'),
# )
# def update_ddl_user(ac_delay1, ac_delay2, ac_detail, ac_assigned_user1, ac_assigned_user2, user_assign_options, data_delay1, data_delay2, data_detail):
#     ctx = dash.callback_context
#     datatable = {'detail_potential_delay':data_delay1,
#                  'detail_potential_delay_2':data_delay2,
#                  'detail_potential':data_detail
#                 }

#     label, value = GParams_Support.Get_Value(ctx, datatable)

#     # Tạo danh sách các label có trong dropdown list

#     labels = {option["label"].split(' (')[1][:-1]: option["value"] for option in user_assign_options}

#     # Nếu giá trị của ô chọn nằm trong danh sách label trên thì trả về giá trị đó trong ddl
#     if value in labels.keys():
#         return labels[value]
#     else:
#         return None

# # User mkt
# @app_Support.callback(
#     Output('ddl_potential_mkt', 'value'),

#     Input('detail_potential', 'active_cell'),
#     Input('potential_by_user_mkt', 'clickData'),
#     Input('potential_by_user_status_mkt', 'selectedData'),

#     State('ddl_potential_mkt', 'options'),
#     State('detail_potential', 'data'),
# )
# def update_ddl_user(ac_detail, ac_assigned_user1, ac_assigned_user2, user_mkt_options, data_detail):
#     ctx = dash.callback_context
#     datatable = {
#                  'detail_potential':data_detail
#                 }

#     label, value = GParams_Support.Get_Value(ctx, datatable)

#     # Tạo danh sách các label có trong dropdown list

#     labels = {option["label"]: option["value"]  for option in user_mkt_options}

#     # Nếu giá trị của ô chọn nằm trong danh sách label trên thì trả về giá trị đó trong ddl
#     if value in labels.keys():
#         return labels[value]
#     else:
#         return None

# # User service
# @app_Support.callback(
#     Output('ddl_potential_service', 'value'),

#     Input('detail_potential', 'active_cell'),
#     Input('potential_by_user_service', 'clickData'),
#     Input('potential_by_user_status_service', 'selectedData'),

#     State('ddl_potential_service', 'options'),
#     State('detail_potential', 'data'),
# )
# def update_ddl_user(ac_detail, ac_service_user1, ac_service_user2, user_service_options, data_detail):
#     ctx = dash.callback_context
#     datatable = {
#                  'detail_potential':data_detail
#                 }

#     label, value = GParams_Support.Get_Value(ctx, datatable)

#     # Tạo danh sách các label có trong dropdown list

#     labels = {option["label"]: option["value"]  for option in user_service_options}

#     # Nếu giá trị của ô chọn nằm trong danh sách label trên thì trả về giá trị đó trong ddl
#     if value in labels.keys():
#         return labels[value]
#     else:
#         return None
