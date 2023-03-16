class LoginScreen {
  get _loginSkip() {
    return $("id=skip_sign_in_button");
  }

  async waitForLoadLoginPage() {
    return $("id=skip_sign_in_button").waitForDisplayed({
      timeout: 20000,
    });
  }

  async loginSkip() {
    await this._loginSkip.click();
  }

  async login() {
    await $("id=com.amazon.mShop.android.shopping:id/sign_in_button").click();
    await $(".//android.widget.EditText").waitForDisplayed();
    await $(".//android.widget.EditText").setValue("giveme99sale@ordie.com");
  }
}

module.exports = new LoginScreen();
