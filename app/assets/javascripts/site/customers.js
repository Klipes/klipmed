$(document).on('turbolinks:load', function() {
  $('#customer_phone').inputmask('(99)9999[9]-9999');
  $('#customer_identifier').inputmask('999.999.999-99');

  $('#buttonBuscar_customer').click(function() {
    var cep, validacep;
    cep = $('#customer_customer_address_attributes_zip').val().replace(/\D/g, '');
    if (cep !== '') {
      validacep = /^[0-9]{8}$/;
      if (validacep.test(cep)) {
        $.getJSON('//viacep.com.br/ws/' + cep + '/json/?callback=?', function(dados) {
          if (!('erro' in dados)) {
            $('#customer_customer_address_attributes_address1').val(dados.logradouro);
            $('#customer_customer_address_attributes_neighborhood').val(dados.bairro);
            $('#customer_customer_address_attributes_city').val(dados.localidade);
            $('#customer_customer_address_attributes_state').val(dados.uf);
            $('#customer_customer_address_attributes_number').focus();
          } else {
            alert('CEP não encontrado.');
          }
        });
      }
    }
  });
  
  $('#customer_customer_address_attributes_zip').inputmask('99999-999');
});
