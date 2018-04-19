//= require jquery3
//= require jquery_ujs
//= require bootstrap
//= require select2
//= require moment
//= require inputmask
//= require jquery.inputmask
//= require inputmask.extensions
//= require inputmask.date.extensions
//= require inputmask.phone.extensions
//= require inputmask.numeric.extensions
//= require inputmask.regex.extensions
//= require fullcalendar
//= require notifyjs
//= require turbolinks
//= require_tree ./site

$(document).on('turbolinks:load', function() {
  $('#sidebar-header').on('click', function () {
    $('#sidebar').toggleClass('active');
  });
});
