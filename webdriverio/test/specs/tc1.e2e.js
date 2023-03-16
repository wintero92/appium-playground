const LoginScreen = require("../pageobjects/Page/Login.screen");
const HomeScreen = require("../pageobjects/Page/Home.screen");

describe("TC 1", () => {
  it("Verify Home Page", async () => {
    await LoginScreen.waitForLoadLoginPage();
    await LoginScreen.loginSkip();
    await HomeScreen.searchInputIsVisible();
  });
});
