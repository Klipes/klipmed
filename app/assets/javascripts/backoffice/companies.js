function configureCompanyIdentifier(type){
  if (type == "entity"){
    $('#company_identifier').inputmask('999.999.999-99');
  } else {
    $('#company_identifier').inputmask('99.999.999/9999-99');
  }
}

$(document).on('turbolinks:load', function() {
  $('#company_company_address_attributes_zip').inputmask('99999-999');
  configureCompanyIdentifier($('#company_company_type').val());

  $('#buttonBuscar_company').click(function() {
    var cep, validacep;
    cep = $('#company_company_address_attributes_zip').val().replace(/\D/g, '');
    if (cep !== '') {
      validacep = /^[0-9]{8}$/;
      if (validacep.test(cep)) {
        $.getJSON('//viacep.com.br/ws/' + cep + '/json/?callback=?', function(dados) {
          if (!('erro' in dados)) {
            $('#company_company_address_attributes_address1').val(dados.logradouro);
            $('#company_company_address_attributes_neighborhood').val(dados.bairro);
            $('#company_company_address_attributes_city').val(dados.localidade);
            $('#company_company_address_attributes_state').val(dados.uf);
            $('#company_company_address_attributes_number').focus();
          } else {
            alert('CEP não encontrado.');
          }
        });
      }
    }
  });
  $('#company_phone').inputmask('(99)9999[9]-9999');

  $('body').on('change', '#company_company_type', function() {  
    configureCompanyIdentifier($('#company_company_type').val());
  });   
});
