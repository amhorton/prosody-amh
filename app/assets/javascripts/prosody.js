window.Prosody = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function () {

    Prosody.articles = new Prosody.Collections.Articles();
    Prosody.users = new Prosody.Collections.Users();

    new Prosody.Routers.Router();
    Backbone.history.start();
  }
}