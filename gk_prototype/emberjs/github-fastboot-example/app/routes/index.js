import Ember from 'ember';
import Route from '@ember/routing/route';

const {Logger}= Ember;

export default Route.extend({
	model() {
		Logger.info('index');
		return null;
  }
});
