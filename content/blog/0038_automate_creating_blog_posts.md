---
kind: article
created_at: 15 January 2016
title: Automate creating blog posts
tags: ["blog"]
---

#Automate creating blog posts

##Occasionally I write simple bash scripts to automate my everyday tasks - this time I've automated generating new blog post file for my nanoc-based blog.

Straight to the point - here's the script which You can put inside Your `~/.bashrc` file:

~~~bash

function blogpost() {
  filename=${1}".md";
  cd "content/blog";
  date=$(date +"%d %B %Y");
  counter=$(ls -l | grep ^- | wc -l);
  counter=$((counter+1));
  i10=10;
  i100=100;
  i1000=1000;
  if [ $i10 -gt $counter ]; then
    counter="000$counter";
  elif [ $i100 -gt $counter ]; then
    counter="00$counter";
  elif [ $i1000 -gt $counter ]; then
    counter="0$counter";
  fi  
  filename=$counter"_"$filename;
  touch "$filename";
  content='---\nkind: article\ncreated_at: '$date'\ntitle: '${1}'\ntags: ["blog"]\n---\n\n';
  echo -e $content > "$filename";
  cd "../..";
  echo "==============";
  echo "blog post ${1} created";
  echo "==============";
}
~~~

I think the code is pretty straighforward (if You have any questions, feel free to [ask!](http://twitter.com/lukaszkups))

Usage:

~~~bash

blogpost MyBlogPostName
~~~

Don't forget to run `source` command after saving changes in Your `~/.bashrc` file:

~~~bash

source ~/.bashrc
~~~

Enjoy!

--ł.
