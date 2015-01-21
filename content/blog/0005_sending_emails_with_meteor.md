---
kind: article
created_at: 12 January 2015
title: Sending emails with Meteor.js
tags: ['blog']
---

#Sending emails with Meteor.js

##This is a personal wrap-up explanation of the code available in [official Meteor.js documentation](http://docs.meteor.com)

Today I had to implement contact form for one of my Meteor.js project. At first I've jumped to official Meteor.js documentation and analyse email mechanics.

At the beginning, we have to install `email` package (via terminal):

<pre>
<code class="bash">
meteor add email
</code>
</pre>

Next, we need to declare our email settings - to do that, let's create a `server/smtp.js` file:

<pre>
<code class="javascript">
Meteor.startup(function(){
	process.env.MAIL_URL = smtp://email_username:email_password@email_host:email_port/
});
</code>
</pre>

Example for gmail:

<pre>
<code class="javascript">
Meteor.startup(function(){
	process.env.MAIL_URL = smtp://boo.foo:superDooperPassword@smtp.gmail.com:587/
});
</code>
</pre>

We can also use custom domain email account:

<pre>
<code class="javascript">
Meteor.startup(function(){
	process.env.MAIL_URL = smtp://boo.foo@awesomedomain.com:superDooperPassword@smtp.gmail.com:587/
});
</code>
</pre>

After everything is set, let's register actual sending method, available for client (but declared on server so place code below somewhere under `server/` folder):

<pre>
<code class="javascript">
// In your server code: define a method that the client can call
Meteor.methods({
  sendEmail: function (to, from, subject, text) {
    check([to, from, subject, text], [String]);

    // Let other method calls from the same client start running,
    // without waiting for the email sending to complete.
    this.unblock();

    //actual email sending method
    Email.send({
      to: to,
      from: from,
      subject: subject,
      text: text
    });
  }
});
</code>
</pre>

Those function arguments are of course optional - we can also add `cc`, `bcc`, `Reply-To`, `html` or `headers`.

My example for contact form:

<pre>
<code class="javascript">
Meteor.methods({
  sendEmail: function (text) {
    check([text], [String]);

    this.unblock();

    Email.send({
      to: 'support@myClientProject.com',
      from: 'contact@myClientProject.com',
      subject: 'New message from contact form',
      text: text
    });
  }
});
</code>
</pre>

After we declared our server method, let's create actual sending event:

<pre>
<code class="javascript">
Template.contactFormTemplate.events({
	'submit form#contactForm':function(e){
		var contactForm = $(e.currentTarget),
			fname = contactForm.find('#firstName').val(),
			lname = contactForm.find('#lastName').val(),
			email = contactForm.find('#email').val(),
			phone = contactForm.find('#phone').val(),
			message = contactForm.find("#message").val();

		//isFilled and isEmail are my helper methods, which checks if variable exists or is email address valid
		if(isFilled(fname) && isFilled(lname) && isFilled(email) && isFilled(phone) && isFilled(message) && isEmail(email)){
			var dataText = "Message from: " + fname + " " + lname + "\rEmail: " + email + "\rPhone: " + phone + "\rContent:</br>" + message;

			Meteor.call('sendEmail', dataText);
			//throwAlert is my helper method which creates popup with message
			throwAlert('Email send.', 'success');
		}else{
			throwAlert('An error occurred. Sorry', 'error');
			return false;
		}
	}
});
</code>
</pre>

Besides of code above, You need of course some html template code:

<pre>
<code class="html">
&lt;template name="contactFormTemplate">
	&lt;form id="contactForm">
		&lt;type="text" name="firstName" id="firstName" placeholder="First name"/>
		&lt;type="text" name="lastName" id="lastName" placeholder="last name"/>
		&lt;type="text" name="phone" id="phone" placeholder="Phone number"/>
		&lt;type="email" name="email" id="email" placeholder="Your email address"/>
		&lt;textarea id="message">&lt; /textarea>
		&lt;type="submit" value="Send"/>
	&lt;/form>
&lt;/template>
</code>
</pre>

And that's all - it was THAT easy. You can now add `{{> contactFormTemplate}}` tag to any template You want and enjoy Your awesome contact form.

-- ł.