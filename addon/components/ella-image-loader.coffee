`import Ember from 'ember'`

set = Ember.set

EllaImageLoaderComponent = Ember.Component.extend
  classNames: 'ella-image-loader'

  classNameBindings: ['loading']

  src: ''

  loading: false

  actions:
    imageStateChange: (value) ->
      Ember.run.next => set(@, 'loading', value)
      true

`export default EllaImageLoaderComponent`
