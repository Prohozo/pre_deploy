import dash
from dash import dcc
from dash import html
from app import app_Lead
from utils import GParams_Lead
from DB import DB_Lead
from dash.dependencies import Input, Output, State

# Ham tao dropdown list


def gen_ddl(id_ddl, placeholder, className):
    data = DB_Lead.Get_ddl_lead((id_ddl))

    if id_ddl in ['ddl_lead_company', 'ddl_lead_source', 'ddl_lead_status', 'ddl_lead_city']:
        options = [{'value': data.values[i][0], 'label': data.values[i]
                    [0], 'title': data.values[i][0]} for i in range(data.shape[0])]
        options.append({'value': '', 'label': 'Không xác định',
                       'title': 'Không xác định'})

    elif id_ddl in ['ddl_lead_assign']:
        options = [{'value': data.values[i][0], 'label': data.values[i]
                    [1], 'title': data.values[i][1]} for i in range(data.shape[0])]
        options.append(
            {'value': '', 'label': 'Không xác định ()', 'title': 'Không xác định ()'})

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


def gen_layout_row_1():
    layout = html.Div([
        gen_ddl('ddl_lead_company', "Chọn KH tiềm năng",
                'col-sm-12 col-md-4 col-lg-4 mb-3'),
        gen_ddl('ddl_lead_source', "Chọn nguồn dẫn KH",
                'col-sm-12 col-md-4 col-lg-4 mb-3'),
        gen_ddl('ddl_lead_status', "Chọn trạng thái",
                'col-sm-12 col-md-4 col-lg-4 mb-3')
    ], className="row", style={'width': '100%', 'height': '100% ', 'flexWrap': 'wrap'})
    return layout


def gen_layout_row_2():
    layout = html.Div([
        gen_ddl('ddl_lead_dept', "Chọn phòng ban",
                'col-sm-12 col-md-4 col-lg-4 mb-3'),
        gen_ddl('ddl_lead_assign', "Chọn nhân viên được giao",
                'col-sm-12 col-md-4 col-lg-4 mb-3'),
        gen_ddl('ddl_lead_city', "Chọn thành phố",
                'col-sm-12 col-md-4 col-lg-4 mb-3')
    ], className="row", style={'width': '100%', 'height': '100% ', 'flexWrap': 'wrap'})
    return layout

# Company


@app_Lead.callback(
    Output('ddl_lead_company', 'value'),

    Input('num_lead_bysource', 'selectedData'),
    Input('lead_detail', 'active_cell'),

    State('ddl_lead_company', 'options'),
    State('lead_detail', 'data')
)
def update_ddl_source(source, ac_lead, company_options, data_lead):
    ctx = dash.callback_context
    datatable = {'lead_detail': data_lead}

    label, value = GParams_Lead.Get_Value(ctx, datatable)

    # Tạo danh sách các label có trong dropdown list
    labels = {option["label"]: option["value"] for option in company_options}

    # Nếu value tương tác nằm trong options của dropdown list thì trả về giá trị đó
    if value in labels.keys():
        return labels[value]
    else:
        return None

# Source


@app_Lead.callback(
    Output('ddl_lead_source', 'value'),

    Input('num_lead_bysource', 'selectedData'),
    Input('lead_detail', 'active_cell'),

    State('ddl_lead_source', 'options'),
    State('lead_detail', 'data')
)
def update_ddl_source(source, ac_lead, source_options, data_lead):
    ctx = dash.callback_context
    datatable = {'lead_detail': data_lead}

    label, value = GParams_Lead.Get_Value(ctx, datatable)

    # Tạo danh sách các label có trong dropdown list
    labels = {option["label"]: option["value"] for option in source_options}

    # Nếu value tương tác nằm trong options của dropdown list thì trả về giá trị đó
    if value in labels.keys():
        return labels[value]
    else:
        return None

# Status


@app_Lead.callback(
    Output('ddl_lead_status', 'value'),

    Input('num_lead_bystatus', 'selectedData'),
    Input('lead_detail', 'active_cell'),

    State('ddl_lead_status', 'options'),
    State('lead_detail', 'data')
)
def update_ddl_status(status, ac_lead, status_options, data_lead):
    ctx = dash.callback_context
    datatable = {'lead_detail': data_lead}

    label, value = GParams_Lead.Get_Value(ctx, datatable)

    # Tạo danh sách các label có trong dropdown list
    labels = {option["label"]: option["value"] for option in status_options}

    # Nếu value tương tác nằm trong options của dropdown list thì trả về giá trị đó
    if value in labels.keys():
        return labels[value]
    else:
        return None

# City


@app_Lead.callback(
    Output('ddl_lead_city', 'value'),

    Input('detail_lead_bycity', 'active_cell'),
    Input('lead_detail', 'active_cell'),
    Input('map_lead_bycity', 'clickData'),

    State('ddl_lead_city', 'options'),
    State('detail_lead_bycity', 'data'),
    State('lead_detail', 'data')
)
def update_ddl_city(city, ac_lead, ac_map, city_options, data_city, data_lead):
    ctx = dash.callback_context
    datatable = {'detail_lead_bycity': data_city,
                 'lead_detail': data_lead}

    label, value = GParams_Lead.Get_Value(ctx, datatable)

    # Tạo danh sách các label có trong dropdown list
    labels = {option["label"]: option["value"] for option in city_options}

    # Nếu value tương tác nằm trong options của dropdown list thì trả về giá trị đó
    if value in labels.keys():
        return labels[value]
    else:
        return None

# User


@app_Lead.callback(
    Output('ddl_lead_assign', 'value'),

    Input('lead_detail', 'active_cell'),
    Input('num_lead_byuser', 'selectedData'),

    State('ddl_lead_assign', 'options'),
    State('lead_detail', 'data')
)
def update_ddl_user(ac_lead, ac_user, user_options,  data_lead):
    ctx = dash.callback_context
    datatable = {'lead_detail': data_lead}

    label, value = GParams_Lead.Get_Value(ctx, datatable)

    # Tạo danh sách các label có trong dropdown list
    labels = {option["label"].split(
        ' (')[1][:-1]: option["value"] for option in user_options}

    # Nếu giá trị của ô chọn nằm trong danh sách label trên thì trả về giá trị đó trong ddl
    if value in labels.keys():
        return labels[value]
    else:
        return None
