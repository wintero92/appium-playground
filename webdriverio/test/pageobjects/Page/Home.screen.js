class HomeScreen {
  get _SearchInput() {
    return $("id=com.amazon.mShop.android.shopping:id/chrome_search_hint_view");
  }

  get _SearchBarInputField() {
    return $("id=com.amazon.mShop.android.shopping:id/rs_search_src_text");
  }

  async searchInputIsVisible() {
    return this._SearchInput.waitForDisplayed({
      timeout: 20000,
    });
  }

  async findProduct(product) {
    await this._SearchInput.click();
    await this._SearchBarInputField.setValue(product);
    await driver.pressKeyCode(66);
    await driver.pause(1000);
    await this._SearchInput.click();
    await this._SearchBarInputField.setValue(product);
    await driver.pressKeyCode(66);
    await driver.pause(1000);
  }
}

module.exports = new HomeScreen();
