# Client with multiple front ends sample

This project is demonstrating how you can build multiple front ends off of one Shared library.
There are many interesting use cases that come from doing this but the sample here focuses on building supplementary debugging tools for a production app.

---

The structure of the project is:


```
                +--------+
                | shared |
                +--------+
                 ^   ^  ^
                /    |    \
       ,-------'     |     `--------.
      /              |               \
+---------+     +---------+     +---------+
|   app   |     |   cli   |     |   web   |
+---------+     +---------+     +---------+
```


**Shared**

Contains a networking client `JSONPlaceholderClient` that currently only has one real function, which is to fetch a list of people from [jsonplaceholder.typicode.com][1].

The networking client is resilient to bad input data - meaning it won't crash if some of the entries are not in the format it expects, the logic will happily just discard items that can't be parsed properly.

You can configure the client when you create it by setting `debugEnabled`:

- `debugEnabled: false`  
The client will return just the parsed data as native `Person` instances.

- `debugEnabled: true`  
The client will return the parsed data as native `Person` instances, the raw input JSON and any errors generated during the parsing of the `Person` instances.

There are a bunch of other types included in this shared library that would not ordinarily be grouped together. 
In the interest of keeping the sample code as minimal as possible most stuff has been bundled into this one module.

---

**App**

This folder contains a really simple iOS application that uses the networking client and presents the data in a tableview.

The key thing to note about this application is that it uses the networking client with `debugEnabled` set to `false`.
This means that the app will be resilient to bad input data and it will not pay any additional cost of collecting debug information when items can not be parsed.

---

**CLI**

`cli` is a common abbreviation for **C**ommand **L**ine **I**nterface.
This folder contains a Swift Package Manager project that creates an executable that will use the client in debug mode.
The result of using the client is then pretty printed back out to the console.

The benefit of this project is that it can form the building blocks for further tooling.
It gives a programmatic API that can be used to interact with the same code used within the production iOS application.

---

**Web**

This folder contains a Vapor application that again uses the networking client in debug mode.
The benefit of this tool is that you can use the same code that is used in production and get insight into the before/after representations of the parsed data and the errors that are output during parsing.

---

## Motivation

Having a web interface that runs the same code that is used within you iOS application is really powerful.
It enables you or support staff to simply visit a webpage and get a wealth of information that will help debug cases where the app is not displaying what we think it should be.

The web app can be dockerised and deployed, which means that it really opens up debugging opportunities from being tied to running Xcode with print statements or the debugger to just viewing a web page.

In the past I've written CLI tools but it would have been in a way where I was replicating the logic of the main app.
Using thinks like Ruby, curl and jq I would build up a parallel approximation of how the app behaved.
The power of this technique is that you are using the production code so you don't need to learn new tools, worry about the implementations getting out of sync or be concerned that as hard as you try the implementations may not match exactly.

---

## How to use this project

This project is provided as an example of how these things can fit together.
Browse the code and run the projects:

`app` contains an Xcode project for an iOS application. 
Open the project, choose your device and hit Run.

`cli` contains a Swift Package Manager project.
`cd` into the folder and run `swift run`.

`web` contains a Vapor project.
Ensure your have `Vapor` installed.
`cd` into the folder and run `vapor xcode`
Open the project and hit Run.

[1]:https://jsonplaceholder.typicode.com/
