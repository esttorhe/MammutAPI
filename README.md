[![Build Status](https://travis-ci.org/esttorhe/MammutAPI.svg?branch=master)](https://travis-ci.org/esttorhe/MammutAPI) ![](https://img.shields.io/badge/SwiftPackageManager-supported-orange.svg) ![](https://img.shields.io/badge/Linux-supported-blue.svg) [![codecov](https://codecov.io/gh/esttorhe/MammutAPI/branch/master/graph/badge.svg)](https://codecov.io/gh/esttorhe/MammutAPI)

# MammutAPI
🐘Mastodon's Unofficial Swift Framework

This is yet another attempt to create a `Swift` framework for [`Mastodon`][mastodon]'s social network.

I decided to build this because I wanted to create a very specific `iOS` application and at the same time I decided that creating the building blocks for the client should be `OSS` so that everyone can benefit and contribute to it.

<br/>

🚧 The project is still a WIP. I'll be adding a `TODO` down on this file to keep track of what the `API` is capable ATM and thus be able to be used 🚧
===
<br/>

# SwiftPackageManager

​Since I first thought about creating the `API` for [`Mastodon`][mastodon] I always considered making it compatible with `SwiftPackageManager` and `Linux` :penguin: environments.



Because of this the project is being tested on `TravisCI` using a `Linux` image and with:

```console
swift build
swift test
```

# Coverage

![https://codecov.io/gh/esttorhe/MammutAPI](https://codecov.io/gh/esttorhe/MammutAPI/branch/master/graphs/sunburst.svg)

# TODO

There's a [`TODO`][todo] file detailing what endpoints and methods are already covered by this framework

[mastodon]:https://mastodon.social
[todo]:TODO.md
