EvalmainView = require './evalmain-view'
{CompositeDisposable} = require 'atom'

module.exports = Evalmain =
  evalmainView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @evalmainView = new EvalmainView(state.evalmainViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @evalmainView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'evalmain:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @evalmainView.destroy()

  serialize: ->
    evalmainViewState: @evalmainView.serialize()

  toggle: ->
    console.log 'Evalmain was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
