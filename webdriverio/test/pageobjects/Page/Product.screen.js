const Common = require("../Components/Common");

class ProductScreen {
  get _addToCart() {
    return $(`.//android.widget.Button[@text="Add to Cart"]`);
  }

  async findCard() {
    await Common.swipeDownUntilElementIsFounded(
      $(`.//android.widget.Button[@text="Add to Cart"]`)
    );
  }

  async addProductToCart() {
    await this.findCard();
    await this._addToCart.click();
    await driver.pause(5000);
  }
}

module.exports = new ProductScreen();
