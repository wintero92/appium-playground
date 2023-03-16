const LoginScreen = require("../pageobjects/Page/Login.screen");
const HomeScreen = require("../pageobjects/Page/Home.screen");
const SearchResultScreen = require("../pageobjects/Page/SearchResult.screen");
const ProductScreen = require("../pageobjects/Page/Product.screen");
const CartScreen = require("../pageobjects/Page/Cart.screen");

describe("TC 3", () => {
  it("Add Product To Cart", async () => {
    await LoginScreen.waitForLoadLoginPage();
    await LoginScreen.loginSkip();
    await HomeScreen.searchInputIsVisible();
    await HomeScreen.findProduct("Samsung");
    await SearchResultScreen.openFirst("Samsung");
    await ProductScreen.addProductToCart();
    await CartScreen.openCart();
    await CartScreen.assertNonEmptyCart();
  });
});
