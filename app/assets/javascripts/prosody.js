window.Prosody = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function (options) {

    Prosody.articles = new Prosody.Collections.Articles();
    Prosody.users = new Prosody.Collections.Users();
    Prosody.authors = new Prosody.Collections.Authors();
    Prosody.follows = new Prosody.Collections.Follows();
    Prosody.votes = new Prosody.Collections.Votes();
    
    Prosody.currentUserId = options.currentUserId

    new Prosody.Routers.Router();
    Backbone.history.start();
  }
}