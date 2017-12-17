
BOWER_DIR=res/bower_components

server: tools res/vul/elements.html
	go install -v ./go/server

run: server
	server --alsologtostderr

tools: $(BOWER_DIR)/lastupdate node_modules/lastupdate

$(BOWER_DIR)/lastupdate: bower.json ./node_modules/.bin/bower
	./node_modules/.bin/bower update
	touch $(BOWER_DIR)/lastupdate

# The debug_elements_html target just copies elements.html into res/vul/elements.html.
debug_elements_html:
	-mkdir res/vul
	cp elements.html res/vul/elements.html

res/vul/elements.html: res/imp/*.html elements.html ./node_modules/.bin/vulcanize
	./vulcanize.sh

#### clean_webtools ####

clean_webtools:
	-rm res/vul/elements.html

#### Rules to npm install needed tools ####

./node_modules/.bin/vulcanize:
	npm install vulcanize --save-dev
	npm install html-minifier --save-dev

./node_modules/.bin/bower:
	npm install bower --save-dev

#### npm install dependencies ####

node_modules/lastupdate: package.json
	npm install
	touch node_modules/lastupdate

