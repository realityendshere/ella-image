`import Ember from 'ember'`

EllaImageLoaderComponent = Ember.Component.extend
  classNameBindings: ['loading']

  loading: false

  actions:
    imageWillLoad: ->
      @set('loading', true)

    imageDidLoad: ->
      @set('loading', false)

`export default EllaImageComponent`
