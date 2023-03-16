class SearchResultScreen {
  async openFirst(product) {
    const selector = $(
      `.//android.view.View[contains(@content-desc, "${product}")]`
    );
    await selector.click();
  }
}

module.exports = new SearchResultScreen();
