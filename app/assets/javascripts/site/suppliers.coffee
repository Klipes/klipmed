# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $('#supplier_phone').inputmask '(99)9999[9]-9999'

  $('#buttonBuscar_supplier').click ->
      cep = $('#supplier_supplier_address_attributes_zip').val().replace /\D/g, ''
      if cep != ''
        validacep = /^[0-9]{8}$/
        if validacep.test(cep)
          $.getJSON '//viacep.com.br/ws/' + cep + '/json/?callback=?', (dados) ->
            if !('erro' of dados)
              $('#supplier_supplier_address_attributes_address1').val dados.logradouro
              $('#supplier_supplier_address_attributes_neighborhood').val dados.bairro
              $('#supplier_supplier_address_attributes_city').val dados.localidade
              $('#supplier_supplier_address_attributes_state').val dados.uf
              $('#supplier_supplier_address_attributes_number').focus()
            else
              alert 'CEP não encontrado.'
            return
      return
  $('#supplier_supplier_address_attributes_zip').inputmask '99999-999'