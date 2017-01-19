Meteor.publish 'posts', () ->
	Posts.find({})
# #
# Meteor.publish 'posts', () ->
# 	return Posts.find({}).fetch()

Meteor.publish 'singlePost', (id) ->
	Posts.find({_id: id})

Meteor.publish 'users', () ->
	Meteor.users.find({})
