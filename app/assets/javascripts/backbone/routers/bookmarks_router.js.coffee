class Interview.Routers.BookmarksRouter extends Backbone.Router
  initialize: (options) ->
    @bookmarks = new Interview.Collections.BookmarksCollection()
    @bookmarks.reset options.bookmarks

  routes:
    "new"      : "newBookmark"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newBookmark: ->
    @view = new Interview.Views.Bookmarks.NewView(collection: @bookmarks)
    $("#bookmarks").html(@view.render().el)

  index: ->
    @view = new Interview.Views.Bookmarks.IndexView(bookmarks: @bookmarks)
    $("#bookmarks").html(@view.render().el)

  show: (id) ->
    bookmark = @bookmarks.get(id)

    @view = new Interview.Views.Bookmarks.ShowView(model: bookmark)
    $("#bookmarks").html(@view.render().el)

  edit: (id) ->
    bookmark = @bookmarks.get(id)

    @view = new Interview.Views.Bookmarks.EditView(model: bookmark)
    $("#bookmarks").html(@view.render().el)
