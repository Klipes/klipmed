var covenant_Options;
covenant_Options = function(html){
  var covenants = html;
  var selectedProfessional = $('#schedule_user_id :selected').text();
  var optgroup = "optgroup[label='"+ selectedProfessional + "']";
  var covenantOptions = $(covenants).filter(optgroup).html();
  $('#schedule_covenant_id').html(covenantOptions)
};

$(document).on('turbolinks:load', function() {
  var covenantsOriginal = "";

  function load_calendar(){
    $('.calendar').each(function(){
      var calendar = $(this);
      calendar.fullCalendar({
        customButtons: {
          new_scheduller: {
            text: 'Novo Agendamento',
            click: function() {
              $.getScript('/site/schedules/new', function() {
                $('#professional_id').val()
              });
            }
          }
        },
  
        header: {
          left: 'prev,next today',
          center: 'title',
          right: 'month,agendaWeek,agendaDay, new_scheduller'
        },
        nowIndicator: true,
        selectable: true,
        selectHelper: true,
        editable: true,
        eventLimit: true,
        slotLabelFormat:"HH:mm",
        timeFormat: 'H(:mm)',
        defaultView: 'agendaWeek',
        locale: "pt-BR",
        buttonText: {
          today:    'hoje',
          month:    'mês',
          week:     'semana',
          day:      'dia'
        },
        events: function(start, end, timezone, callback) { 
          $.ajax({
            url: '/site/schedules.json',
            data: {
                    user_id: $('#user_id').val(),
                    start: moment(start).format("YYYY-MM-DD") + "T00:00:00",
                    end: moment(end).format("YYYY-MM-DD") + "T00:00:00"            
                  },
            type: 'GET',
            success: function(data) {
              console.log(JSON.stringify(data));
              $('.calendar').fullCalendar('removeEvents'); 
              callback(data);
            }    
          })
        },
        eventClick: function(event, jsEvent, view) {
          if (event.editable){
            $.getScript(event.edit_url, function() {});
          }
        },
        eventDrop: function(event, delta, revertFunc) {
          event_data = { 
            schedule: {
              id: event.id,
              professional_id: event.professional,
              start: event.start.format(),
              end: event.end.format(),
              resize: false
            }
          };
          $.ajax({
              url: event.update_url,
              data: event_data,
              type: 'PATCH'
          });
        },
        eventResize:function(event, delta, revertFunc) {
          event_data = { 
            schedule: {
              id: event.id,
              professional_id: event.professional,
              start: event.start.format(),
              end: event.end.format(),
              resize: true
            }
          };
          $.ajax({
              url: event.update_url,
              data: event_data,
              type: 'PATCH'
          });
        }
      });
    })      
  };

  $('body').on('focus', '#schedule_start', function() {
    $("#schedule_start").datetimepicker({
      format: "DD/MM/YYYY"
    });
  });

  $('body').on('focus', '#schedule_end', function() {
    $("#schedule_end").inputmask({"mask": "99:99"});
    $("#schedule_end").datetimepicker({
      format: "HH:mm",
      stepping: 30
    });
  });

  $('body').on('change', '#schedule_user_id', function() {  
    if (covenantsOriginal == "") {
      covenantsOriginal = $('#schedule_covenant_id').html();  
    }
    covenant_Options(covenantsOriginal);
  }); 
  
  $('body').on('focus', '#schedule_covenant_id', function() {  
    if (covenantsOriginal == "") {
      covenantsOriginal = $('#schedule_covenant_id').html();  
      covenant_Options(covenantsOriginal);
    }
  });

  $('#user_id').change(function(){
    event_data = { 
        user_id: $('#user_id').val(),
        start: moment($('.calendar').fullCalendar('getView').start).format("YYYY-MM-DD") + "T00:00:00",
        end: moment($('.calendar').fullCalendar('getView').end).format("YYYY-MM-DD") + "T00:00:00"
    };
    var events = $.ajax({
        url: '/site/schedules.json',
        data: event_data,
        type: 'GET',
        success: function(data) {
          $('.calendar').fullCalendar('removeEvents'); 
          $('.calendar').fullCalendar( 'addEventSource', data )
        }
    });   
  });
  
  load_calendar();
});


