Prosody.Views.ArticleShow = Backbone.View.extend({
  template: JST["articles/show"],

  subviews: [],

  events: {
    'click .article-text': 'showPopup',
    'mousedown .popup': 'renderForm',
    'mouseup .main': 'hidePopup',
    'click .annotation-link': 'renderAnnotation',
    'click .inactive': 'vote'
  },

  initialize: function () {
    this.listenTo(this.model.annotations(), 'add sync', this.render)
    this.listenTo(this.model, 'sync', this.render)
    this._showPopup = false;
  },

  render: function () {
    var that = this;

    var renderedContent = this.template({
      article: this.model
    });
    this.$el.html(renderedContent);

    if (!this.model.get("can_upvote")) {
      this.$('.up').removeClass("inactive");
    }

    if (!this.model.get("can_downvote")) {
      this.$('.down').removeClass("inactive");
    }


    return this;
  },

  vote: function (event) {
    event.preventDefault();
    
    var that = this;
    
    if ($(event.target).hasClass("up")) {
      var val = 1
    } else {
      var val = -1
    }

    $.ajax({
      type: "POST",
      url: "/api/votes",
      data: {
        vote: {
          val: val,
          votable_id: this.model.id,
          votable_type: "Article"
        }
      },
      success: function(data){
        that.model.fetch()
      }
    });
  },

  showPopup: function (event) {
    if (Prosody.currentUserId) {
      if (!rangy.getSelection().isCollapsed && this._showPopup === false) {
        if (!$(event.target).hasClass("popup")) {
          event.stopPropagation();

          $text = $('.article-text');
          $popup = $('.popup');

          var x = event.pageX;
          var y = event.pageY;

          $popup.css({
            left: x + "px",
            top: y + "px",
            display: "block"
          });

          this._showPopup = true;
        }
      }
    }
  },

  hidePopup: function (event) {
    console.log(event.target)
    console.log(event.currentTarget)
    $('.popup').css({
      display: "none"
    });

    this._showPopup = false
  },

  renderForm: function (event) {
    event.preventDefault();
    event.stopPropagation();
    var range = rangy.getSelection().getRangeAt(0);
    var snippet = range.text();

    var formView = new Prosody.Views.AnnotationForm({
      collection: this.model.annotations(),
      pos: range.toCharacterRange($(".article-text")[0]),
      snippet: snippet
    });

    this.subviews.push(formView)

    var y = event.pageY

    var $annotationView = $('.annotation-view');

    $annotationView.html(formView.render().$el);

    if (y + $annotationView.height() > ($(document).height() - 75)) {
      y = $(document).height() - 75 - $annotationView.height()
    }

    $annotationView.css({
      top: y + "px",
      display: "block"
    });

  },

  renderAnnotation: function (event) {
    event.preventDefault();

    var annotationID = parseInt(event.currentTarget.id);

    var $annotationView = $('.annotation-view');

    var annotation = this.model.annotations().get(annotationID)
    console.log(annotation)

    var view = new Prosody.Views.AnnotationShow({
      model: annotation
    });
    this.subviews.push(view);
    $annotationView.html(view.render().$el);

    var y = event.pageY;





    // console.log("y after conditional,", y)

    $annotationView.css({
      top: y + "px",
      display: "block"
    });

  },

  remove: function () {
    this.subviews.forEach(function (subview) {
      subview.remove();
    });

    Backbone.View.prototype.remove.call(this)
  }

})