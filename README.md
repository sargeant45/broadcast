# `broadcast`: JavaScript function passing done the Scratch way
`broadcast` is a small CoffeeScript library (around 38 lines of CoffeeScript) that adds [Scratch](http://scratch.mit.edu)'s broadcasts to JavaScript. If you don't know what broadcasts are, or even what Scratch is, you can look [here.](http://wiki.scratch.mit.edu/wiki/Broadcast) Broadcasts are basically very simple function calls, but they don't stop the flow of the script, so you can run a broadcast that calls any number of functions and then returns with a callback function.

## Usage
First, initialize a new `Broadcast()` class like so:
```javascript
var myBroadcasts = new Broadcast();
```
After you initialize the Broadcast class, you can create new Broadcasts inside of it by specifying a Broadcast ID (a.k.a `"123"`) and an array of strings including functions it should call when referenced (a.k.a `["a()", "b()", "c()"]`)
```javascript
// Create new Broadcast
myBroadcasts.create(
	"123", // specify first parameter, the Broadcast ID which you will later use to call the Broadcast.
	["console.log('a')", "console.log('b')", "console.log('c')"] // array of functions inside strings to be evaluated when the Broadcast is called.
);
```
When you are ready to call a Broadcast, you should pass the Broadcast ID and a callback function to your Broadcast class like this:
```javascript
// Call the Broadcast, and when it finishes, do something.
myBroadcasts.shout("123", function() {
	alert("Broadcast has completed!"); // Callback
});
```
When you call the Broadcast with ID "123", it will run each function in the array you originally specified (a.k.a `["a()", "b()", "c()"]`), and then run the callback. You do not need to specify a callback, but keep in mind that Broadcast is built on callbacks, and is pretty much useless as a standalone library without using them.

You are not restricted to one Broadcast per class, and you can create as many Broadcasts as you want as long as they all have different ID's. An example of multiple Broadcasts in one class is this:
```javascript
// Create new Broadcast
myBroadcasts.create(
	"123", // specify first parameter, the Broadcast ID which you will later use to call the Broadcast.
	["console.log('a');", "console.log('b');", "console.log('c');"] // array of functions inside strings to be evaluated when the Broadcast is called.
);

// Create another new Broadcast
myBroadcasts.create(
	"ABC", // specify first parameter, the Broadcast ID which you will later use to call the Broadcast.
	["console.log('1');", "console.log('2');", "console.log('3');"] // array of functions inside strings to be evaluated when the Broadcast is called.
);

// Call "123" first, then call "ABC", and finally alert "Broadcasts have completed."
myBroadcasts.shout("123", function(){
	myBroadcasts.shout("ABC", function(){
		alert("Broadcasts have completed.");
	});
});
```
You can also modify Broadcasts after they have been created. Currently, you can change the Broadcast ID, and you can change the array of functions that the Broadcast will call when it shouts.
```javascript
// Create new Broadcast
myBroadcasts.create(
	"123", // specify first parameter, the Broadcast ID which you will later use to call the Broadcast.
	["console.log('a');", "console.log('b');", "console.log('c');"] // array of functions inside strings to be evaluated when the Broadcast is called.
);

// Modify the Broadcast.
myBroadcasts.modify(
	"123", // pass current Broadcast ID
	["console.log('7');", "console.log('8');", "console.log('9');"], // pass new functions to call
	"XYZ" // pass new Broadcast ID
);

// Run the modified Broadcast.
myBroadcasts.shout("XYZ", function() {
   alert("XYZ has finished.");
});
```

Broadcast is open-source under the MIT license, which basically means you can do whatever the hell you want with it under proper attribution. Installing Broadcast is easy, and you can either use Bower,
```shell
bower install scratch-broadcast
```
...or you can just include the script in your HTML document's `<head>`,
```html
<script src="your_javascript_folder/broadcast.min.js"></script>
```
