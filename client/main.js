// import { Template } from 'meteor/templating';
// import { ReactiveVar } from 'meteor/reactive-var';

// import './main.html';
// // import '../imports/startup/client/scripts/index.js';
// // import '../imports/startup/client/scripts/routes.js';

// Template.hello.onCreated(function helloOnCreated() {
//   // counter starts at 0
//   this.counter = new ReactiveVar(0);
// });

// Template.hello.onRendered(function() {
//   // onRendered is a new way to get a callback when template has finished rendering.
//   // rendered is just for backwards compatibility.
//   // onRendered takes a function as an argument. Try this instead:
//   // Should find both rendered and onRendered will be called.
//   // Also note that you can now add multiple onRendered callbacks for a given template.
// });

// Template.hello.helpers({
//   counter() {
//     return Template.instance().counter.get();
//   },
// });

// Template.hello.events({
//   'click button'(event, instance) {
//     // increment the counter when button is clicked
//     instance.counter.set(instance.counter.get() + 1);
//   },
// });
