# GKFrontend prototype(s)


## HowTo run prototype ?

### setup dependencies

	(prototype dir)/DEV_setup.sh

### run locally using emberjs

    (prototype dir)/DEV_run.sh

### run locally using docker machine and custom apache container

    (root dir)/DEV_run_emberjs.sh

## EmberJS (emberjs/github-fastboot-example)

### references

* frontend https://www.emberjs.com/ framework 
* and https://www.ember-fastboot.com/ extension.

Example Open Event Server, see:
* https://github.com/fossasia/open-event-server
* https://github.com/fossasia/open-event-frontend
* blog https://blog.fossasia.org/category/open-event/

### Steps followed

See:
* https://www.ember-fastboot.com/quickstart
* https://guides.emberjs.com/v3.0.0#tutorial/

	npm install ember-cli -g
				+ ember-cli@3.0.0
				added 652 packages in 128.687s
	ember new github-fastboot-example
		(16 min! / disk storage for node_modules: 381 Mo)
	cd github-fastboot-example
	ember install ember-fetch
	ember generate route index
	update  app/routes/*.js + app/templates/*.hbs
	ember install ember-cli-tutorial-style

### EmberJS and ReST Services mock

Mock ReST API using ember-cli-mirage (not keeped)
* cf. http://www.ember-cli-mirage.com/docs/v0.1.x/installation/ (mock api json)

    ember install ember-cli-mirage
    npm uninstall ember-cli-mirage --save-dev           // https://emberigniter.com/uninstall-remove-ember-add-on/

Mock as a service using Apiary
* cf. https://geokretsapiv2mocks.docs.apiary.io/
	

### EmberJS and CORS issue
With EmberJS, how to call remove ReST endpoint with CORS security constraint ?
    solution: 
		(DEV) need to specify one remote service to proxify (ex. `ember serve --proxy https://myService.com`): cf [./DEV_run.sh](emberjs/github-fastboot-example/DEV_run.sh)
		(PROD) server may be able to proxify ReST API Calls: cf. [Apache VirtualHost configuration (10-server.conf)](../env/exposed/docker/10-server.conf)

