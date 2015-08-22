`import Ember from 'ember'`

IndexRoute = Ember.Route.extend
  redirect: -> @transitionTo 'image'

`export default IndexRoute`
