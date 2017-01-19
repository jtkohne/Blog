# Object.defineProperty Array.prototype, 'chunk_inefficient', value: (chunkSize) ->
#   array = this
#   [].concat.apply [], array.map((elem, i) ->
#     if i % chunkSize then [] else [ array.slice(i, i + chunkSize) ]
#   )
#
#   calculateRows: (index, post) ->
#     i = index;
#     while i > posts[i].length
#       row = posts[i]
#       return row[i]
#       i++
#     return

Template.recentPosts.onCreated ->
  @posts = @data
  @selectedModel= new ReactiveVar(null)
  # @groupedPosts = @posts.chunk_inefficient(3)
  # console.log(@groupedPosts)




Template.recentPosts.onRendered ->

  # // onRendered is a new way to get a callback when template has finished rendering.
  # // rendered is just for backwards compatibility.
  # // onRendered takes a function as an argument. Try this instead:
  # // Should find both rendered and onRendered will be called.
  # // Also note that you can now add multiple onRendered callbacks for a given template.

Template.recentPosts.helpers

  "Postings": ->
    return Template.instance().posts



        # row = _.find(posts, -> return @)
        # unless posts?
        #
        # return posts
    # callback = (obj) ->
    #   console.log(obj)
    #   return obj

    # return $.each posts, (i, val, callback) ->
      #$( "#" + i ).append( document.createTextNode( " - " + val ) );

      # callback(posts.shift())






  "postImages": ->
    # posts = Posts.find({}).fetch()
    # if posts?
    #   return post.images[0]
    # else
      # return []

  "postTitle": ->
    posts = Template.instance().posts
    if @name?
      return @name
    else
      return ''

  "postPreview": ->
    posts = Template.instance().posts

    if @body?
      return @body
    else
      return ''

  "postTags": ->
    posts = Template.instance().posts

    if @tags?
      return @tags
    else
      return []

Template.recentPosts.events
