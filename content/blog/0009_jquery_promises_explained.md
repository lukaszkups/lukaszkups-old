---
kind: article
created_at: 4 February 2015
title: jQuery promises explained
tags: ['blog']
---

#jQuery promises explained

##Warning: this post contains my own thoughts about promises and deferred object and my way of understanding it - maybe it will help someone better understand them or maybe someone doesn't agree with my way of thinking and get even more confused.

#Promises and deferred objects

If You ever wanted create asynchronous functionality for Your web app, then You probably will do it using jQuery's promises and deferred objects.

I'm using deferred objects as a "containers" for anychronous tasks - e.g. 

<pre>
<code class="javascript">
var getSomeData = function(){
    var dfd = $.Deferred(),
        result = getSomeDataViaAsyncAjaxCall();

    dfd.resolve(result);
    return dfd.promise();
});
</code>
</pre>

The `dfd.resolve(result)` contains a kind of promise for us that it will wait till the `result` variable get any value.

The last line of the code above returns the promise object itself - and it's obligate for our `when` method placed below:

<pre>
<code class="javascript">
$.when(getSomeData()).done(function(){
    doSomeFancyThingsWithDataFromAsyncAjaxCall();
});
</code>
</pre>

The `$.when` method wait with its execution till the `getSomeData()` finish (in this case that means it will waito till it get some data and set it to its private `result` variable).

We can of course also chain, nest and combine async functions - let's say that we want acquire some huge amount of data from various sources asynchronously, compute it and then send to the frontend to visualise it to the user: 

<pre>
<code class="javascript">
$.when(getSomeData(), getMoreData(), getEvenMoreData()).done(function(){
    $.when(doSomeFancyThingsWithAcquiredData()).done(function(function(){
        var customFunctionForPromises = function(){
            var dfd = $.deferred(),
                custom_promise1 = doSomeFancyAsyncThingsWithAcquiredData1(),
                custom_promise2 = doSomeFancyAsyncThingsWithAcquiredData2();

            dfd.resolve([custom_promise1, custom_promise2]);
            return dfd.promise();
        };

        $.when(customFunctionForPromises).done(function(){
           updateFrontEndWithAcquiredAsyncData(); 
        };
    });
});
</code>
</pre>

This example should cover most of the use cases of promises for beginners who want to deal with async functions. Personally I'm using it very often when I need to fetch big amount of data from different remote sources.

-- ł.
