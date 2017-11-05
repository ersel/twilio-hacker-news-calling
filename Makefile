check-venv:
	@if test -z "$(VIRTUAL_ENV)"; then echo "You should activate virtualenv"; exit 1; fi

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f  {} +

run: check-venv
	python manage.py runserver $(filter-out $@,$(MAKECMDGOALS))

test: check-venv clean-pyc
	python manage.py test $(filter-out $@,$(MAKECMDGOALS)) --keepdb

coverage: check-venv clean-pyc
	coverage run --source='twilio/' manage.py test --keepdb
	coverage report
