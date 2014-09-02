Prosody.Views.ArticleShow = Backbone.View.extend({
  template: JST["articles/show"],

  subviews: [],

  events: {
    'mouseup .article-text': 'showPopup',
    'mouseup .popup': 'renderForm',
    'mouseup .main': 'hidePopup'
  },

  initialize: function () {
    this.listenTo(this.model.annotations(), 'add sync', this.render)
    this.listenTo(this.model, 'sync', this.render)
  },

  render: function () {
    var that = this;

    // render self

    var renderedContent = this.template({
      article: this.model
    });
    this.$el.html(renderedContent);

    //render annotations

    this.model.annotations().each(function (annotation) {
      var view = new Prosody.Views.AnnotationShow({
        model: annotation
      });
      that.subviews.push(view);
      that.$(".annotation-show").html();
      that.$(".annotation-show").append(view.render().$el);
    })
    return this;
  },

  showPopup: function (event) {
    if (!rangy.getSelection().isCollapsed) {
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
    }

  },

  hidePopup: function (event) {

    $('.popup').css({
      display: "none"
    });
  },

  renderForm: function (event) {
    event.stopPropagation()
    event.preventDefault();
    var formView = new Prosody.Views.AnnotationForm({
      collection: this.model.annotations()
    });
    this.$(".annotation-form").html(formView.render().$el);
  },

  remove: function () {
    this.subviews.forEach(function (subview) {
      subview.remove();
    });

    Backbone.View.prototype.remove.call(this)
  }

})