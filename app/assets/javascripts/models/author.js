Prosody.Models.Author = Backbone.Model.extend({
  url: function () {
    return '/api/authors/' + this.id
  }

})