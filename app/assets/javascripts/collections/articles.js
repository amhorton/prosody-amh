Prosody.Collections.Articles = Backbone.Collection.extend({
  model: Prosody.Models.Article,
  url: '/api/articles',

  getOrFetch: function (id) {
    var article = this.get(id);

    if(!article) {
      article = new Prosody.Models.Article({ id: id });
      article.fetch({
        success: function () {
          this.add(article);
        }.bind(this)
      });
    } else {
      article.fetch();
    }

    return article
  }
})