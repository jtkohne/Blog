Template.newPost.onCreated ->
  @state = new ReactiveDict

if Meteor.isClient
  Meteor.subscribe 'posts'

  if posts?
    return posts
  else
    posts = []

Template.newPost.onRendered ->
  # // onRendered is a new way to get a callback when template has finished rendering.
  # // rendered is just for backwards compatibility.
  # // onRendered takes a function as an argument. Try this instead:
  # // Should find both rendered and onRendered will be called.
  # // Also note that you can now add multiple onRendered callbacks for a given template.

Template.newPost.helpers ->
  "Postings": ->
    posts = Posts.find({}).fetch()
    unless posts?
      return []
    return posts

  "postImages": ->
    # posts = Posts.find({}).fetch()
    # if posts?
    #   return post.images[0]
    # else
      # return []

  "postTitle": ->
    postTitle = Posts.find({title})
    unless postTitle?
      return ''
    return postTitle

  "postPreview": ->
    post = posts.first()
    if post?
      body = post.body
      if body?
        return body
      else
        return ''
    unless post?
      return ''

  # "getFEContext": ->
  #   return {
  #     # Set html content
  #     _value: self.myDoc.myHTMLField,
  #     # Preserving cursor markers
  #     _keepMarkers: true,
  #     # Override wrapper class
  #     _className: "froala-reactive-meteorized-override",
  #
  #     # Set some FE options
  #     toolbarInline: true,
  #     initOnClick: false,
  #     tabSpaces: false,
  #
  #     # FE save.before event handler function:
  #     "_onsave.before": (e, editor) ->
  #       # Get edited HTML from Froala-Editor
  #       newHTML = editor.html.get(true); # keep markers
  #       # Do something to update the edited value provided by the Froala-Editor plugin, if it has changed:
  #       if !_.isEqual(newHTML, @myDoc.myHTMLField)
  #         console.log("onSave HTML is :"+newHTML);
  #         myCollection.update({_id: self.myDoc._id}, {
  #           $set: {myHTMLField: newHTML}
  #         });
  #
  #       return false; # Stop Froala Editor from POSTing to the Save URL
  #   }


Template.newPost.events

  'click .new-post': (e, instance) ->
    e.preventDefault

    tags = []
    title = $('.title').val()
    subject = $('.subject').val()
    body = $('.post-body').val()
    images = $('.images').val() || []
    characters = document.getElementById('tags').value
    tags = characters.split(' ')
    owner = Meteor.userId()
    # username = Meteor.users.findOne(@.userId).username

    post =
      title: title
      subject: subject
      body: body
      # images: ( ->
      #   if images?
      #     return images
      #   unless images != ""
      #     return images = []
      # )()
      tags: tags
      createdAt: new Date()
      owner:  ( ->
        owner = Meteor.userId()
        if owner?
          return owner
        else
          return "not signed in"
      )()
      # username: ((username) ->
      #   if username?
      #     return username
      #   unless username?
      #     return new Meteor.Error("username not found")
      # )()
      # userRole: ( ->
      #   owner = Meteor.userId()
      #   if owner?
      #     return "Admin"
      #   else
      #     return "Unable to determine user role"
      # )()
      type: ( ->
        owner = Meteor.userId()
        if owner?
          return if Meteor.user.role then Meteor.user.role else "user post"
        else
          return new Meteor.Error("User information not available")
      )()
    post = _.extend(@, post)

    Meteor.call 'Posts.save', post, (error, response) ->
      if error
        alert("fail"+error.reason)
        return console.log(error.reason);
        # return Toast.error("Failed, +"error.reason);
      return console.log(response)

  'click .delete-all-posts': (e, instance) ->
    e.preventDefault

    Meteor.call 'removeAllPosts', (error, response) ->
      return alert("All posts Deleted!")
