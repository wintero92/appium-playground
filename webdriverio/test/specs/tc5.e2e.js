const LoginScreen = require("../pageobjects/Page/Login.screen");
const HomeScreen = require("../pageobjects/Page/Home.screen");
const SearchResultScreen = require("../pageobjects/Page/SearchResult.screen");
const ProductScreen = require("../pageobjects/Page/Product.screen");
const CartScreen = require("../pageobjects/Page/Cart.screen");

describe("TC 5", () => {
  it("Verify Login Page", async () => {
    await LoginScreen.waitForLoadLoginPage();
    await LoginScreen.login();
  });
});
