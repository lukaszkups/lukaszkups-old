---
kind: article
created_at: 9 January 2015
title: introducing Scaffolder (scfld)
tags: ['blog']
---

#Scfld - simple, bash-based scaffold generator for Meteor.js

##At the beginning was bash.

Couple weeks ago I wanted to learn bash syntax a bit. For some time I was thinking about project example, which could be a challenge during bash learning. 

I decided to build simple scaffold generator for meteor.js apps because I wasted too many hours writing over and over again same HTML templates or basic meteor.js functions. Scfld generates basic set of files for desired collection:

- `/client/controllers/collectionName/collectionName.js`
- `/client/templates/collectionName/collectionName.html`
- `/lib/collectionNameRouter.js`
- `/server/models/collectionName.js`

Scaffolder supports (or will support in the future) the following field types:

- `string`
- `date`
- `number`
- `email`
- `textarea`
- `checkbox (not ready yet)`
- `password (not ready yet)`
- `radio (not ready yet)`
- `checkbox_collection (checkbox list that automatically takes all values from other collection objects - not ready yet)`
- `radio_collection (radio list that automatically takes all values from other coll1ection objects - not ready yet)`

Once ran, it creates collection declarations, front-end and back-end for collection document creation, edition and removal.

##Straightforward & simplicity

Its logic and way of implementation could look really dumb for experienced bash users but hey - it does its job and that was the main assumption of this mini-project.

You can browse the code at [this github repo](https://github.com/ofcapl/scaffolder) - remember it was made just for fun & has still unfinished code. 

##Use the force

Here's the usage of the plugin:

<pre>
	<code class="bash">
		scfld collectionName field1:type field2:type ... fieldX:type
	</code>
</pre>

##Example

Just open terminal, go to meteor.js project folder and type:

<pre>
	<code class="bash">
		bash scfld student firstName:string lastName:string bio:textarea birth:date grade:number 
	</code>
</pre>

And let the magic happen, enjoy!

-- ł.