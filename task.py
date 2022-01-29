# FILE CHÍNH, tổng hợp các file layout của từng biểu đồ
import dash_core_components as dcc
import dash_html_components as html
from app import app_Task
from index_string import index_str
from layouts.Task import DDL_Task,DDL_date_range, SL_TASKDONE, SL_TASKOPENED,OV_total_task, OV_total_hour, OV_total_delay_task, NUM_task_by_time, NUM_task_est_hour_by_time, NUM_task_by_dept, PIE_task_num_pri, DETAIL_task_delay, DETAIL_task_byproject, DETAIL_task_bystory
from layouts.Task import DETAIL_all
app_Task.index_string = index_str

def render_layout():
    layout = html.Div([
        html.Div([
            html.Div([

                # Overview
                html.Div([
                    html.Div([
                        html.Div(style={'margin-bottom':'67px'}),
                        html.Div('Ngày bắt đầu', style={'margin-bottom': '30px', 'font-size': '15px', 'color': 'black', 'font-weight': 'bold'}),
                        html.Div('Ngày kết thúc', style={'font-size': '15px', 'color': 'black', 'font-weight': 'bold'}),
                    ], className='col-sm-3 col-md-3 col-lg-1 mb-3'),
                    DDL_date_range.gen_layout(),
                    OV_total_task.gen_layout(),
                    OV_total_hour.gen_layout(),
                    OV_total_delay_task.gen_layout()
                ], className='row'),

                # Row 1: Filter(Project, User, Story)
                
                html.Div([
                    DDL_Task.gen_layout()
                ], className='row'),
                
                # Row 2: Line chart by time
                html.Div([
                    NUM_task_by_time.gen_layout(),
                    NUM_task_est_hour_by_time.gen_layout(),
                ], className='row'),

                # Row 2: Line chart by time
                html.Div([
                    NUM_task_by_dept.gen_layout()
                ], className='row'),
                
                # Row 3: 
                html.Div([
                    PIE_task_num_pri.gen_layout(),
                    DETAIL_task_delay.gen_layout(),
                ], className='row'),

                html.Div([
                    SL_TASKDONE.gen_layout(),
                    SL_TASKOPENED.gen_layout()
                ], className='row'),

                # Row 4: 
                html.Div([
                    DETAIL_task_byproject.gen_layout(),
                    DETAIL_task_bystory.gen_layout()
                ], className='row'),

                html.Div([
                    DETAIL_all.gen_layout()
                ], className='row'),
            
        ], className="container-fluid")
        ], className="section__content--p30", style={'backgroundColor': '#E5E5E5'})
        ])
    return layout

app_Task.layout = render_layout()

# Thiết lập host, port cho dashboard
if __name__ == '__main__':
    app_Task.run_server(debug=True)
    # host = '192.168.1.239', port = ''
