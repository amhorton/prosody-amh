Prosody.Collections.Users = Backbone.Collection.extend({
  model: Prosody.Models.User,
  url: 'api/users',

  getOrFetch: function (id) {
    var user = this.get(id);

    if(!user) {
      user = new Prosody.Models.User({ id: id });
      user.fetch({
        success: function () {
          this.add(user);
        }.bind(this)
      });
    } else {
      user.fetch();
    }

    return user
  }
})