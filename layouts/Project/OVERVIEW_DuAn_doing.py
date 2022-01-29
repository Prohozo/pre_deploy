import dash
import dash_html_components as html
from dash.dependencies import Input, Output, State
from app import app_DuAn
from utils import GParams_PJ_Multile
from DB import DB_DuAn
from static.system_dashboard.css import css_define as css
import pandas as pd
from layouts.Project.layout_overview import create_card

def gen_layout():
    _id_ = 'DuAn_doing'
    title = 'DỰ ÁN DOING'
    color = '#60B664' 
    icon = 'settings.svg'
    layout = html.Div([create_card(title,_id_,color,'ov-kt ov-5 col-lg-12 col-md-12 col-xs-12', icon = icon)], className='row')
    return layout

@app_DuAn.callback(
    Output("DuAn_doing", "children"),
    [Input('ddl_name', 'value'),
     Input('ddl_dept', 'value'),
     Input('filter_date', 'start_date'),
     Input('filter_date', 'end_date'),
     Input('grh_TL_DA_dept', 'selectedData'),
     Input('grh_status_duan_tron', 'clickData'),
     Input('grh_action_TG_month', 'selectedData'),
     Input('grh_action_TG_day', 'selectedData'),
     Input('grh_action_TG_year', 'selectedData'),
     Input('detail_chitiet_duan', 'active_cell'),
     Input('SoDuAn_dept', 'active_cell'),
     Input('detail_chitiet_trangthai', 'active_cell'),
     Input('detail_tiendo_duan', 'active_cell')],
    [State("detail_chitiet_duan", "data"),
     State("SoDuAn_dept", "data"),
     State("detail_chitiet_trangthai", "data"),
     State("detail_tiendo_duan", "data"),
    ]
)
def update_overview_DuAN(name, dept, start_act, end_act, TL_DA_dept, status_DA, action_TG_month, action_TG_day, action_TG_year, AC_chitiet, AC_DA_dept, AC_chitiet_tt,AC_td,  DT_chitiet, DT_DA_dept, DT_chitiet_tt, DT_td):
    # tu_ngay = None if den_ngay is None else tu_ngay
    ctx = dash.callback_context
    data_in_dt = {'detail_chitiet_duan': DT_chitiet,
                  'SoDuAn_dept': DT_DA_dept,
                  'detail_chitiet_trangthai': DT_chitiet_tt,
                  'detail_tiendo_duan': DT_td,}
    label, value = GParams_PJ_Multile.Get_Value(ctx,data_in_dt)
    if label in ('action_month', 'action_day', 'action_year'):
        label = label.split('_')[0]

    if start_act is None or end_act is None:
        start_act, end_act = None, None 
    df = DB_DuAn.GET_overview_DuAN_doing((name, dept, start_act, end_act, label, value))
    return df['value'].values[0]
