PlaceimgView = require './placeimg-view'
$ = jQuery = require 'jquery'
{CompositeDisposable} = require 'atom'

module.exports = Placeimg =
  PlaceimgView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @placeimgView = new PlaceimgView(state.placeimgViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @placeimgView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'placeimg:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @placeimgView.destroy()

  serialize: ->
    placeimgViewState: @placeimgView.serialize()

  place: ->
    $input = $('.placeimg-input')
    $categories = $('.placeimg-categories')
    $filters = $('.placeimg-filters')
    $copyBtn = $('.placeimg-copy')
    $closeBtn = $('.placeimg-close')

    getValue = () ->
      PLACEIMG_URL_MATCH = /^(https:\/\/placeimg.com)\/(\d+)\/(\d+)\/([a-z0-9]+)(?:\/([a-z0-9]+))?\/?$/gim
      val = $input.val()
      query = PLACEIMG_URL_MATCH.exec(val)
      query.shift()
      query

    placeMatch = (target, pos) ->
      query = getValue()
      query[pos] = $(target).val()
      $input.val(query.join('/'))

    $categories.on('change', 'input', ->
      placeMatch(this, 3)
    )

    $filters.on('change', 'input', ->
      placeMatch(this, 4)
    )

    $copyBtn.on('click', ->
      $input[0].select()
      document.execCommand('copy')
      $input[0].blur()
      )

    $closeBtn.on('click', =>
      if @modalPanel.isVisible()
        @modalPanel.hide()
    )

  toggle: ->
    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @place()
      @modalPanel.show()
