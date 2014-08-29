Prosody.Models.Article = Backbone.Model.extend({
  urlRoot: "/api/articles",

  annotations: function () {
    if (!this._annotations) {
      this._annotations = new Prosody.Collections.Annotations([], {article: this});
    }

    return this._annotations;
  },

  author: function () {
    if (!this._author) {
      this._author = new Prosody.Models.Author();
    }

    return this._author;

  },
  
  user: function () {
    if (!this._user) {
      this._user = new Prosody.Models.User();
    }
    
    return this._user;
  }

  parse: function (response) {
    if (response.annotations) {
      this.annotations().set(response.annotations, {parse: true});
      delete response.annotations;
    }

    if (response.author) {
      this.author().set(response.author, {parse: true});
      delete response.author;
    }
    
    if (response.user) {
      this.user().set(response.user, {parse: true});
      delete response.user;
    }

    return response
  }
})