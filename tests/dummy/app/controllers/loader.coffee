`import Ember from 'ember'`

LoaderController = Ember.Controller.extend
  imageSrc: '/apple-coffee-cup-5199.jpg'

  actions:
    changeSrc: (value = 'apple-coffee-cup-5199.jpg') ->
      @set 'imageSrc', '/' + value
      null

`export default LoaderController`
