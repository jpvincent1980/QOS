from robot.libraries.BuiltIn import BuiltIn
from selenium.webdriver.common.by import By


def placeholder_should_be(element_xpath, placeholder_text):
    """A function that double checks presence and content of an element's
    placeholder"""
    lib = BuiltIn().get_library_instance("SeleniumLibrary")
    element = lib.driver.find_element(By.XPATH, element_xpath)
    if not element:
        raise Exception(f"L'élément dont le xpath est {element_xpath} n'a pas été trouvé.")
    assert element.get_attribute("placeholder") == placeholder_text


def background_image_should_be(background_image_src):
    """A function that double checks presence and name of a webpage's
    background"""
    lib = BuiltIn().get_library_instance("SeleniumLibrary")
    element = lib.driver.find_element(By.XPATH, "//body")
    background_image = element.value_of_css_property("background")
    assert background_image_src in background_image
