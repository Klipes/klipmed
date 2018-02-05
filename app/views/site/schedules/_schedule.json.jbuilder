date_format = '%Y-%m-%dT%H:%M:%S'

json.id schedule.id
json.title schedule.title
json.start schedule.start.strftime(date_format)
json.end schedule.end.strftime(date_format)
json.user schedule.user_id 
json.phone schedule.customer.phone
json.color 'green'
json.editable true
json.update_url site_schedule_path(schedule, method: :patch)
json.edit_url edit_site_schedule_path(schedule)  
