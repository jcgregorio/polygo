
BOWER_DIR=res/bower_components

default: elements_html
	go install -v ./go/server


$(BOWER_DIR)/lastupdate: bower.json ./node_modules/.bin/bower
	./node_modules/.bin/bower update
	ln -sf ../../$(BOWER_DIR) res/imp/bower_components
	touch $(BOWER_DIR)/lastupdate

#### elements_html ####

# The elements_html target builds a vulcanized res/vul/elements.html from
# elements.html.
elements_html: res/vul/elements.html

# The debug_elements_html target just copies elements.html into res/vul/elements.html.
debug_elements_html:
	-mkdir res/vul
	cp elements.html res/vul/elements.html
	ln -sf ../../$(BOWER_DIR) res/imp/bower_components

res/vul/elements.html: res/imp/*.html elements.html ./node_modules/.bin/vulcanize
	./vulcanize.sh

#### clean_webtools ####

clean_webtools:
	-rm res/vul/elements.html
	-rm res/js/core.js
	-rm res/js/core-debug.js

#### Rules to npm install needed tools ####

./node_modules/.bin/vulcanize:
	npm install vulcanize --save-dev
	npm install html-minifier --save-dev

./node_modules/.bin/bower:
	npm install bower --save-dev

./node_modules/.bin/uglifyjs:
	npm install uglify-js --save-dev

#### npm install dependencies ####

node_modules/lastupdate: package.json
	npm install
	touch node_modules/lastupdate

