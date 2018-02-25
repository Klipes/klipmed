function configureSupplierIdentifier(type){
  if (type == "entity"){
    $('#supplier_identifier').inputmask('999.999.999-99');
  } else {
    $('#supplier_identifier').inputmask('99.999.999/9999-99');
  }
}

$(document).on('turbolinks:load', function() {
  configureSupplierIdentifier($('#supplier_supplier_type').val());
  $('#supplier_phone').inputmask('(99)9999[9]-9999');

  $('#buttonBuscar_supplier').click(function() {
    var cep, validacep;
    cep = $('#supplier_supplier_address_attributes_zip').val().replace(/\D/g, '');
    if (cep !== '') {
      validacep = /^[0-9]{8}$/;
      if (validacep.test(cep)) {
        $.getJSON('//viacep.com.br/ws/' + cep + '/json/?callback=?', function(dados) {
          if (!('erro' in dados)) {
            $('#supplier_supplier_address_attributes_address1').val(dados.logradouro);
            $('#supplier_supplier_address_attributes_neighborhood').val(dados.bairro);
            $('#supplier_supplier_address_attributes_city').val(dados.localidade);
            $('#supplier_supplier_address_attributes_state').val(dados.uf);
            $('#supplier_supplier_address_attributes_number').focus();
          } else {
            alert('CEP não encontrado.');
          }
        });
      }
    }
  });
  
  $('#supplier_supplier_address_attributes_zip').inputmask('99999-999');
  $('body').on('change', '#supplier_supplier_type', function() {  
    configureSupplierIdentifier($('#supplier_supplier_type').val());
  });   

});