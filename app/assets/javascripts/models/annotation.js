Prosody.Models.Annotation = Backbone.Model.extend({
  

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