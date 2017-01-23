class @Settings extends Minimongoid

  @_collection: new Meteor.Collection 'settings'
  # console.log(@
  # Meteor.ettings.allow
  # #   insert: -> true
  #   update: -> true
#   remove: -> false

  if Meteor.isServer
  	Meteor.methods
      'Settings.updateNumberOfItemsPerPage': (num) ->
        check num, Number
        name = "numberOfPosts"
        console.log(Settings._collection.direct)
        setting =
          name: name
          value: num
        existing = Settings.find({name: setting.name}).fetch()
        dbSetting = _.find existing, (obj) -> return obj.name is setting.name
        if dbSetting.name is setting.name
          console.log("Setting Found: Updating value")
          # console.log(Settings)
          Settings._collection.direct.update({_id:dbSetting._id}, {$set:{value: num}}, {upsert: true })
        else
          console.log("Setting Not Found: Creating new setting")
          Settings.create(setting)
