#= require jquery.noty
#= require jquery.noty.topCenter
#= require jquery.noty.defaultTheme

$.fn.extend
  initNoty: ->
    self = $.fn.initNoty
    $(@).each (i, el) ->
      self.init $(el)

$.extend $.fn.initNoty,
  init: (el) ->
    $.noty.defaults.layout = 'topCenter'

    @initFlashNotes(el)
    @initAjaxNotes() unless $.noty.initialized

    $.noty.initialized = true

  initFlashNotes: (el) ->
    flashMessage = el.find '.flash-message'
    text = flashMessage.text()
    type = flashMessage.data 'flash-type'
    noty { text, type } if text != ''

  initAjaxNotes: ->
    $(document).on 'ajaxComplete', (e, xhr, settings) ->
      try json = JSON.parse xhr.responseText

      for own type, text of json?.noty
        noty { type, text } if text != ''
