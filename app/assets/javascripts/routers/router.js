Prosody.Routers.Router = Backbone.Router.extend({
  initialize: function () {
    Prosody.articles = new Prosody.Collections.Articles();
    this.$rootEl = $(".content");
  },

  routes: {
    '': 'home',
    'articles': 'articlesIndex',
    'articles/:id': 'articleShow'
  },

  home: function () {

  },

  articlesIndex: function () {
    var that = this
    Prosody.articles.fetch({
      success: function () {
        var view = new Prosody.Views.ArticlesIndex({
          collection: Prosody.articles
        });

        that._swapView(view)
      }
    });


  },

  articleShow: function (id) {
    var article = Prosody.articles.get(id);
    var view = new Prosody.Views.ArticleShow({
      model: article
    });

    this._swapView(view)

  },

  _swapView: function (view) {
    this.currentView && this.currentView.remove;
    this.currentView = view;
    this.$rootEl.html(view.render().$el);
  }

})