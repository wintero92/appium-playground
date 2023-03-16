class Searchbar {
    get OpenSearchbar() {
        return $('id=chrome_search_hint_view');
    }

    get SearchbarInputField() {
        return $('id=rs_search_src_text');
    }

    async FindProduct(product){
        await this.OpenSearchbar.click();
        await this.SearchbarInputField.setValue(product);
        await driver.pressKeyCode(66)
        await driver.pause(1000);
    }
}

module.exports = new Searchbar();