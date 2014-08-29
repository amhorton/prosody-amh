window.Prosody = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function () {

    Prosody.articles = new Prosody.Collections.Articles()

    new Prosody.Routers.Router()
    Backbone.history.start()
  }
}