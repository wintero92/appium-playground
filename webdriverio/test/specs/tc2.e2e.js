const LoginScreen = require("../pageobjects/Page/Login.screen");
const HomeScreen = require("../pageobjects/Page/Home.screen");

describe("TC 2", () => {
  it("Search Product", async () => {
    await LoginScreen.waitForLoadLoginPage();
    await LoginScreen.loginSkip();
    await HomeScreen.searchInputIsVisible();
    await HomeScreen.findProduct("samsung");
  });
});
