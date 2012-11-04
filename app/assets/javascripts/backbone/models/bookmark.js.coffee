class Interview.Models.Bookmark extends Backbone.Model
  paramRoot: 'bookmark'

  defaults:
    url: null

class Interview.Collections.BookmarksCollection extends Backbone.Collection
  model: Interview.Models.Bookmark
  url: '/bookmarks'
