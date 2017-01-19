// import { Template } from 'meteor/templating';
// import { ReactiveVar } from 'meteor/reactive-var';
// import { ReactiveDict } from 'meteor/reactive-dict';
// import { Posts } from '../../../lib/collections/posts.js';
//
// import './blog.html';
// import '../../imports/startup/client/scripts/index.js';
//
// Template.newPost.onCreated(function() {
//   var blogTags, posts;
//   this.state = new ReactiveDict;
//   Meteor.subscribe('posts');
//   return;
//   posts = [];
//   return blogTags = new ReactiveVar("");
// });
//
// Template.newPost.onRendered(function() {});
//
// Template.newPost.helpers({
//   Posts() {
//     return Posts.find({});
//   },
// });
//
// Template.newPost.events({
//   'click .new-post': function(e, instance) {
//     var blog, body, characters, subject, tags, title;
//     e.preventDefault;
//     tags = [];
//     title = $('.title').val();
//     subject = $('.subject').val();
//     body = $('.post_body').val();
//     characters = document.getElementById('tags').value;
//     tags = characters.split(' ');
//     blog = {
//       title: title,
//       subject: $('.subject').val(),
//       body: $('.blog_body').val(),
//       images: [],
//       tags: tags
//     };
//     Posts.insert({
//       _id: Random.id(),
//       title: title,
//       subject: $('.subject').val(),
//       body: $('.blog_body').val(),
//       images: [],
//       tags: tags
//     });
//     instance.blogTags.set(instance.blogTags.get() + tags);
//     buildPost(blog);
//     return Meteor.call('Posts.save', blog, function(error, response) {
//       if (error !== null) {
//         return Toast.error('Cannot create post');
//       }
//       if (reponse.status === 'created') {
//         return alert('Post created!!!');
//       }
//     });
//   }
// });
