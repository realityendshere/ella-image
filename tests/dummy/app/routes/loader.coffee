`import Ember from 'ember'`

LoaderRoute = Ember.Route.extend
  setupController: (controller, model) ->
    controller.set('errorMessage', null)

`export default LoaderRoute`
