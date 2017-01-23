Meteor.publish 'posts', () ->
  Posts.find({})

Meteor.publish 'singlePost', (id) ->
  Posts.find({_id: id})

Meteor.publish 'users', () ->
  Users.find({})

Meteor.publish 'settings', () ->
  Settings.find({})
