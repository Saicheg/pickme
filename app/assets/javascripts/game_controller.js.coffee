$ ->

  class window.GameController
    constructor: ->
      @userQueue = new UserQueue($('.pairs-container'))
      @bindEvents()
    bindEvents: =>
      $('.right, .left').on 'click', @pick

    pick: (e) =>
      e.preventDefault()
      return if @currentPair().is(":animated")
      [winner, loser] = @detectUsers(e)
      @postChoise({winner: winner, looser: loser})
      @userQueue.nextPair()

    detectUsers: (event) =>
      console.log(event)
      [1,2]

    postChoise: (data) =>
      $.post

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
      $.post Routes.pair_game_index_path(), (data) =>
        pair = $(data)
        @container.append(pair)
        @pairs.unshift(pair)

  window.gameController = new GameController()
