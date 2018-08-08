#
# See ./CONTRIBUTING.rst
#

PATH_DOCKER_COMPOSE:=provision/docker-compose
DOCKER_TEST := docker-compose -f docker-compose.yml -f "${PATH_DOCKER_COMPOSE}"/test.yml

pytest.help:
	@echo '    PyTest:'
	@echo ''
	@echo '        pytest                    Run all test'
	@echo '        pytest.run                Run test of pytest'
	@echo ''

pytest: clean
	@echo $(MESSAGE) Running tests on the current Python interpreter with coverage $(END)
	$(DOCKER_TEST) run --rm app \
		bash -c "python setup.py test";
	@echo

pytest.run: clean
	@echo $(MESSAGE) Running tests on the current Python $(END)
	@if [ -z "${test}" ]; then \
		$(DOCKER_TEST) run --rm app \
			bash -c "py.test -s pyworkplace tests"; \
	else \
		$(DOCKER_TEST) run --rm app \
			bash -c "py.test -s -v tests/${test}"; \
	fi
