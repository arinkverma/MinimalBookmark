Interview.Views.BookmarkTags ||= {}

class Interview.Views.BookmarkTags.ShowView extends Backbone.View
  template: JST["backbone/templates/bookmark_tags/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
