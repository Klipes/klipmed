$(document).on('turbolinks:load', function() {
  $('#buttonBuscar_user').click(function() {
    var cep, validacep;
    cep = $('#user_user_address_attributes_zip').val().replace(/\D/g, '');
    if (cep !== '') {
      validacep = /^[0-9]{8}$/;
      if (validacep.test(cep)) {
        $.getJSON('//viacep.com.br/ws/' + cep + '/json/?callback=?', function(dados) {
          if (!('erro' in dados)) {
            $('#user_user_address_attributes_address1').val(dados.logradouro);
            $('#user_user_address_attributes_neighborhood').val(dados.bairro);
            $('#user_user_address_attributes_city').val(dados.localidade);
            $('#user_user_address_attributes_state').val(dados.uf);
            $('#user_user_address_attributes_number').focus();
          } else {
            alert('CEP não encontrado.');
          }
        });
      }
    }
  });
  $('#user_user_address_attributes_zip').inputmask('99999-999');

  $("#user_user_configuration_attributes_start_hour").inputmask({"mask": "99:99"});
  $("#user_user_configuration_attributes_start_hour").datetimepicker({
    format: "HH:mm",
    stepping: 60
  });

  $("#user_user_configuration_attributes_start_end").inputmask({"mask": "99:99"});
  $("#user_user_configuration_attributes_start_end").datetimepicker({
    format: "HH:mm",
    stepping: 60
  });

});