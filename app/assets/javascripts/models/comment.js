Prosody.Models.Comment = Backbone.Model.extend({
  user: function () {
    if (!this._user) {
      this._user = new Prosody.Models.User();
    }

    return this._user;
  },

  parse: function (response) {

    if (response.user) {
      this.user().set(response.user, {parse: true});
      delete response.user;
    }

    return response
  }

})