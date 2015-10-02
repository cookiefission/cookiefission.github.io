---
layout: post
title:  "Git: Roll your own VCS"
date:   2015-10-02 12:45:11
categories: git internals
---

Early versions of Git (<1.5) were not a complete version control system; instead,
they were a series of commands for manipulating the underlying commit graph.
The legacy of these beginnings means Git has various 'plumbing' commands; commands
which manipulate git objects directly.

For example, it's possible to write anything as a commit object\*:

{% highlight sh %}
$ echo 'test object' | git hash-object -w --stdin
67f68f0f4dae5755e1970efd93d6e2630e00fc3d
$ git cat-file -p 67f68f0f4dae5755e1970efd93d6e2630e00fc3d
test object
{% endhighlight %}

This, obviously, works for files as well:

{% highlight sh %}
$ echo 'test file' > test.txt
$ git hash-object -w test.txt
16b14f5da9e2fcd6f3f38cc9e584cef2f3c90ebe
$ git cat-file -p 16b14f5da9e2fcd6f3f38cc9e584cef2f3c90ebe
test file
{% endhighlight %}

Using `git hash-object` in this way creates a **blob** which contains the contents
of `test.txt` compressed with zlib; this **blob** is written to disk with a sha1
of the contents as the file name.

Before you can commit this file to the repository, it needs to be added to the
index:

{% highlight sh %}
$ git update-index --add --cacheinfo 100644 16b14f5da9e2fcd6f3f38cc9e584cef2f3c90ebe test.txt
{% endhighlight %}

A git commit is a pointer to a **tree** object along with some meta information e.g
time and committer details. Obviously, this means a **tree** object needs to exist
before a commit can be made.
To create a **tree** object:

{% highlight sh %}
$ git write-tree
85a2934a71f7385034f934f9ccc8c746b73d4f44
{% endhighlight %}

Then to create the commit:

{% highlight sh %}
$ echo 'first commit' | git commit-tree 85a2934a71f7385034f934f9ccc8c746b73d4f44
d64d34ea5a07748eccb905ce6b57313350e0560c
{% endhighlight %}

Finally, to point `master` to this commit:

{% highlight sh %}
git update-ref refs/heads/master d64d34ea5a07748eccb905ce6b57313350e0560c
{% endhighlight %}

Fortunately, all of the above is equivalent to:

{% highlight sh %}
$ echo 'test file' > test.txt
$ git add test.txt
$ git commit -m 'first commit'
{% endhighlight %}

\* This ultimately means you can use Git for purposes other than version control
but that's another topic entirely.

#### Summary

Aren't you glad that modern versions of Git have porcelain commands as well.
