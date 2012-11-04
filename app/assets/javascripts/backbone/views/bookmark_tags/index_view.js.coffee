Interview.Views.BookmarkTags ||= {}

class Interview.Views.BookmarkTags.IndexView extends Backbone.View
  template: JST["backbone/templates/bookmark_tags/index"]

  initialize: () ->
    @options.bookmarkTags.bind('reset', @addAll)

  addAll: () =>
    @options.bookmarkTags.each(@addOne)

  addOne: (bookmarkTag) =>
    view = new Interview.Views.BookmarkTags.BookmarkTagView({model : bookmarkTag})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(bookmarkTags: @options.bookmarkTags.toJSON() ))
    @addAll()

    return this
