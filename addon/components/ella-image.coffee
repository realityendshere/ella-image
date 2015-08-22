`import Ember from 'ember'`

jQuery = Ember.$
get = Ember.get
set = Ember.set
setProperties = Ember.setProperties
computed = Ember.computed
observer = Ember.observer
isBlank = Ember.isBlank

###
  `EllaImageComponent` creates an `<img>` element with load event handling
  that can be used to notify a parent object when a new source image begins and
  completes loading.

  This view can be used with Emberella's ListComponent to address a bug that
  causes the image defined by the `src` attribute of previous content to appear
  for a few moments until an updated image loads.

  @class EllaImageComponent
  @extends Ember.Component
###

EllaImageComponent = Ember.Component.extend

  _src: computed.oneWay 'src'

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
    @default ['loading']
  ###
  classNameBindings: ['loading']

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
    @default ['alt', 'title', 'draggable', 'width', 'height']
  ###
  attributeBindings: ['alt', 'title', 'draggable', 'width', 'height', '_src:src']

  ###
    Tracks loading state of the image element. Should be true when an image
    is being fetched and false once the image finishes loading.

    @property loading
    @type Boolean
    @default true
  ###
  loading: true

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
  didImageLoad: computed({
    get: ->
      view = @

      didImageLoad = (e) ->
        $img = jQuery(@)

        #Do nothing if view instance is destroyed
        return if get(view, 'isDestroyed')

        #Do nothing if src has changed again since loading began
        current = get(view, 'src') ? ''
        loaded = $img.attr('src')?.substr(-(current.length))
        return unless loaded is current

        set(view, 'loading', false) if $img.prop 'complete' #exit loading state
  })

  ###
    Update the src attribute of the `<img>` element. Once the corresponding
    image loads, update the `loading` property.

    @method updateSrc
    @chainable
  ###
  updateSrc: ->
    set(@, '_src', '')

    # Do nothing if the src property is blank
    return @ if isBlank(get(@, 'src'))
    Ember.run.scheduleOnce('afterRender', @, '_syncSrc')
    @

  ###
    Respond to changes of the `src` property

    @method srcDidChange
    @chainable
  ###
  srcDidChange: observer('src', ->
    @updateSrc()
  )

  ###
    Trigger `action` when the loading state changes. This allows, for example,
    styling another element differently while waiting for an image to
    finish loading.

    @method loadingDidChange
    @chainable
  ###
  loadingDidChange: observer('loading', ->
    @sendAction('action', get(@, 'loading'))
    @
  )

  ###
    @private

    Setup load handler when img inserted into the DOM.

    @method _setupElement
    @return null
  ###
  _setupElement: Ember.on('didInsertElement', ->
    $img = @$()
    didImageLoad = get @, 'didImageLoad'
    $img.on('load.image-view', didImageLoad)
    null
  )

  ###
    @private

    Teardown load handler when img about to be removed from DOM.

    @method _teardownElement
    @return null
  ###
  _teardownElement: Ember.on('willDestroyElement', ->
    $img = @$()
    $img.off('load.image-view', get(@, 'didImageLoad'))
    null
  )

  ###
    @private

    Set `_src` to `src`.

    @method _syncSrc
    @chainable
  ###
  _syncSrc: ->
    $img = @$()
    setProperties(@, {
      loading: true
      _src: get(@, 'src')
    })
    get(@, 'didImageLoad').call($img) if $img.prop 'complete'
    @

`export default EllaImageComponent`
