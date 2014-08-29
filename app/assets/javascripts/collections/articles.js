Prosody.Collections.Articles = Backbone.Collection.extend({
  model: Prosody.Models.Article,
  url: '/api/articles',

  getOrFetch: function (id) {
      var article = this.get(id);

      if(!article) {
        console.log("fetchin'")
        article = new Prosody.Models.Article({ id: id });
        article.fetch({
          success: function () {
            this.add(article);
          }.bind(this)
        });
      } else {
        console.log("gettin'")
        article.fetch();
      }

      return article;
    }
})