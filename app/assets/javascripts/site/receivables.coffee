# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $('.datetimepicker').datetimepicker
    defaultDate: "11/1/2013",
    format: 'DD/MM/YYYY'

  $('#receivable_amount').keydown (e) ->
    # Allow: backspace, delete, tab, escape, enter and .
    if $.inArray(e.keyCode, [
        46
        8
        9
        27
        13
        110
        188
        108
      ]) != -1 or e.keyCode == 65 and (e.ctrlKey == true or e.metaKey == true) or e.keyCode == 67 and (e.ctrlKey == true or e.metaKey == true) or e.keyCode == 88 and (e.ctrlKey == true or e.metaKey == true) or e.keyCode >= 35 and e.keyCode <= 39
      # let it happen, don't do anything
      return
    
    # Ensure that it is a number and stop the keypress
    if (e.shiftKey or e.keyCode < 48 or e.keyCode > 57) and (e.keyCode < 96 or e.keyCode > 105)
      e.preventDefault()
    return
  return
  