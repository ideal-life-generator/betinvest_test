$(->

  VerticalScrollView = Backbone.View.extend

    current: 0

    events:

      "click .scroll-top": ->
        @scrollUp()

      "click .scroll-bottom": ->
        @scrollDown()

      "mousewheel": ($event) ->
        $event.originalEvent.preventDefault()
        if $event.originalEvent.wheelDelta > 0
          @scrollUp()
        else
          @scrollDown()

    scrollUp: ->
      if @current > @step-1
        @current -= @step
      else
        @current = 0
      @render()

    scrollDown: ->
      if @current < @currentMax - @step
        @current += @step
      else
        @current = @currentMax
      @render()

    render: ->
      @proportion = @current / @currentMax
      TweenLite.to @params, 0.9,
        proportion: @proportion
        top: @blockSize * -@current
        onStart: =>
          if @proportion is 0
            if @scrollTop.css("opacity") isnt "0"
              TweenLite.to @scrollTop, 0.6,
                opacity: 0
                onComplete: => @scrollTop.css display: "none"
          else
            if @scrollTop.css("opacity") isnt "1"
              TweenLite.to @scrollTop, 0.6,
                onStart: => @scrollTop.css display: "", opacity: ""
                opacity: 1
          if @proportion is 1
            if @scrollBottom.css("opacity") isnt "0"
              TweenLite.to @scrollBottom, 0.6,
                opacity: 0
                onComplete: => @scrollBottom.css display: "none"
          else
            if @scrollBottom.css("opacity") isnt "1"
              TweenLite.to @scrollBottom, 0.6,
                onStart: => @scrollBottom.css display: "", opacity: ""
                opacity: 1
        onUpdate: =>
          @scrollTopShadow.css boxShadow: "0px 0px #{50 + 150 * @params.proportion}px #{100 + 100 * @params.proportion}px rgba(3, 12, 25, 1)"
          @scrollBottomShadow.css boxShadow: "0px 0px #{200 - 150 * @params.proportion}px #{200 - 100 * @params.proportion}px rgba(3, 12, 25, 1)"
          @scrolledList.css top: "#{@params.top}px"

    initialize: (params) ->
      @step = params.step
      @params =
        proportion: 0
        top: 0
      @scrolledList = @$el.find(".scrolled-list")
      @scrollTop = @$el.find(".scroll-top")
      @scrollTopShadow = @scrollTop.find(".button-shadow")
      @scrollBottom = @$el.find(".scroll-bottom")
      @scrollBottomShadow = @scrollBottom.find(".button-shadow")
      containerHeight = @$el.height()
      listHeight = @scrolledList.height()
      count = @scrolledList.children().length
      @currentMax = count - params.number
      @blockSize = containerHeight / 10
      @proportion = @current / @currentMax
      @scrolledList.css top: "#{@params.top}px"
      if @proportion is 0 and @scrollTop.css("opacity") isnt "0"
          @scrollTop.css opacity: 0, display: "none"
      else
        @scrollTopShadow.css boxShadow: "0px 0px #{50 + 150 * @params.proportion}px #{100 + 100 * @params.proportion}px rgba(3, 12, 25, 1)"
      if @proportion is 1 and @scrollTop.css("opacity") isnt "0"
          @scrollBottom.css opacity: 0, display: "none"
      else
        @scrollBottomShadow.css boxShadow: "0px 0px #{200 - 150 * @params.proportion}px #{200 - 100 * @params.proportion}px rgba(3, 12, 25, 1)"

  new VerticalScrollView el: $(".right-bar"), step: 5, number: 10

)