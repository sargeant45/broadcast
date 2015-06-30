# `broadcast`: JavaScript function passing done the Scratch way
`broadcast` is a small CoffeeScript library (around 38 lines of CoffeeScript) that adds [Scratch](http://scratch.mit.edu)'s broadcasts to JavaScript. If you don't know what broadcasts are, or even what Scratch is, you can look [here.](http://wiki.scratch.mit.edu/wiki/Broadcast) Broadcasts are basically very simple function calls, but they don't stop the flow of the script, so you can run a broadcast that calls any number of functions and then returns with a callback function.

## Usage
First, initialize a new `Broadcast()` class like so:
```javascript
var myBroadcasts = new Broadcast();
```
After you initialize the Broadcast class, you can create new Broadcasts inside of it by specifying a Broadcast ID (a.k.a `"123"`) and a function including functions it should call when referenced (a.k.a `function() { alert('ey b0ss'); }`)
```javascript
// Create new Broadcast
myBroadcasts.create(
	"123", // specify first parameter, the Broadcast ID which you will later use to call the Broadcast.
	function() {
	  // the functions to be run when the Broadcast shouts
	  /* e.g. */ alert("Broadcast is running!");
	}
);
```
When you are ready to call a Broadcast, you should pass the Broadcast ID, a callback function, and the sync type to your Broadcast class like this:
```javascript
// Call the Broadcast, and when it finishes, do something (synchronous)
myBroadcasts.shout("123", "sync", function() {
	alert("Broadcast has completed!"); // Callback
});
// Call the Broadcast, and asynchronously do the callback with the specified functions.
myBroadcasts.shout("123", "async", function() {
  alert("Broadcast is completing!");
});
```
When you call the Broadcast with ID "123", it will run each line in the function you originally specified (a.k.a `function() { alert('ey b0ss'); }`), and then run the callback. You do not need to specify a callback, but keep in mind that Broadcast is built on callbacks, and is pretty much useless as a standalone library without using them.

You are not restricted to one Broadcast per class, and you can create as many Broadcasts as you want as long as they all have different ID's. An example of multiple Broadcasts in one class is this:
```javascript
// Create new Broadcast
myBroadcasts.create(
	"123", // specify first parameter, the Broadcast ID which you will later use to call the Broadcast.
	function() {
	  console.log('a'); // Functions
	  console.log('b'); // To
	  console.log('c'); // Run
	}
);

// Create another new Broadcast
myBroadcasts.create(
	"ABC", // specify first parameter, the Broadcast ID which you will later use to call the Broadcast.
		function() {
	  console.log('1'); // Functions
	  console.log('2'); // To
	  console.log('3'); // Run
	}
);

// Call "123" first, then call "ABC", and finally alert "Broadcasts have completed"
myBroadcasts.shout("123", "sync", function(){
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
	function() {
	  console.log('a'); // Functions
	  console.log('b'); // To
	  console.log('c'); // Run
	}
);

// Modify the Broadcast.
myBroadcasts.modify(
	"123", // pass current Broadcast ID
	function() {
	  console.log('9'); // Functions
	  console.log('8'); // To         // pass new functions to call
	  console.log('7'); // Run
	},
	"XYZ" // pass new Broadcast ID
);

// Run the modified Broadcast asynchronously
myBroadcasts.shout("XYZ", "async" function() {
   alert("XYZ has finished.");
});
```
A newly added feature in Broadcast 1.1.0 is `Broadcast::add`, which allows you to add a new event handler to an existing Broadcast like so:
```javascript
myBroadcasts.create("123", function() {
  console.log("a");
});

myBroadcasts.add("123", function() {
  console.log("b");
});

myBroadcasts.shout("123", "sync", function() {
  console.log("Done!");
});

// Outputs:
// a
// b
// Done!
```

Broadcast is open-source under the MIT license, which basically means you can do whatever the hell you want with it under proper attribution. Installing Broadcast is easy, and you can either use Bower,
```shell
bower install scratch-broadcast
```
...or you can just include the script in your HTML document's `<head>`,
```html
<script src="your_javascript_folder/broadcast.min.js"></script>
```
