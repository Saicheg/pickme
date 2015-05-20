$ ->

  class window.GameController
    constructor: ->
      @userQueue = new UserQueue($('.pairs-container'))
      @bindEvents()
    bindEvents: =>
      $('body').on 'click', '.left, .right', @pick

    pick: (e) =>
      e.preventDefault()
      return if @currentPair().is(":animated")
      url = @detectUrl(e)
      $.post(url) if url
      @userQueue.nextPair()

    detectUrl: (event) =>
      target = event.currentTarget
      @currentPair().find(".#{target.className}").data("link")

    currentPair: => @userQueue.current


  class window.UserQueue
    constructor: (queueContainer) ->
      @container = queueContainer
      @pairs     = @container.find('.pair').toArray()
      @current   = $(@pairs.pop())
      @current.show()

    nextPair: =>
      @old = @current
      @current.fadeOut 300, =>
        @current = $(@pairs.pop())
        @current.fadeIn 300, =>
          @addPair()
          @old.remove()

    addPair: =>
      $.getJSON Routes.pair_game_index_path(), (json) =>
        pair = $(HoganTemplates['game/pair'].render(json))
        @container.append(pair)
        @pairs.unshift(pair)

  window.gameController = new GameController()
