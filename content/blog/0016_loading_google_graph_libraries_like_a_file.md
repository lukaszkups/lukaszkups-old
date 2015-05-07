---
kind: article
created_at: 7 May 2015
title: Loading google packages without load() method
tags: ['blog']
---

#Loading google packages without load() method

Today I was helping my friend with implementation of google analytics dashboard. The main problem was that he wanted to initialize all the graphs dynamically (via click event, which also had to query google analytics api for data etc.). 

Everything was going fine, till we had to load the google visualisation package. Official documentation suggested using methods below:

<pre>
<code class="javascript">
google.load('visualization', '1', {packages: ['gauge']});
google.setOnLoadCallback(ourGraphDrawFunction);
</code>
</pre>

But our app doesn't really know if package was loaded (basing on documentation in our specific case we had to load the api and package during ajax call or be sure that it will be loaded before, which - doing it via javascript - was causing other errors).

Fortunately, I've got an idea and found a way to load the package like a regular `.js` file:

<pre>
<code class="javascript">
&lt;script type="text/javascript" src="https://www.google.com/jsapi?autoload={'modules':[{'name':'visualization','version':'1','packages':['corechart'],'language':'pl'}]}">&lt;/script>	
</code>
</pre>

And that little hack solved our problem - enjoy!

-- ł.
