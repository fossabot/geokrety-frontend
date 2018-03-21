import Ember from 'ember';
import Route from '@ember/routing/route';
import fetch from 'ember-fetch/ajax';

const {Logger}= Ember;

export default Route.extend({
	model() {
		var githubuser = 'kumy'
		Logger.info('fetch github profile', githubuser);
		// NO CORS issue with github
		return fetch('https://api.github.com/users/' +githubuser)
			.then(function(response) {
			return response;
		});
  }
});
