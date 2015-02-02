---
kind: article
created_at: 21 January 2015
title: Shorten strings with spacebar helper
tags: ['blog']
---

#Shorten Your title/name/link(You name it!) strings with spacebar helper

If You're building some lists view (e.g. posts list) and You want to shorten their names You can achieve that using this UI helper:

<pre>
<code class="javascript">
UI.registerHelper('shortIt', function(stringToShorten, maxCharsAmount){
	var shorter = stringToShorten.substr(0, maxCharsAmount);

	shorter = shorter.substr(0, Math.min(shorter.length, shorter.lastIndexOf(' '))) + '...';
	return shorter;
});
</code>
</pre>

It will cut the string to the (whole) word placed after last space character.

Usage:

<pre>
<code class="haml">
{{#each PostList}}
	{{shortIt this.title 15}}
{{/each}}
</code>
</pre>

And that's it! Enjoy!

(You can read this article also at [my coderwall's protips section](https://coderwall.com/p/nz63bg/meteor-shorten-string-spacebar-helper))

-- ł.