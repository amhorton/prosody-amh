Prosody.Models.Annotation = Backbone.Model.extend({
  url: function () {
    
  },

  toJSON: function () {
    return {annotation: _.clone(this.attributes)}
  },

  comments: function () {
    if (!this._comments) {
      this._comments = new Prosody.Collections.Comments([], {annotation: this});
    }

    return this._comments;
  },

  user: function () {
    if (!this._user) {
      this._user = new Prosody.Models.User();
    }

    return this._user;

  },

  parse: function (response) {
    console.log("parsin'")
    if (response.comments) {
      this.comments().set(response.comments, {parse: true});
      delete response.comments;
    }

    if (response.user) {
      this.user().set(response.user, {parse: true});
      delete response.user;
    }

    return response;
  }

})