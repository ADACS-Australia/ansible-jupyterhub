from setuptools import setup

setup(
    name="tljh-custom-plugin",
    author="David Liptai",
    entry_points={"tljh": ["custom_plugin = tljh_custom_plugin"]},
    py_modules=["tljh_custom_plugin"],
)
