# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $('#company_zip').inputmask '99999-999'

  $('#buttonBuscar_company').click ->
      cep = $('#company_zip').val().replace /\D/g, ''
      if cep != ''
        validacep = /^[0-9]{8}$/
        if validacep.test(cep)
          $.getJSON '//viacep.com.br/ws/' + cep + '/json/?callback=?', (dados) ->
            if !('erro' of dados)
              $('#company_address1').val dados.logradouro
              $('#company_neighborhood').val dados.bairro
              $('#company_city').val dados.localidade
              $('#company_state').val dados.uf
              $('#company_number').focus()
            else
              alert 'CEP não encontrado.'
            return
      return  
  $('#company_phone').inputmask '(99)9999[9]-9999'