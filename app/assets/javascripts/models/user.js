Prosody.Models.User = Backbone.Model.extend({
  url: function () {
    return '/api/users/' + this.id
  }

})