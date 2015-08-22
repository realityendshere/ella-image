`import Ember from 'ember'`

ImageRoute = Ember.Route.extend
  setupController: (controller, model) ->
    controller.set('errorMessage', null)

`export default ImageRoute`
