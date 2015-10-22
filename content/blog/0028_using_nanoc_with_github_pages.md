---
kind: article
created_at: 22 November 2015
title: Using nanoc with github pages
tags: ['blog']
---

This guide is based on the originally posted article on ![Schmurfy's blog](http://schmurfy.github.io/2011/05/06/create_your_github_user_page_with_nanoc.html) - I've modified it for current github pages flow.

First, clone Your repository to Your local disk and enter it:

~~~bash

git clone yourRepoCloneUrl
cd yourRepoFolder
~~~

Now, if You don't have `output` folder yet create it, then clone Your repo again into nanoc's this directory:

~~~bash

mkdir output
git clone yourRepoCloneUrl output
~~~

Now let's enter this folder and create isolated (orphan) branch, `gh-pages`:

~~~bash

cd output
git checkout --orphan gh-pages
~~~

Now we have to clean all the contents from our `output` folder git:

~~~bash

git rm -rf .
~~~

Now re-check if You are on `gh-pages` branch - there's possibility that You're now on detached state so:

~~~bash

git checkout gh-pages
~~~ 

And to avoid problems in the future, remove the `master` branch from the `output` folder:

~~~bash

git branch -d master
~~~

Everything should be set here, so now enter the main project folder and try to compile it:

~~~bash

cd ..
nanoc aco
~~~
