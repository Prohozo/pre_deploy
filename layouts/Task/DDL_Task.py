import dash
import dash_core_components as dcc
import dash_html_components as html
from app import app_Task
from utils import GParams_Task
from DB import DB_Task
from dash.dependencies import Input, Output, State

# Ham tao dropdown list
def gen_ddl(id_ddl, placeholder, className):
    data = DB_Task.Get_ddl_task((id_ddl))
    options = [{'value': data.values[i][0], 'label': data.values[i][1], 'title': data.values[i][1]} for i in range(data.shape[0])]
    return html.Div([
        dcc.Dropdown(
                    id=id_ddl,
                    options=options,
                    placeholder=placeholder,
                    value=None,
                    style={'height':'49px'}
                    )
    ], className=className)

# Tao layout cho dropdown list
def gen_layout():
    layout = html.Div([
        gen_ddl('ddl_task_project', "Chọn dự án", 'col-sm-12 col-md-3 col-lg-3 mb-3'),
        gen_ddl('ddl_task_story', "Chọn story", 'col-sm-12 col-md-3 col-lg-3 mb-3'),
        gen_ddl('ddl_task_dept', "Chọn phòng ban", 'col-sm-12 col-md-3 col-lg-3 mb-3'),
        gen_ddl('ddl_task_user', "Chọn nhân viên", 'col-sm-12 col-md-3 col-lg-3 mb-3'),
    ], className="row", style={'width': '100%', 'height': '100% ', 'flexWrap': 'wrap'})
    return layout

# Project
@app_Task.callback(
    Output('ddl_task_project', 'value'),

    Input('detail_task_delay', 'active_cell'),
    Input('detail_task_byproject', 'active_cell'),

    State('detail_task_delay', 'data'),
    State('detail_task_byproject', 'data'),
    State('ddl_task_project', 'options')
)
def update_project_ddl(ac_detail_task_delay, ac_detail_task_byproject, data_task_delay, data_task_byproject, project_options):
    ctx = dash.callback_context

    datatable = {'detail_task_delay': data_task_delay,
                 'detail_task_byproject': data_task_byproject,
                #  'detail_task_bystory': data_task_bystory
                 }

    label, value = GParams_Task.Get_Value(ctx, datatable)
    
    # Tạo danh sách các label có trong dropdown list 
    labels = {option["label"].split(' (')[0]:option["label"] for option in project_options}

    # Nếu giá trị của ô chọn nằm trong danh sách label trên thì trả về giá trị đó trong ddl
    if value in labels.keys():
        return int(labels[value].split('(')[1].split(')')[0])
    else:
        return None
    

# Story
@app_Task.callback(
    Output('ddl_task_story', 'value'),

    Input('detail_task_bystory', 'active_cell'),

    State('detail_task_bystory', 'data'),
    State('ddl_task_story', 'options')
)
def update_project_ddl(ac_detail_task_story, data_task_bystory, story_options):
    ctx = dash.callback_context

    datatable = {'detail_task_bystory': data_task_bystory}

    label, value = GParams_Task.Get_Value(ctx, datatable)

    # Tạo danh sách các label có trong dropdown list
    labels = {option["label"].split(' (')[0]: option["label"] for option in story_options}

    # Nếu giá trị của ô chọn nằm trong danh sách label trên thì trả về giá trị đó trong ddl
    if value in labels.keys():
        return int(labels[value].split('(')[1].split(')')[0])
    else:
        return None


# User
@app_Task.callback(
    Output('ddl_task_user', 'value'),

    Input('detail_task_delay', 'active_cell'),
    Input('bar_taskopened', 'selectedData'),
    Input('bar_taskdone', 'selectedData'),
    State('detail_task_delay', 'data'),
    State('ddl_task_user', 'options')
)
def update_project_ddl(ac_detail_task_delay,bar_taskopenede,bar_taskdone, data_task_delay, user_options):
    ctx = dash.callback_context
    datatable = {'detail_task_delay': data_task_delay}
    label, value = GParams_Task.Get_Value(ctx, datatable)
    # Tạo danh sách các label có trong dropdown list
    labels = {option["value"]: option["label"] for option in user_options}
    
    # Nếu giá trị của ô chọn nằm trong danh sách label trên thì trả về giá trị đó trong ddl
    if value in labels.keys():
        return labels[value].split('(')[1].split(')')[0]
    else:
        return None
