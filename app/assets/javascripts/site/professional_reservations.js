$(document).on('turbolinks:load', function() {
  $("#reservation_date").datetimepicker({
    format: "DD/MM/YYYY"
  });  

  $("#reservation_hour_begin").inputmask({"mask": "99:99"});
  $("#reservation_hour_begin").datetimepicker({
    format: "HH:mm",
    stepping: 30
  });

  $("#reservation_hour_end").inputmask({"mask": "99:99"});
  $("#reservation_hour_end").datetimepicker({
    format: "HH:mm",
    stepping: 30
  });

});