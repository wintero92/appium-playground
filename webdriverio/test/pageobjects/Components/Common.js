class Common {
  async findAndroidElementByText(string) {
    const selector = `android=new UiSelector().textContains("${string}")`;

    return $(selector);
  }

  async waitAndClick(string) {
    await (await this.findAndroidElementByText(string)).waitForDisplayed();
    await (await this.findAndroidElementByText(string)).click();
  }

  async scrollDown() {
    const dimensionHeight = await browser.getWindowSize();
    const startPoint = (await dimensionHeight.height) * 0.5;
    const endPoint = (await dimensionHeight.height) * 0.15;
    const anchor = 100;

    await driver.touchPerform([
      {
        action: "press",
        options: {
          x: anchor,
          y: startPoint,
        },
      },
      {
        action: "wait",
        options: {
          ms: 1000,
        },
      },
      {
        action: "moveTo",
        options: {
          x: anchor,
          y: endPoint,
        },
      },
      {
        action: "release",
        options: {},
      },
    ]);
  }

  async swipeDownUntilElementIsFounded(element) {
    const selectorExists = await element.isExisting();

    if (selectorExists === false) {
      let countLoop = 0;
      while (true) {
        await driver.pause(5000);
        await this.scrollDown();
        let selectorCanExists = await element.isExisting();

        if (selectorCanExists === true) {
          break;
        }

        if (countLoop > 5) {
          break;
        }
        countLoop++;
      }
    }
  }
}

module.exports = new Common();
