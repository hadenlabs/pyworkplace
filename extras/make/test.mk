#
# See ./CONTRIBUTING.rst
#

PATH_DOCKER_COMPOSE:=provision/docker-compose
DOCKER_TEST := docker-compose -f docker-compose.yml -f "${PATH_DOCKER_COMPOSE}"/test.yml

test.help:
	@echo '    Test:'
	@echo ''
	@echo '        test                    Run all test'
	@echo '        test.run                Run test of test'
	@echo '        test.lint               Run all pre-commit'
	@echo '        test.syntax             Run all syntax in code'
	@echo ''

test: clean
	@echo $(MESSAGE) Running tests on the current Python interpreter with coverage $(END)
	$(DOCKER_TEST) run --rm app \
		bash -c "python setup.py test";
	@echo

test.run: clean
	@echo $(MESSAGE) Running tests on the current Python $(END)
	@if [ -z "${test}" ]; then \
		$(DOCKER_TEST) run --rm app \
			bash -c "pytest -s pyworkplace tests"; \
	else \
		$(DOCKER_TEST) run --rm app \
			bash -c "pytest -s -v tests/${test}"; \
	fi

test.lint: clean
	$(docker-compose) -f ${PATH_DOCKER_COMPOSE}/dev.yml \
		run --rm check bash -c "pre-commit run --all-files --verbose"

test.syntax: clean
	@echo $(MESSAGE) Running tests $(END)