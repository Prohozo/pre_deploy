# -*- coding: utf-8 -*-
import dash
from app import app_DuAn
from index_string_Tho import index_str
import dash_core_components as dcc
import dash_html_components as html
from dash.dependencies import Input, Output, State
from layouts.Project import DDL_project, OVERVIEW_DuAn, TYLE_status_duan, Detail_DuAn_BANG, Mucdott_DuAn_BANG, Detail_trangthai_BANG, OVERVIEW_DuAn_doing, OVERVIEW_DuAn_wait, OVERVIEW_DuAn_suspended, SoLuongDuAn_dept_BANG, TL_DuAn_dept, TD_HoanThanh_DA_BANG, ACTION_TG
import datetime as dt

app_DuAn.index_string = index_str

def gen_layout():
   now = dt.datetime.today().strftime(r'%Y/%m/%d')
   return html.Div([
               html.Div([
                  html.Div([
                     DDL_project.gen_layout(),
                  ], className='col-3', style={'display':'inline-grid', 'alignItems':'inherit'}),

                  html.Div([
                     html.Div([
                        html.Div([
                           OVERVIEW_DuAn.gen_layout(),
                        ], className='col-6 m-b-15'),
                        html.Div([
                           OVERVIEW_DuAn_doing.gen_layout(),
                        ], className='col-6 m-b-15'),
                        html.Div([
                           OVERVIEW_DuAn_wait.gen_layout(),
                        ], className='col-6 m-b-15'),
                        html.Div([
                           OVERVIEW_DuAn_suspended.gen_layout(),
                        ], className='col-6 m-b-15'),
                     ], className='row')
                  ], className='col-9')
               ],className='row'),

               html.Div([
                  ACTION_TG.gen_layout()
               ],className='row'),
               
               html.Div([
                  TYLE_status_duan.gen_layout(),
                  Detail_trangthai_BANG.gen_layout(),
                  
               ],className='row'),
              
               html.Div([
                  SoLuongDuAn_dept_BANG.gen_layout(),
                  TL_DuAn_dept.gen_layout(),
               ],className='row'),

               html.Div([
                  TD_HoanThanh_DA_BANG.gen_layout(),
                  Detail_DuAn_BANG.gen_layout(),
               ],className='row')

   ],className='section__content--p30', style={'backgroundColor': '#e5e5e5'})

app_DuAn.layout = gen_layout

if __name__ == '__main__':
    app_DuAn.run_server(host ='127.0.0.1' ,port=3333, debug=True)