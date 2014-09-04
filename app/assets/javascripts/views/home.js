Prosody.Views.Home = Backbone.View.extend({
  template: JST['home'],

  events: {
    'input .search-bar': 'renderResults'
  },

  render: function () {
    var renderedContent = this.template({});

    this.$el.html(renderedContent);

    return this;
  },

  renderResults: function (event) {

    var $searchResults = $('.search-results');

    var term = event.currentTarget.value

    var success = function (data) {
      var view = new Prosody.Views.SearchResults({
        results: data
      });

      $searchResults.html(view.render().$el)
    }

    if (term.length > 3) {
      $.get('/api/search', {term: term}, success)
    } else {
      $searchResults.html("");
    }

  }


})