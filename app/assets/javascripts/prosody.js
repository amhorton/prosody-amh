window.Prosody = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function () {

    new Prosody.Routers.Router()
    Backbone.history.start()
  }
}