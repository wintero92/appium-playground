const Searchbar = require("../Components/Searchbar.components")

class Dashboard {
    async CheckDashboardWasLoaded() {
        await Searchbar.OpenSearchbar.waitForDisplayed({
            timeout: 20000,
        })
    }

    async FindProduct(myProduct) {
        await Searchbar.FindProduct(myProduct);
    }

}

module.exports = new Dashboard();