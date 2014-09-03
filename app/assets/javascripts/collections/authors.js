Prosody.Collections.Author = Backbone.Collection.extend({
  model: Prosody.Models.Author,
  url: "/api/authors",
  
  getOrFetch: function (id) {
    var author = this.get(id);

    if(!author) {
      author = new Prosody.Models.Author({ id: id });
      author.fetch({
        success: function () {
          this.add(author);
        }.bind(this)
      });
    } else {
      author.fetch();
    }

    return author
  }
})