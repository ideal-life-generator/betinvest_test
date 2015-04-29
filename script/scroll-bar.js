(function() {
  $(function() {
    var VerticalScrollView;
    VerticalScrollView = Backbone.View.extend({
      current: 0,
      events: {
        "click .scroll-top": function() {
          return this.scrollUp();
        },
        "click .scroll-bottom": function() {
          return this.scrollDown();
        },
        "mousewheel": function($event) {
          $event.originalEvent.preventDefault();
          if ($event.originalEvent.wheelDelta > 0) {
            return this.scrollUp();
          } else {
            return this.scrollDown();
          }
        }
      },
      scrollUp: function() {
        if (this.current > this.step - 1) {
          this.current -= this.step;
        } else {
          this.current = 0;
        }
        return this.render();
      },
      scrollDown: function() {
        if (this.current < this.currentMax - this.step) {
          this.current += this.step;
        } else {
          this.current = this.currentMax;
        }
        return this.render();
      },
      render: function() {
        this.proportion = this.current / this.currentMax;
        return TweenLite.to(this.params, 0.9, {
          proportion: this.proportion,
          top: this.blockSize * -this.current,
          onStart: (function(_this) {
            return function() {
              if (_this.proportion === 0) {
                if (_this.scrollTop.css("opacity") !== "0") {
                  TweenLite.to(_this.scrollTop, 0.6, {
                    opacity: 0,
                    onComplete: function() {
                      return _this.scrollTop.css({
                        display: "none"
                      });
                    }
                  });
                }
              } else {
                if (_this.scrollTop.css("opacity") !== "1") {
                  TweenLite.to(_this.scrollTop, 0.6, {
                    onStart: function() {
                      return _this.scrollTop.css({
                        display: "",
                        opacity: ""
                      });
                    },
                    opacity: 1
                  });
                }
              }
              if (_this.proportion === 1) {
                if (_this.scrollBottom.css("opacity") !== "0") {
                  return TweenLite.to(_this.scrollBottom, 0.6, {
                    opacity: 0,
                    onComplete: function() {
                      return _this.scrollBottom.css({
                        display: "none"
                      });
                    }
                  });
                }
              } else {
                if (_this.scrollBottom.css("opacity") !== "1") {
                  return TweenLite.to(_this.scrollBottom, 0.6, {
                    onStart: function() {
                      return _this.scrollBottom.css({
                        display: "",
                        opacity: ""
                      });
                    },
                    opacity: 1
                  });
                }
              }
            };
          })(this),
          onUpdate: (function(_this) {
            return function() {
              _this.scrollTopShadow.css({
                boxShadow: "0px 0px " + (50 + 150 * _this.params.proportion) + "px " + (100 + 100 * _this.params.proportion) + "px rgba(3, 12, 25, 1)"
              });
              _this.scrollBottomShadow.css({
                boxShadow: "0px 0px " + (200 - 150 * _this.params.proportion) + "px " + (200 - 100 * _this.params.proportion) + "px rgba(3, 12, 25, 1)"
              });
              return _this.scrolledList.css({
                top: "" + _this.params.top + "px"
              });
            };
          })(this)
        });
      },
      initialize: function(params) {
        var containerHeight, count, listHeight;
        this.step = params.step;
        this.params = {
          proportion: 0,
          top: 0
        };
        this.scrolledList = this.$el.find(".scrolled-list");
        this.scrollTop = this.$el.find(".scroll-top");
        this.scrollTopShadow = this.scrollTop.find(".button-shadow");
        this.scrollBottom = this.$el.find(".scroll-bottom");
        this.scrollBottomShadow = this.scrollBottom.find(".button-shadow");
        containerHeight = this.$el.height();
        listHeight = this.scrolledList.height();
        count = this.scrolledList.children().length;
        this.currentMax = count - params.number;
        this.blockSize = containerHeight / 10;
        this.proportion = this.current / this.currentMax;
        this.scrolledList.css({
          top: "" + this.params.top + "px"
        });
        if (this.proportion === 0 && this.scrollTop.css("opacity") !== "0") {
          this.scrollTop.css({
            opacity: 0,
            display: "none"
          });
        } else {
          this.scrollTopShadow.css({
            boxShadow: "0px 0px " + (50 + 150 * this.params.proportion) + "px " + (100 + 100 * this.params.proportion) + "px rgba(3, 12, 25, 1)"
          });
        }
        if (this.proportion === 1 && this.scrollTop.css("opacity") !== "0") {
          return this.scrollBottom.css({
            opacity: 0,
            display: "none"
          });
        } else {
          return this.scrollBottomShadow.css({
            boxShadow: "0px 0px " + (200 - 150 * this.params.proportion) + "px " + (200 - 100 * this.params.proportion) + "px rgba(3, 12, 25, 1)"
          });
        }
      }
    });
    return new VerticalScrollView({
      el: $(".right-bar"),
      step: 5,
      number: 10
    });
  });

}).call(this);
