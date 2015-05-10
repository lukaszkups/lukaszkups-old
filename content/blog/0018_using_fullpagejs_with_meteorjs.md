---
kind: article
created_at: 10 May 2015
title: Using Fullpage.js with MeteorJS
tags: ['blog']
---

#Using Fullpage.js with MeteorJS

If You ever wanted to make a website with full screen resolution sizes, You can use a [fullpage.js](http://alvarotrigo.com/fullPage/) plugin (it has even own [atmosphere package](https://atmospherejs.com/lawshe/full-page)). 

##Installation

We will install fullpage.js as a MeteorJS package directly from atmosphere:

<pre>
<code class="bash">
meteor add add lawshe:full-page
</code>
</pre>

Now we have to prepare our templates for fullpage.js usage. Basing on documentation our template should have similiar structure to this:

<pre>
<code class="html">
&lt;div id="fullpage">
    &lt;div class="section">&lt;!-- place your section content here -->&lt;/div>
    &lt;div class="section">&lt;!-- place your section content here -->&lt;/div>
    &lt;div class="section">&lt;!-- place your section content here -->&lt;/div>
    &lt;div class="section">&lt;!-- place your section content here -->&lt;/div>
&lt;/div>
</code>
</pre>

##Initialization

At this moment, our project should have fullpage.js installed, so we can initialize it on the desired view:

<pre>
<code class="javascript">
Template.yourTemplateName.rendered = function() {
    $('#fullpage').fullpage({
        verticalCentered: false,
        crollOverflow: false
    });
}
</code>
</pre>

And that's it - our webpage should have fullpage.js functionality!

##Problems

If we want to have fullpage.js initialized at multiple views, then we can encounter a problem. 

Fullpage.js will initialize multiple times when user leave one page with fullpage.js initialized and enter another with same functionality. As a result, page will "jump" on scroll in different directions or through multiple sections at once.

To fix that, we simply should add code below to our `/lib/router.js` file:

<pre>
<code class="javascript">
Router.onBeforeAction(function(){
    $.fn.fullpage.destroy();
});
</code>
</pre>

It will destroy existing fullpage.js instance, so new one will work properly :) Enjoy!

-- ł.
