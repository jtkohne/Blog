# `import { Accounts } from 'meteor/accounts-base';`

Template.header.onCreated ->

Template.header.helpers ->
  "canPost": ->
    adminRole = Roles.userIsInRole(Meteor.userId(), 'admin');
    console.log(adminRole);
    if adminRole
      return true
    else
      return false

Template.header.events
  'click [data-action=go-to-settings]': (e, template) ->
    Router.go('adminPanel')
