---
layout: post
title:  "Ruby's Object Model"
date:   2015-10-02 13:17:16
categories: ruby
---

## Inheritance Hierarchy

By default, Ruby classes inherit directly from `Object`:

{% highlight ruby %}
class Foo; end

puts Foo.ancestors.inspect
# => [Foo, Object, Kernel, BasicObject]
{% endhighlight %}

`Foo.ancestors.inspect` shows us that `Foo` inherits from `Object`.

### Effects of

#### `include`

Include a modules methods as _instance_ methods in the current `Module`/`Class`

{% highlight ruby %}
module Foo
  def bar
    puts "bar"
  end
end

class Bar
  include Foo
end

Bar.new.bar
# => "bar"
{% endhighlight %}

#### `extend`

Include a modules methods as _class_ methods in the current `Module`/`Class`

{% highlight ruby %}
module Foo
  def bar
    puts "bar"
  end
end

class Bar
  extend Foo
end

Bar.bar
# => "bar"
{% endhighlight %}

#### `prepend`

- Prepend the module to the class's ancestry
- Prepended modules methods can't be (acidentally) overwritten (unlike included modules)

{% highlight ruby %}
module Foo
  def bar
    puts "bar in Foo"
  end
end

class Bar
  prepend Foo

  def bar
    puts "bar in Bar"
  end
end

Bar.new.bar
# => "bar in Foo"
{% endhighlight %}

#### `super`

Calls the parent classes version of the current method

{% highlight ruby %}
class Foo
  def bar
    "foo"
  end
end

class Bar < Foo
  def bar
    "bar " + super
  end
end

puts Bar.new.bar
# => "bar foo"
{% endhighlight %}

## Method Dispatch

Ruby looks up methods in the following order:

1. Methods defined in the object's singleton class (i.e. the object itself)
2. Modules mixed into the singleton class in reverse order of inclusion
3. Methods defined by the object's class
4. Modules included into the object's class in reverse order of inclusion
5. Methods defined by the object's superclass, i.e. inherited methods

## Sources / Things to look at

Practicing Ruby:
- [Method lookup: Part 1](https://practicingruby.com/articles/method-lookup-1)
- [Method lookup: Part 2](https://practicingruby.com/articles/method-lookup-2)

Misc Blogs:
- [How ruby method dispatching works](https://blog.jcoglan.com/2013/05/08/how-ruby-method-dispatch-works)
