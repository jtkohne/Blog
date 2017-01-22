# Admin Roles:
#   -> access admin panels
#   -> create users, assign user roles
#   -> delete any posts
#   -> make any posts private
#   -> disable site features
# Editor Roles:
#   -> edit posts
#   -> edit/delete comments
#   -> make posts created by themssleves private
#   -> create new posts (they can delete only these...)
# Standard Roles:
#   -> view posts (that aren't private)
#   -> view/create comments to posts
#

class @Users extends Minimongoid

  @_collection: Meteor.users

if Meteor.isServer
  Meteor.methods
    'User.addUserRole': (id) ->
      console.log("I got to the server")
      console.log(id)

    'User.changeUserRole': (userId, role) ->
      check userId, String;
      check role, String;

      currentRoles = Roles.getRolesForUser(userId);
      console.log("Current user roles length is: "+currentRoles.length)
      console.log(currentRoles)
      # if currentRoles.length > 1
      #   throw new Meteor.Error("Users cannot have more than one role assigned at at time")
      sameRole = _.contains currentRoles, role
      console.log(sameRole)
      console.log("User alrady has role: "+sameRole)

      if sameRole
        console.log("User already in role. Nothing changed")
        throw new Meteor.Error(500, "User already in role")

      console.log(userId)
      # currentRole = Roles.
      Roles.setUserRoles(userId, [role])
      console.log("Role changed to: "+role)
      return "User Role successfully changed to "+role
