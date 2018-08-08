#
# See ./CONTRIBUTING.rst
#
PATH_DOCKER_COMPOSE:=provision/docker-compose
DOCKER_TRANSLATE := docker-compose -f docker-compose.yml -f "${PATH_DOCKER_COMPOSE}"/dev.yml

translate: translate.help

translate.help:
	@echo '    Translate:'
	@echo ''
	@echo '        translate.extract        extract strings to be translated, outputting .mo files'
	@echo '        translate.compile        compile translate files, outputting .po files for each supported language Make documentation html'
	@echo '        translate.detect_changed translate files, outputting .po files for each supported language Make documentation html'
	@echo '        translate.dummy          generate dummy translate (.po) files'
	@echo '        translate.build          generate and compile dummy translate files'
	@echo '        translate.validate       validate translates'
	@echo ''

translate.extract:
	@rm -rf docs/_build
	$(DOCKER_TRANSLATE) run --rm app \
		bash -c "python manage.py makemessages -l en -v1 -d django && python manage.py makemessages -l en -v1 -d djangojs ";

translate.compile:
	$(DOCKER_TRANSLATE) run --rm app \
		bash -c "python manage.py compilemessages";

translate.detect_changed: 
	$(DOCKER_TRANSLATE) run --rm app \
		bash -c "cd ${PROJECT} && i18n_tool changed";

translate.dummy:
	$(DOCKER_TRANSLATE) run --rm app \
		bash -c "cd ${PROJECT} && i18n_tool dummy";

translate.build: translate.extract translate.dummy translate.compile

translate.validate: translate.build translate.detect_changed
