---
kind: article
created_at: 7 January 2015
title: Delegated vs direct jQuery .on() method
tags: ['draft']
---

#Delegated vs direct jQuery .on() method

Today I would like to show the difference between `.on()` methods:

- direct:

<pre>
	<code class="javascript">
		$('div span').on('click', function(){
			console.log('booya!');
		});
	</code>
</pre>

- and delegated one:

<pre>
	<code class="javascript">
		$('div').on('click', 'span', function(){
			console.log('booya!');
		});
	</code>
</pre>

The difference in code is very subtle, but in functionality (spoiler alert) delegated version of the code is far more flexible and universal.

## Delgated vs direct === Dynamic vs static

Direct version of jQuery `.on()` method 


http://stackoverflow.com/questions/8110934/direct-vs-delegated-jquery-on