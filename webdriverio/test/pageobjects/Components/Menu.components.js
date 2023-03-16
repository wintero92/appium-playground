const { expect } = require("chai");

class Menu {
  get _menuCount() {
    return $("id=cart_count");
  }

  async checkCountOfProductInCard(count) {
    expect(await this._menuCount.getText()).to.equal(count);
  }

  async openCart() {
    await this._menuCount.click();
  }

}

module.exports = new Menu();
