import Ember from 'ember';
import Route from '@ember/routing/route';
import fetch from 'ember-fetch/ajax';

const {Logger}= Ember;

export default Route.extend({
	model() {
		Logger.info('fetch mock user');
		return fetch('/api/users')
			.then(function(response) {
			return response;
		});
  }
});
