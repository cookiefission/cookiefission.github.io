---
layout: post
title:  "Thoughts on API versioning"
date:   2016-03-08 12:00:00
categories: rest api
---

There are 3 main ways to version APIs:

- Url versioning e.g: `GET /api/v1/foo`
- Custom header versioning e.g: `GET /api/foo API-Version: 1`
- Accept header versioning e.g: `GET /api/foo Accept: application/vnd.example.foo.v1`

[This article](http://www.troyhunt.com/2014/02/your-api-versioning-is-wrong-which-is.html)
nicely wraps up why none are perfect. However, how to stucture your code internally
is rarely discussed.

I can think of two ways:

- Separate controllers
- Using a 'versioner' to translate data between versions.

Having separate controllers seems to be the defacto way but I don't like it as
it adds a lot of overhead and hacks to the code. Ultimately, you have the same
data source for all versions so the different controllers are acting as versioners
anyway.

With that in mind, I'd like to propose the alternative.

Develop controllers and models as if only the current version exists and back port
any changes to previous versions via versioners.

Benefits over separate controllers:

- Clearer distinctions between versions
- Ability to test transformations between versions

