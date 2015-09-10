Translation Manager
==========
by iTelo
-------


# Index

1. Description
2. Installation
3. File structure
4. Licence


# 1. Description

Project had been created for iTelo's project [Profitelo](http:///profitelo.pl)

T.B.C.


# 2. Installation

Project is build entirely on javascript and node.js platform. Therefor [npm](https://www.npmjs.com/) and [Bower](http://bower.io/) are used. 

```
git clone git@bitbucket.org:egel/translations-generator.git
cd translations-generator
sudo npm install && sudo npm install -g gulp bower sequelize-cli nodemon
cd frontend && bower install
```


# 3. File structure

* frontend
	* app
	* vendors_offline
	* assets
	* common
		* controllers
		* directives
		* modules
		* services
		* templates
		* translations
* backend
	* models
	* routes
	* controllers
* gulp_src
	* tasks
	* gulpfile.coffee
* app.coffee
* app.js
* Gulpfile.js


# 4. Licence

The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

