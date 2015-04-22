`import Ember from 'ember'`

ThingsController = Ember.Controller.extend
  test: 'Hello, World'
  imageLoading: false

  actions:
    imageWillLoad: ->
      @set('imageLoading', true)

    imageDidLoad: ->
      @set('imageLoading', false)

`export default ThingsController`
