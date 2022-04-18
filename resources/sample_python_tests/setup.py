from setuptools import setup, find_packages

setup(
    name='Test Setup',
    description='Setup for testing env',

    version='0.0',
    author='Darth Vader',
    author_email='darth.vader@sith.net',

    install_requires=[
        'flask'
    ],
    packages=find_packages(),
)
