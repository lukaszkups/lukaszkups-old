---
kind: article
created_at: 24 February 2015
title: Bjqs slider responsiveness hack
tags: ['blog']
---

#Bjqs slider responsiveness hack

[bjqs slider](http://www.basic-slider.com/) is one of my favorite slider plugin. It is really easy to use and customize for various needs.

##The problem with plugin appears, when we want to make it responsive (e.g. on full screen width)

Slider becomes laggy and doesn't scale slides properly. But I've managed to hack the solution for this little bug.

When You're initializing the plugin, You can define the dimensions (`width` and `height`) of the slider - and You should define there the largest possible value for it. At the same time, it will be the maximum size of the single slide. This value should equal Your device's parameters:

<pre>
<code class="javascript">
$('#mySlider').bjqs({
    ...
    width: window.screen.width,
    responsive: true,
    ...
});
</code>
</pre>

After plugin initialization, we should trigger the `resize` event on page (because if active browser window won't be in maximized mode, then slider will be bigger and not visible in 100%):

<pre>
<code class="javascript">
$(window).trigger('resize');
</code>
</pre>

PS. In case You are using slider pagination bullets and You want to keep them centered horizontally, then You should add this code before triggering the `resize` event:

<pre>
<code class="javascript">
$(window).resize(function(){
    $('#mySlider .bjq-markers.h-centered').css({'left':0});
});
</code>
</pre>

This solution works on firefox & chrome - not tested with IE & other stuff - if You have any info about it, please [tweet about it  to me](http://twitter.com/lukaskups).


-- ł.
