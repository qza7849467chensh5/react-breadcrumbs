BIN = ./node_modules/.bin
uglify = /usr/local/lib/node_modules/uglify-js/bin/uglifyjs

install link:
	@npm $@

test:
	@$(BIN)/mocha -t 5000 -b -R spec spec.js

lint:
	jsxhint -c .jshintrc ./index.js

patch: lint test
	@$(call release,patch)

minor: lint test
	@$(call release,minor)

major: lint test
	@$(call release,major)

publish:
	@$(uglify) index.js > dist/react-breadcrumbs.min.js
	git commit -am "new release" --allow-empty
	git push --tags origin HEAD:master
	npm publish

define release
	npm version $(1)
endef
