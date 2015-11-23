# Translation Manager 
[![Build Status][travis-ci-image]][travis-ci-project-website]
[![Built with Gulp][gulpjs-image]][gulpjs-website]
[![Stories in Ready][waffle-io-image]][waffle-io-project-website]
> by iTelo

Main goal of this project is to provide all neccessary features to store,
maintain, manage and deploy translations for your projects. It should help you
and your teams (developers, translators, PR and management) to cooperate with
each other and tons of translations.


## Table of contents
* [Installation](#installation)
  * [Requirements](#requirements)
  * [Setup](#setup)
* [Development](#development)
* [Licence](#license)


## Installation
Project is build entirely with javascript, backend based on [node.js][nodejs-website]
and platform and frontend part becongs to AngularJS.  Therefor
[npm](https://www.npmjs.com/) and [Bower](http://bower.io/) are used.

### Requirements
Before [setup](#setup) you need to have few programs already installed on your
machine, and these programs are:
- [node.js][nodejs-website]

### Setup
> Latest node.js is recommended for development (4.0.0 or higher).

Simply update using NPM ([how to set up node.js](https://docs.npmjs.com/getting-started/installing-node))

```
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
```

or using [`nvm`][nvm-github] (recommended)
```
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.28.0/install.sh | bash
nvm install 4
nvm use 4
```


Then clone the repo and install all requirements

```
sudo apt-get install build-essential
sudo npm install -g gulp bower sequelize-cli groc # for global install may need sudo

git clone git@github.com:Contactis/translations-manager.git
cd translations-manager
npm install   # should install without sudo
cd frontend && bower install
```

then build and run environment

```
gulp db:restore  # build and seed database
gulp production  # build, run tests and deploy the project for production
```

Open browser on: http://127.0.0.1:3000/

Enjoy the awesome :)


## Development
All official things that is combined with development process like: app
structure, frontend and backend side and other elaboration stuff are gathered in part called [**development**][wiki-development] into our Wiki pages.  
To see more visit our [wiki pages][wiki].




## Licence
```
The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```


[nvm-github]: https://github.com/creationix/nvm
[gulpjs-website]: http://www.gulpjs.com
[nodejs-website]: https://nodejs.org
[wiki]: https://github.com/Contactis/translations-manager/wiki
[wiki-development]: https://github.com/Contactis/translations-manager/wiki/Development
[travis-ci-project-website]: https://travis-ci.org/Contactis/translations-manager 
[waffle-io-project-website]: http://waffle.io/Contactis/translations-manager

[waffle-io-image]: https://badge.waffle.io/Contactis/translations-manager.svg?label=ready&title=Ready
[travis-ci-image]: https://travis-ci.org/Contactis/translations-manager.svg?branch=develop
[gulpjs-image]: https://img.shields.io/badge/build%20with-gulp.js-green.svg
[build-with-gulp-image]: https://raw.githubusercontent.com/gulpjs/gulp/e2dd2b6c66409f59082c24585c6989244793d132/built-with-gulp.png
