class @Settings extends Minimongoid

  @_collection: new Meteor.Collection 'settings'
  # console.log(@
  # Meteor.ettings.allow
  # #   insert: -> true
  #   update: -> true
#   remove: -> false

  if Meteor.isServer
  	Meteor.methods

      # CREATE METHOD -> Call this from end of other server methods to dynamically create any DB setting.
      'Settings.updateOrCreateSettingItem': (setting) ->
        check setting, Object
        existing = Settings.find({name: setting.name}).fetch() # find exisiing DB entry
        if existing.length > 0
          dbSetting = _.find existing, (obj) -> return obj.name is setting.name #find the existing name of queried setting
          if dbSetting.name is setting.name # check to see if the names match
            Settings._collection.direct.update({_id:dbSetting._id}, {$set:{value: setting.value}}, {upsert: true }) # change value
          else
            Settings._collection.direct.update({_id:dbSetting._id}, {$set:{name: setting.name, value: setting.value}}, {upsert: true }) # change name and value
        else
          Settings.create(setting) # new setting -> create one with parameters

      # ADMIN PANEL SETTINGS
      'Settings.changeNumberOfItemsPerPage': (num) ->
        check num, Number
        name = "numberOfPosts"
        setting =
          name: name
          value: num
        Meteor.call 'Settings.updateOrCreateSettingItem', setting, (error, reponse) ->
          if error?
            return "There was an error updating the setting: "+ error.reason
          response
        return num

      'Settings.changeNumberOfFeaturedItems': (num) ->
        check num, Number
        name = "numberOfFeatured"
        setting =
          name: name
          value: num
        Meteor.call 'Settings.updateOrCreateSettingItem', setting, (error, reason) ->
          if error?
            return "There was an error updating the setting: "+ error.reason
          response
        return num
