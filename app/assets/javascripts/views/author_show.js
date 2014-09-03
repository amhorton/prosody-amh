Prosody.Views.AuthorShow = Backbone.View.Extend({
  template: JST['authors/show'],
  
  render: function () {
    var renderedContent = this.template({
      author: this.model
    })
  }
})