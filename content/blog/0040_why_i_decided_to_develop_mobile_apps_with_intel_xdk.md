---
kind: article
created_at: 08 February 2016
title: Why I decided to develop mobile apps with Intel XDK
tags: ["blog"]
---

#Why I decided to develop mobile apps with Intel XDK

For the last couple weeks I was making a mobile app using Meteor.js and cordova. Requirements of the application was very specific: I had to download huge amount of data via remote API and store it locally. 

Besides of pure text-based data there was also many files which I had to download and store on the phone locally.

I've found that managing files and writing them to device memory synchronously (it was one of the requirements - unfortunately I can't tell anything else about it) while working with Meteor.js application can be a huge pain.

After a very long struggle and juggling between client-side functions and server-side methods I've gave up. 

Apart from pros and cons of Meteor's asynchronous nature I've got couple different problems: 

- it has problems with serving locally saved files on mobile device (I had to use a plugin for changing meteor local path to `file://` one)
- some cordova plugins doesn't recognize my app as cordova project,
- Meteor itself is an another abstraction layer which me as a developer has to handle/deal with,
- application performance could be better,
- debugging can be a little pain (random phone-PC connection problems, live-reload very often doesn't notice code change etc.)

##Intel XDK to the rescue

I've developed couple mobile apps with this tool before, but one day a very bad event occured - Intel's XDK servers went down. I was even unable to compile app and deploy on my test device during the whole work day - that situation outclassed this tool as my solution to mobile app development.

How naive I was.

Summing up all the problems I've got during the mobile app development using Meteor and the time spent on searching after solutions gives me in total way more hours than it would take to develop same app with Intel's tool, even if it would work every other day. 

As an example is this fact: I've completely rewritten and finished (by copying 3/4 of existing code in Meteorjs, which was the 80% of the whole app) my app, which was in develop state for almost 2 months in just ONE DAY. During that day I've copied & modified existing functions from Meteor.js project, added Meteor.js-like functionalities in pure javascript code and added missing functionalities.

And it worked like a charm.


