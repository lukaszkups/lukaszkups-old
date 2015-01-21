---
kind: article
created_at: 18 January 2015
title: Deploying Meteor.js project to own server (via ssh)
tags: ['blog']
---

#Deploying Meteor.js project to own server (via ssh)

Today I've spent most time of the day on figuring out how to deploy an Meteor.js app to own server via ssh.

Disclaimer: I'm a programmer guy - not a serveradmin magician one. So please calm down, be polite and eventually send me an email if You see something wrong in this article ;)

##Ssh login and basic server setup

First, login to Your server via ssh:

<pre>
<code class="bash">
ssh yourServerLogin@yourServerIp
</code>
</pre>

When prompted, type Your server password and process to server connection.

<pre>
<code class="bash">
sudo apt-get update
sudo apt-get install nginx
</code>
</pre>

Now You can manage nginx processes with these commands:

<pre>
<code class="bash">
sudo service nginx stop
sudo service nginx start
sudo service nginx restart
</code>
</pre>

##Node.js installation

Let's install Node.js environment, which is required to run our app:

<pre>
<code class="bash">
sudo apt-get update
sudo apt-get install upgrade
sudo apt-get install nodejs
</code>
</pre>

If You'll want install particular version of Node.js You probably will want to do it via [NVM](https://github.com/creationix/nvm) (Node Version Manager):

<pre>
<code class="bash">
sudo apt-get install npm		
</code>
</pre> 

##Mongo database

As You probably know, Meteor.js uses [MongoDB](http://www.mongodb.org/) as its main database system so let's prepare our server to [deal with it](http://wac.450f.edgecastcdn.net/80450F/thefw.com/files/2013/05/Nicholson.gif):

<pre>
<code class="bash">
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update
sudo apt-get install mongodb-10gen
</code>
</pre>

Now start mongoDB as a Daemon with log records file:

<pre>
<code class="bash">
mongod --fork --logpath /var/log/mongodb.log
</code>
</pre>

The next thing is to add a **system-wide** MongoDB admin role:

<pre>
<code class="bash">
mongo
db = db.getSiblingDB('admin')
db.createUser({user: 'admin', pwd: 'yourAdminPassword', roles: ['userAdminAnyDatabase']})
exit		
</code>
</pre>

In the next step, we need to edit MongoDB configuration file and uncomment following line:

<pre>
<code class="bash">
#file path: /etc/mongodb.conf
auth = true
</code>
</pre>

And then restart the MongoDB server:

<pre>
<code class="bash">
sudo service mongodb restart
</code>
</pre>

The final (mongo related) step will be adding admin role to our **application** database. First, we need to login to our MongoDB admin account:

<pre>
<code class="bash">
mongo -u admin -p --authenticationDatabase admin
</code>
</pre>

You will be asked for the password that You've set at one of the previous steps. After that You can create user and database for Your app:

<pre>
<code class="bash">
use yourAppDatabaseName
db.createUser({ user: 'yourAppDbUserName', pwd: 'yourSuperSecureDbAppUserPassword', roles: [ 'readWrite' ] })
</code>
</pre>

##Let's get back to Nginx

Now we have to configure Nginx for our application - let's create configuration file for Your app:

<pre>
<code class="bash">
touch /etc/nginx/sites-available/yourApp.com
</code>
</pre>

And here's the example code of this file:

<pre>
<code class="bash">
upstream yourApp {  
    server 127.0.0.1:3000;
}

server {  
    listen 0.0.0.0:3000;
    server_name yourApp.com;
    access_log /var/log/nginx/yourApp.log;

    location / {
        proxy_pass http://yourApp/;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $http_host;

        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forward-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forward-Proto http;
        proxy_set_header X-Nginx-Proxy true;

        proxy_redirect off;
    }
}
</code>
</pre>

Now, You have to create symbolic link for this file:

<pre>
<code class="bash">
sudo ln -s /etc/nginx/sites-available/yourApp.com /etc/nginx/sites-enabled/yourApp.com
</code>
</pre>

And then, You can restart Nginx:

<pre>
<code class="bash">
sudo service nginx restart
</code>
</pre>

##Deployment stage

Let's finally deploy our application. Login to your server via ssh and clone Your app repo:

<pre>
<code class="bash">
cd /usr/local/www/
git clone yourAppGitCloneUrl
cd yourClonedAppFolder
</code>
</pre>

Now, install [Meteor.js](http://meteor.com) and bundle Your app - we're doing it on server because sometimes bundling app between different operating system (like osx and ubuntu linux) can cause errors with node modules (e.g. bcrypt).

<pre>
<code class="bash">
curl https://install.meteor.com/ | sh
meteor bundle yourAppName.com.tar.gz
</code>
</pre>

Move Your (bundled) app to proper directory and unpack it:

<pre>
<code class="bash">
mv yourAppName.com.tar.gz ../
tar -vxzf yourAppName.com.tar.gz
rm yourAppName.com.tar.gz
</code>
</pre>

Now, to keep our app always live, let's install [forever](https://github.com/foreverjs/forever):

<pre>
<code class="bash">
sudo npm install -g forever
</code>
</pre>

Finally, we can plug in our app to Mongo database and run it, using forever:

<pre>
<code class="bash">
cd yourAppName.com
PORT=3000 MONGO_URL=mongodb://yourAppAdminUserName:adminPassword@127.0.0.1:27017/yourAppName ROOT_URL=http://yourAppName.com forever -f start main.js
</code>
</pre>

And your application is live now. You can check its status every time by following command:

<pre>
<code class="bash">
forever list
# an example result:
info:    Forever processes running
data:        uid  		command             		script      		forever pid   id 	logfile                 		uptime        
data:    	[0] H74M 	userdown            		app/main.js 	56789   12345    	/root/.forever/zxy.log 	0:0:0:0.788   
data:    	[1] uv8C 		/usr/local/bin/node 	main.js     	65432   23456    	/root/.forever/xyz.log 	2:2:50:36.647 
</code>
</pre>

You can restart any forever process with command:

<pre>
<code class="bash">
#forever restart uid e.g.
forever restart 1
</code>
</pre>

And that's practically all. Special thanks to guys from [gentlenode](https://gentlenode.com/) who wrote very similar blog post, which was an inspiration for writing this one (I've added couple own tips, but also rewrite most stuff to make sure that I will always have access to this knowledge).

If You have any questions - feel free to [ask](http://twitter.com/ofcapl).

-- ł