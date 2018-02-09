var covenant_Options;
covenant_Options = function(html){
  var covenants = html;
  var selectedProfessional = $('#schedule_user_id :selected').text();
  var optgroup = "optgroup[label='"+ selectedProfessional + "']";
  var covenantOptions = $(covenants).filter(optgroup).html();
  $('#schedule_covenant_id').html(covenantOptions)
};

function formatRepoSelection (repo) {
  return repo.fullname || repo.text;
};

function formatRepo (repo) {
  if (repo.loading) {
    return repo.text;
  }array

  var markup = "<div class='select2-result-customer__fullname'>" + repo.fullname + "</div>";
  return markup;
}

function userActiveDays(id) {
  var tmp = [0,1,2,3,4,5,6];
  $.ajax({
      'async': false,
      'type': "GET",
      'global': false,
      'dataType': 'json',
      'url': "users/configuration.json",
      'data': {'id': id},
      'success': function (data) {
        tmp = data;
      }
  });
  return tmp;
};

configure_schedule = function (type){  
  if (type == "initial"){
    $('#select2_customer').hide();
    $('#new_customer_fields').show();
  } else {
    $('#select2_customer').show();   
    $('#new_customer_fields').hide();
  }
};

$(document).on('turbolinks:load', function() {
  var covenantsOriginal = "";

  function load_calendar(){
     $('.calendar').each(function(){
      var calendar = $(this);
      calendar.fullCalendar({
        nowIndicator: true,
        selectable: true,
        selectHelper: true,
        editable: true,
        eventLimit: true,
        slotLabelFormat:"HH:mm",
        timeFormat: 'H(:mm)',
        defaultView: 'agendaWeek',
        locale: "pt-BR",
        hiddenDays: userActiveDays($('#user_id').val()),
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
              user_id: event.user,
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
              user_id: event.user,
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
          $('.calendar').fullCalendar('addEventSource', data);
          $('.calendar').fullCalendar('option', 'hiddenDays', userActiveDays($('#user_id').val()))
        }
    });   
  });
  
  $('body').on('change', '#schedule_schedule_type', function() {  
    configure_schedule($('#schedule_schedule_type').val());
  }); 

  $(document).on('show.bs.modal', function() {
    configure_schedule($('#schedule_schedule_type').val());

    //combobox select2
    $('#schedule_customer_id').select2({
      theme: "bootstrap4",
      dropdownParent: $("#new_schedule"),
      dropdownAutoWidth : true,
      minimumInputLength: 1,
      width: '100%', 
      height: '100%',
      ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
        url: "/site/customers.json",
        dataType: 'json',
        quietMillis: 250,
        data: function (term, page) {
            return {
                q: term, // search term
            };
        },
        processResults: function (data) {
          // Tranforms the top-level key of the response object from 'items' to 'results'
          return {
            results: data.items
          };
        },
        cache: true,
        templateResult: formatRepo,
        templateSelection: formatRepoSelection
      },        
    });

    $('#schedule_new_customer_phone').inputmask('(99)9999[9]-9999');   
  });

  load_calendar();
});



