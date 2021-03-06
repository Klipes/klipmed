function configurePayablePaymentMethod(paymentMethod){
  if (paymentMethod == "open"){
    $('label[for="payable_payment_method_id"]').hide();
    $('#payable_payment_method_id').hide();
  } else {
    $('label[for="payable_payment_method_id"]').show();
    $('#payable_payment_method_id').show();    
  }
}

$(document).on('turbolinks:load', function() {
  configurePayablePaymentMethod($('#payable_status').val());

  $('#payable_installment').inputmask('99/99');
  $('#payable_due_date').datetimepicker({
    defaultDate: "11/1/2013",
    format: 'DD/MM/YYYY'
  });
  $('#payable_amount').keydown(function(e) {
    if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 188, 108]) !== -1 || e.keyCode === 65 && (e.ctrlKey === true || e.metaKey === true) || e.keyCode === 67 && (e.ctrlKey === true || e.metaKey === true) || e.keyCode === 88 && (e.ctrlKey === true || e.metaKey === true) || e.keyCode >= 35 && e.keyCode <= 39) {
      return;
    }
    if ((e.shiftKey || e.keyCode < 48 || e.keyCode > 57) && (e.keyCode < 96 || e.keyCode > 105)) {
      e.preventDefault();
    }
  });

  $('body').on('change', '#payable_status', function() {  
    configurePayablePaymentMethod($('#payable_status').val());
  });   
});