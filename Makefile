NODE_MODULES    = ./node_modules/.bin/
LESS_BIN        = $(NODE_MODULES)lessc
JADE_BIN        = $(NODE_MODULES)jade
COFFEE_BIN      = $(NODE_MODULES)coffee
UGLIFY_BIN      = $(NODE_MODULES)uglifyjs
MAPCAT_BIN      = $(NODE_MODULES)mapcat
OUTPUT_FOLDER   = ./app
LESS_FLAGS      = --no-color
INPUT_FOLDER    = ./src
FILE_NAME       = app.js
OUTPUT_FILE     = $(OUTPUT_FOLDER)/scripts/$(FILE_NAME)
COFFEE_FILES    = $(shell find $(INPUT_FOLDER) -type f -name *.coffee)
TEMPLATE_FILES  = $(shell find ./template/partials -type f -name *.jade)

all: html coffee style

full: all javascript

javascript:
	cp src/lib/angular.js $(OUTPUT_FOLDER)/scripts/angular.js
	$(UGLIFY_BIN) src/lib/angular.js --compress --mangle > $(OUTPUT_FOLDER)/scripts/angular.min.js
	$(UGLIFY_BIN) node_modules/async/lib/async.js --compress --mangle > $(OUTPUT_FOLDER)/scripts/async.min.js

coffee:
	$(COFFEE_BIN) --bare --compile --map $(COFFEE_FILES)
	$(MAPCAT_BIN) $(COFFEE_FILES:.coffee=.map) --jsout $(OUTPUT_FILE) --mapout $(OUTPUT_FILE:.js=.map)
	-@rm $(COFFEE_FILES:.coffee=.map) $(COFFEE_FILES:.coffee=.js)
	$(UGLIFY_BIN) --compress --mangle \
		--in-source-map $(OUTPUT_FILE:.js=.map) \
		--source-map $(OUTPUT_FILE:.js=.min.map) \
		--output $(OUTPUT_FILE:.js=.min.js) \
		--source-map-url $(OUTPUT_FILE:$(OUTPUT_FOLDER)/%.js=%.min.map) \
		--source-map-root file://$(shell pwd)/$(OUTPUT_FOLDER)

style:
	$(LESS_BIN) -O2 -x --yui-compress ./template/style/style.less --include-path=./template/lib/ > ./app/style/style.css

html:
	$(JADE_BIN) ./template/index.jade --out $(OUTPUT_FOLDER)
	-@mkdir $(OUTPUT_FOLDER)/partials
	$(JADE_BIN) $(JADE_FLAGS) $(TEMPLATE_FILES) --out $(OUTPUT_FOLDER)/partials

test:
	./scripts/test.sh

server:
	./scripts/server.sh

clean:
	-@rm -rf app/partials
	-@rm -f app//*.html
	-@rm -f app/style/*.css
	-@rm -f app/scripts/*.*

.PHONY: style html coffee javascript clean test server
