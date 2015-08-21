`import Ember from 'ember'`

ThingsController = Ember.Controller.extend
  imageLoading: false

  imageSrc: '/apple-coffee-cup-5199.jpg'

  actions:
    imageWillLoad: ->
      @set('imageLoading', true)

    imageDidLoad: ->
      @set('imageLoading', false)

    changeSrc: (value = 'apple-coffee-cup-5199.jpg') ->
      @set 'imageSrc', '/' + value
      null

`export default ThingsController`
