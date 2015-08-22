`import Ember from 'ember'`

ImageController = Ember.Controller.extend
  imageLoading: false

  imageSrc: '/apple-coffee-cup-5199.jpg'

  actions:
    imageChange: (value) ->
      Ember.run.next => @set('imageLoading', value)

    changeSrc: (value = 'apple-coffee-cup-5199.jpg') ->
      @set 'imageSrc', '/' + value
      null

`export default ImageController`
