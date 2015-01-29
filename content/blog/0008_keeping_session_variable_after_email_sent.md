---
kind: article
created_at: 29 January 2015
title: Handling notifications after email sending.
tags: ['blog']
---

#Emails & notifications

Today I wanted to implement contact form with validation and (alert) notification system. However, I encountered a problem with session variables.

My idea was to set Session variable which stores information about unseen alert notification and get that value after `rendered` template callback:

<pre>
<code class="javascript">
//template event
Template.myContactTemplate.template{(
	'click .submitButton': function(){
		Session.set('alertMessage', ['Email has been sent', 'success']);
		Meteor.call('sendEmail', dataText);
	}
)};

//e-mail method
Meteor.methods({
	sendEmail: function(text){
		check([text], [String]);
		this.unblock();
		Email.send({
			to: 'xyz@xyz.com',
			from: 'contactForm@xyz.com',
			subject: 'New message from contact form',
			text: text
		});
	}
});

//rendered callback
Template.contactFormTemplate.rendered = function(){
	Meteor.defer(function(){
		var a = Session.get('alertMessage');
		if(a){
			throwAlert(a[0], a[1]);	//my custom method for alerts
			Session.set('alertMessage', null);		
		}
	});
}
</code>
</pre>

The code above will not work. I have noticed that email sending method somehow flush/resets our `alertMessage` session variable. To prevent from such behaviour and keep all variables saved let's add [persistent-session](https://github.com/okgrow/meteor-persistent-session) package:

<pre>
<code class="bash">
meteor add u2622:persistent-session
</code>
</pre>

And that's it. Now we can set and get our session variables at any time we want.

You can discuss about this problem at [this stackoverflow thread](http://stackoverflow.com/questions/28084160/session-variable-unset-after-sending-email).

-- ł