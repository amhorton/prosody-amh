Prosody.Routers.Router = Backbone.Router.extend({
  initialize: function () {
    Prosody.articles = new Prosody.Collections.Articles();
    this.$rootEl = $(".content");
  },

  routes: {
    '': 'home',
    'articles': 'articlesIndex',
    'articles/:id': 'articleShow',
    'users/:id': 'userShow',
    'new': 'articleForm',
    'authors/:id': 'authorShow'
  },

  home: function () {
    var view = new Prosody.Views.Home()
    this._swapView(view)
  },

  articlesIndex: function () {
    var that = this;
    Prosody.articles.fetch({
      success: function () {
        var view = new Prosody.Views.ArticlesIndex({
          collection: Prosody.articles
        });

        that._swapView(view);
      }
    });
  },

  articleShow: function (id) {
    var article = Prosody.articles.getOrFetch(id);
    var view = new Prosody.Views.ArticleShow({
      model: article
    });

    this._swapView(view);
  },

  articleForm: function () {
    if (Prosody.currentUserId) {
      var view = new Prosody.Views.ArticleForm();

      this._swapView(view);
    } else {
      // Backbone.history.navigate("/sessions/new", {});
      window.location = "session/new";
    }
  },

  authorShow: function (id) {
    var author = Prosody.authors.getOrFetch(id);
    var view = new Prosody.Views.AuthorShow({
      model: author
    });

    this._swapView(view);
  },

  userShow: function (id) {
    var user = Prosody.users.getOrFetch(id);
    var view = new Prosody.Views.UserShow({
      model: user
    });

    this._swapView(view);
  },

  _swapView: function (view) {
    this.currentView && this.currentView.remove;
    this.currentView = view;
    this.$rootEl.html(view.render().$el);
  }

})