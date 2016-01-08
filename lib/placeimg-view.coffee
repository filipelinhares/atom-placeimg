$ = jQuery = require 'jquery'

module.exports = class PlaceimgView
  constructor: (serializedState) ->
    # Create root element
    @container = document.createElement('div')
    @container.classList.add('placeimg')

    placeimgApp = $("
      <div class='clearfix'>
        <input class='native-key-bindings placeimg-input' type='text' value='https://placeimg.com/640/480/any'>
        <button class='btn btn-lg placeimg-copy'>
          <span class='icon icon-clippy'></span>
        </button>
      </div>
      <div class='placeimg-hint'>
        <span class='icon icon-alert'></span>
        Max size is 1000
      </div>

      <div class='block'>
        <div>Categories</div>
        <div class='placeimg-options placeimg-categories'>
          <label>
            <input type='radio' name='categories' value='any'>
            <span class='btn btn-lg'>Any</span>
          </label>
          <label>
            <input type='radio' name='categories' value='arch'>
            <span class='btn btn-lg'>Architecture</span>
          </label>
          <label>
            <input type='radio' name='categories' value='nature'>
            <span class='btn btn-lg'>Nature</span>
          </label>
          <label>
            <input type='radio' name='categories' value='people'>
            <span class='btn btn-lg'>People</span>
          </label>
          <label>
            <input type='radio' name='categories' value='tech'>
            <span class='btn btn-lg'>Tech</span>
          </label>
        </div>
      </div>
      <div class='block'>
        <div>Filters</div>
        <div class='placeimg-options placeimg-filters'>
          <label>
            <input value='grayscale' name='filter' type='radio'>
            <span class='btn btn-lg'>Grayscale</span>
          </label>
          <label>
            <input value='sepia' name='filter' type='radio'>
            <span class='btn btn-lg'>Sepia</span>
          </label>
          <label>
            <input value='' name='filter' type='radio'>
            <span class='btn btn-lg'>
              <span class='icon icon-x'></span>
              None
            </span>
          </label>
        </div>
        <button class='placeimg-close btn-lg btn'>Close</button>
      </div>
    ")

    $(@container).append(placeimgApp)

  # Tear down any state and detach
  destroy: ->
    @container.remove()

  getElement: ->
    @container
