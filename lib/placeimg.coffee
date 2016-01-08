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
    getValue = () ->
      PLACEIMG_URL_MATCH = /^(https:\/\/placeimg.com)\/(\d+)\/(\d+)\/([a-z0-9]+)(?:\/([a-z0-9]+))?\/?$/gim
      val = $('.placeimg-input').val()
      query = PLACEIMG_URL_MATCH.exec(val)
      query.shift()

      return query

    $('.placeimg-categories').on('change', 'input', ->
      query = getValue()
      console.log query
      query[3] = $(this).val()
      $('.placeimg-input').val(query.join('/'))
    )

    $('.placeimg-filters').on('change', 'input', ->
      query = getValue()
      console.log query
      query[4] = $(this).val()
      $('.placeimg-input').val(query.join('/'))
    )

    $('.placeimg-copy').on('click', ->
      $('.placeimg-input')[0].select()
      document.execCommand('copy')
      $('.placeimg-input')[0].blur()
      )

    $('.placeimg-close').on('click', =>
      if @modalPanel.isVisible()
        @modalPanel.hide()
    )

  toggle: ->
    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @place()
      @modalPanel.show()
