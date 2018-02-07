json.array! @schedules do |schedule|
  date_format = '%Y-%m-%dT%H:%M:%S'

  json.id schedule.id
  json.title schedule.title
  json.start schedule.start.strftime(date_format)
  json.end schedule.end.strftime(date_format)
  json.user schedule.user_id 
 
  if schedule.editable == 0
    if Schedule.schedule_types[schedule.schedule_type] == Schedule.schedule_types[:initial]
      json.color 'yellow'
    elsif Schedule.schedule_types[schedule.schedule_type] == Schedule.schedule_types[:normal]
      json.color 'green'
    elsif Schedule.schedule_types[schedule.schedule_type] == Schedule.schedule_types[:return]
      json.color 'blue'
    end
    json.editable true
  else 
    json.color 'red'
    json.editable false
  end

  json.update_url site_schedule_path(schedule, method: :patch)
  json.edit_url edit_site_schedule_path(schedule)  
end