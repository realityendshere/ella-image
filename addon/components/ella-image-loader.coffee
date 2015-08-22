`import Ember from 'ember'`

set = Ember.set

EllaImageLoaderComponent = Ember.Component.extend

  ###
    Add the class name `emberella-image-loader`.

    @property classNames
    @type Array
    @default ['emberella-image-loader']
  ###
  classNames: ['emberella-image-loader']

  ###
    Add `loading` class to loader element when loading is `true`.

    @property classNameBindings
    @type Array
    @default ['loading']
  ###
  classNameBindings: ['loading']

  ###
    `src` attribute for child image element.

    @property src
    @type String
    @default ''
  ###
  src: ''

  ###
    `alt` attribute for child image element.

    @property alt
    @type String
    @default ''
  ###
  alt: ''

  ###
    `title` attribute for child image element.

    @property title
    @type String
    @default ''
  ###
  title: ''

  ###
    `draggable` attribute for child image element.

    @property draggable
    @type {Null|String}
    @default null
  ###
  draggable: null

  ###
    `width` attribute for child image element.

    @property width
    @type {Null|String}
    @default null
  ###
  width: null

  ###
    `height` attribute for child image element.

    @property height
    @type {Null|String}
    @default null
  ###
  height: null

  ###
    `loading` is true when child image is loading, false otherwise.

    @property loading
    @type Boolean
    @default false
  ###
  loading: false

  actions:
    imageStateChange: (value) ->
      Ember.run.next => set(@, 'loading', value)
      true

`export default EllaImageLoaderComponent`
