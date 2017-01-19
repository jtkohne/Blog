// import { Mongo } from 'meteor/mongo';
//
// export const Tasks = new Mongo.Collection('tasks');
//
// var Posts,
//   extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
//   hasProp = {}.hasOwnProperty;
//
// Posts = (function(superClass) {
//   extend(Posts, superClass);
//
//   function Posts() {
//     return Posts.__super__.constructor.apply(this, arguments);
//   }
//
//   Posts._collection = new Meteor.Collection('posts');
//
//   Posts.isValid = function(post) {
//     var errors;
//     errors = [];
//     if (post == null) {
//       throw new Meteor.Error(400, "Invalid Posting");
//     }
//   };
//
//   return Posts;
//
// })(Minimongoid);
//
// if (Meteor.isServer) {
//   Meteor.methods({
//     'Posts.save': function(post) {
//       var dbPost, response;
//       if (post._id != null) {
//         dbPost = Posts.first({
//           _id: post._id
//         });
//         if (dbPost == null) {
//           throw new Meteor.Error(400, "Could not find Posts");
//         }
//         dbPost.update(post);
//         response = {
//           status: 'updated',
//           post: dbPost
//         };
//       } else {
//         response = {
//           status: 'created',
//           post: Posts.create(post)
//         };
//       }
//       return reponse;
//     }
//   });
// }
