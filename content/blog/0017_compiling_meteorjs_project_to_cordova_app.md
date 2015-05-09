---
kind: article
created_at: 9 May 2015
title: Compiling MeteorJS project to Cordova app
tags: ['blog']
---

#Compiling MeteorJS project to Cordova app

As You may already know, MeteorJS enables compiling Your web applications to iOS or Android build (and I'm looking forward for Windows Phone 8 platform support). It is possible thanks to great cordova integration with meteor. Today I would like to share information about the process of building and compiling project to cordova.

First, we need to add to our existing project specific platform (ios or android, or both):

<pre>
<code class="bash">
meteor add-platform ios
meteor add-platform android
</code>
</pre>

If we want to check which platforms are currently installed:

<pre>
<code class="bash">
meteor list-platforms
</code>
</pre>

And if we want to get rid of some platform, we can simply remove it running command below:

<pre>
<code class="bash">
meteor remove-platform &lt;platform_name>
</code>
</pre>

If we want to check status of our app in emulator, type:

<pre>
<code class="bash">
meteor run &lt;platform_name>
</code>
</pre>

##Preparing and building Google-Play-Store-ready project

When we are finished with our app development it's time to compile it and prepare for sending to Google Play Store.

At the beginning, we have to build our app:

<pre>
<code class="bash">
meteor build android --server localhost:3000
</code>
</pre>

Then, enter android folder with built `.apk` file (depends on the system Your working on, the folder path may be different but You should have no problem locating it - it should be somewhere inside Your MeteorJS project folder): 

<pre>
<code class="bash">
cd android/android
</code>
</pre>

Now we have to generate the key for signing our app:

<pre>
<code class="bash">
keytool -genkey -v -keystore &lt;your keystore name>.keystore -alias &lt;your keystore name> -keyalg RSA -keysize 2048 -validity 10000
</code>
</pre>

If everything gone fine, we can sign our app with generated key:

<pre>
<code class="bash">
jarsigner -verbose -keystore &lt;your keystore name>.keystore -signedjar &lt;your target apk file name>.apk &lt;your signed apk file name>.apk &lt;your keystore name>
</code>
</pre>

Now we have signed and properly built android application. Sometimes, during upload to Google Play Store, we can get an error that our app is not packed/compressed enough and we have to fix that.

We can do this, using `zipalign` tool:

<pre>
<code class="bash">
zipalign -f -v 4 &lt;your signed apk file name>.apk &lt;your zipaligned apk file name>.apk
</code>
</pre>

If this command doesn't work for You, probably You need to use the full path to zipalign installation (it may differ depends on operating system):

<pre>
<code class="bash">
~/.meteor/android_bundle/android-sdk/build-tools/20.0.0/zipalign -f -v 4 &lt;your signed apk file name>.apk &lt;your zipaligned apk file name>.apk
</code>
</pre>

And that's it - You can now sent Your application to Google Play Store and collect the glory :)

-- ł.
