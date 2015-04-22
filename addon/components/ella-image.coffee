`import Ember from 'ember'`

jQuery = Ember.$
get = Ember.get
set = Ember.set

###
  `` creates an `<img>` element with load event handling
  that can be used to notify a parent view when a new source image begins and
  completes loading.

  This view can be used with `Emberella.ListView` to address a bug that causes
  the image defined by the `src` attribute of previous content to appear for a
  few moments until an updated image loads.

  @class EllaImageComponent
  @namespace Emberella
  @extends Ember.Component
###

EllaImageComponent = Ember.Component.extend

  ###
    Add the class name `emberella-image`.

    @property classNames
    @type Array
    @default ['emberella-image']
  ###
  classNames: ['emberella-image']

  ###
    Adds a `loading` class to the image element if its src isn't loaded.

    @property classNameBindings
    @type Array
    @default [ 'loading' ]
  ###
  classNameBindings: [ 'loading' ]

  ###
    The type of element to create for this view.

    @property tagName
    @type String
    @default 'img'
  ###
  tagName: 'img'

  ###
    A list of element attributes to keep in sync with properties of this
    view instance.

    @property attributeBindings
    @type Array
    @default ['style', 'alt', 'title', 'draggable', 'width', 'height']
  ###
  attributeBindings: ['style', 'alt', 'title', 'draggable', 'width', 'height']

  ###
    Tracks loading state of the image element. Should be true when an image
    is being fetched and false once the image finishes loading.

    @property loading
    @type Boolean
    @default false
  ###
  loading: false

  ###
    The src path (URL) of the image to display in this element.

    @property src
    @type String
    @default ''
  ###
  src: ''

  ###
    Image load event handler reference.

    @property didImageLoad
    @type Function
  ###
  didImageLoad: Ember.computed ->
    view = @

    didImageLoad = (e) ->
      $img = jQuery(@)
      $img.off('load.image-view', didImageLoad)

      #Do nothing if view instance is destroyed
      return if get(view, 'isDestroyed')

      #Do nothing if src has changed again since loading began
      current = get(view, 'src') ? ''
      loaded = $img.attr('src').substr(-(current.length))
      return unless loaded is current

      set view, 'loading', false #exit loading state

  ###
    Update the src attribute of the `<img>` element. Once the corresponding
    image loads, update the `loading` property.

    @method updateSrc
    @chainable
  ###
  updateSrc: ->
    $img = @$()
    src = get(@, 'src')
    didImageLoad = get @, 'didImageLoad'

    $img.removeAttr 'src'

    # Do nothing if the src property is empty
    if jQuery.trim(src) is ''
      return @

    set @, 'loading', true #enter loading state

    $img.on('load.image-view', didImageLoad)
    $img.attr('src', src)
    didImageLoad.call($img) if $img.prop 'complete'
    @

  ###
    Respond to changes of the `src` property

    @method srcDidChange
    @chainable
  ###
  srcDidChange: Ember.observer ->
    @updateSrc()
  , 'src'

  ###
    Trigger actions when the loading state changes. This allows, for example,
    styling a parent element differently while waiting for an image to
    finish loading.

    Triggers an `imageWillLoad` action when loading begins.

    Trigger an `imageDidLoad` action when loading completes.

    @method loadingDidChange
    @chainable
  ###
  loadingDidChange: Ember.observer ->
    evt = if get(@, 'loading') then 'imageWillLoad' else 'imageDidLoad'
    @sendAction(evt) if Ember.typeOf(get(@, evt)) is 'string'
    @
  , 'loading'

  ###
    Handle insertion into the DOM.

    @event didInsertElement
  ###
  didInsertElement: ->
    @_super()
    @updateSrc()

  ###
    Handle imminent destruction.

    @event willDestroyElement
  ###
  willDestroyElement: ->
    $img = @$()
    didImageLoad = get @, 'didImageLoad'
    $img.off('load.image-view', didImageLoad)
    @_super()


`export default EllaImageComponent`
