---
kind: article
created_at: 6 May 2015
title: Getting value from bootstrap's date inputs
tags: ['blog']
---

#Getting value from bootstrap's date inputs

Today my friend asked me how to get the value (date) from bootstrap's date input. My first thought was like:

<pre>
	<code class="javascript">
	    var myDate = $('input').val();
	</code>
</pre>

But instead of value I've got "" (an empty string). I've inspected the input element in DOM and it was actually right behaviour - that input had no value.

Luckily, after little search I've found the solution:

<pre>
    <code class="javascript">
        var myDate = $('input').data('date');
    </code>
</pre>

And that's it - enjoy!

-- ł.
