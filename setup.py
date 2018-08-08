#!/usr/bin/env python
# -*- coding: utf-8 -*-
# pylint: disable=C0111

import os
from typing import List

import setuptools

# To prevent importing about and thereby breaking the coverage info we use this
# exec hack
about: dict = {}
with open('pyworkplace/__about__.py') as fp:
    exec(fp.read(), about)

required: List[str] = []
with open(os.path.join(os.path.dirname(__file__), 'requirements.txt')) as f:
    required = f.read().splitlines()

if os.path.isfile('README.rst'):
    long_description = open('README.rst').read()
else:
    long_description = ('See http://pypi.python.org/pypi/' +
                        about['__package_name__'])

if __name__ == '__main__':
    setuptools.setup(
        name=about['__package_name__'],
        version=about['__version__'],
        author=about['__author__'],
        author_email=about['__author_email__'],
        description=about['__description__'],
        url=about['__url__'],
        license='BSD',
        packages=setuptools.find_packages(exclude=['tests']),
        install_requires=required,
        tests_require=[
            'PyHamcrest==1.9.0',
            'mock',
            'pytest',
            'pytest-cov',
            'pytest-mock==1.9.0',
            'pytest-runner',
        ],
        extras_require={
            'docs': ['mock', 'sphinx>=1.7.2'],
            'tests': [
                'sphinx',
                'pytest',
                'pytest-cache',
                'pytest-cov',
                'pytest-flakes',
                'pytest-pep8',
                'pytest-runner',
                'jinja2',
                'pygments',
            ],
        },
        long_description=long_description,
        classifiers=[
            'Development Status :: 5 - Production/Stable',
            'Intended Audience :: Customer Service',
            'Intended Audience :: End Users/Desktop',
            'Intended Audience :: Information Technology',
            'Intended Audience :: Science/Research',
            'Intended Audience :: Other Audience',
            'License :: OSI Approved :: MIT License',
            'Environment :: Console',
            'Operating System :: MacOS',
            'Operating System :: Microsoft :: Windows',
            'Operating System :: POSIX',
            'Programming Language :: Python :: 2',
            'Programming Language :: Python :: 2.7',
            'Programming Language :: Python :: 3',
            'Programming Language :: Python :: 3.4',
            'Programming Language :: Python :: 3.5',
            'Programming Language :: Python :: 3.6',
            'Topic :: Office/Business',
            'Topic :: Utilities',
        ],
    )
