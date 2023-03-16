const MenuComponents = require("../Components/Menu.components");

class CartScreen {
  async openCart() {
    await MenuComponents.openCart();
  }

  async assertNonEmptyCart() {
    await $(
      './/android.widget.Button[contains(@text, "Proceed to checkout")]'
    ).waitForDisplayed();
  }

  async deleteFirstFromCart() {
    await $('.//android.widget.Button[contains(@text, "Delete")]').click();
  }

  async assertProductWasDeleted() {
    await $(
      './/android.widget.TextView[contains(@text, "was removed from Shopping Cart")]'
    ).waitForDisplayed();
  }
}

module.exports = new CartScreen();
