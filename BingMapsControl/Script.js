function ShowAddress(address) {
    Microsoft.Maps.loadModule('Microsoft.Maps.Search', function() {
        var searchManager = new Microsoft.Maps.Search.SearchManager(BingMapsControl);
        var requestOptions = {
            where: address,
            callback: function(answer, userData) {
                BingMapsControl.setView({ 
                    bounds: answer.results[0].bestView, 
                    padding: 100 
                });
                BingMapsControl.entities.push(new Microsoft.Maps.Pushpin(answer.results[0].location));
            }
        }
        searchManager.geocode(requestOptions);
    });
}