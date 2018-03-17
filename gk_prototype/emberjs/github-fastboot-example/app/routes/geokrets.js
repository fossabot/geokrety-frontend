import Ember from 'ember';
import Route from '@ember/routing/route';
import fetch from 'ember-fetch/ajax';

const {Logger}= Ember;

export default Route.extend({

	model() {
    // https://api.geokretymap.org/ownername/kumy
    // var xmlUri = "/ownername/kumy";
    // KO: fetch can't parse xml

    // https://api.geokretymap.org/geojson?latTL=45.22922&lonTL=5.78988&latBR=45.1392&lonBR=5.662222&limit=100&daysFrom=0&daysTo=-1
    // lonBR et lonTL inversés // grenoble
    var geojsonUri= "/geojson?latTL=45.22922&lonTL=5.78988&latBR=45.1392&lonBR=5.662222&limit=100&daysFrom=0&daysTo=-1"

    Logger.info('fetck geokrets list');
    var gklist = fetch(geojsonUri)
                        .then(function(response) {
                                Logger.info('response', response);
                                return { "where": "Grenoble",
                                         "featureCollection": response.features,
                                         "count": response.features.length} ;
                             })
                        ;
    Logger.info('promise', gklist);
    return gklist;
  }
});
