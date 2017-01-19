/*
Admin Roles:
  -> access admin panels
  -> create users, assign user roles
  -> delete any posts
  -> make any posts private
  -> disable site features
Editor Roles:
  -> edit posts
  -> edit/delete comments
  -> make posts created by themssleves private
  -> create new posts (they can delete only these...)
Standard Roles:
  -> view posts (that aren't private)
  -> view/create comments to posts
*/

insertUsers=function(){
  var adminId=Accounts.createUser({
    username:"admin",
    password:"password"
  });
  //
  Roles.addUsersToRoles(adminId,"admin");
};
