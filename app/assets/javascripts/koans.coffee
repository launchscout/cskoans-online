class KoanRunnerView extends Backbone.View

  koans: ["AboutExistance", "AboutExpects", "AboutArrays"]

  constructor: (options)->
    super options
    @editor = options.editor
    @koanIndex = 0

  loadCurrentKoan: ->
    $.get "/koans/#{@koans[@koanIndex]}.coffee", (data)=>
      @editor.setCode data
      @run()

  koanCompleted: ->
    @koanIndex += 1
    @loadCurrentKoan()

  events:
    "click .try-it": "run"

  displaySuccess: (text) ->
    @$(".spec-results").append "'#{text}' has expanded your awareness.<br/>"

  displayFailure: (spec) ->
    @$(".spec-results").append("<p>Consider '#{spec.description}'. It has damaged your karma:</p>")
    @$(".spec-results").append("<ul></ul>")
    for expectation in spec.results().getItems()
      @$("ul").append("<li>#{expectation.message}</li>") unless expectation.passed()
    @editor.find spec.description


  findInEditor: (text) ->
    @editor.find text

  run: ->
    @$(".spec-results").empty()
    @iframe.remove if @iframe?
    @iframe = $("<iframe id='sandbox' src='/sandbox'></iframe>").appendTo("body").load =>
      iframeWin = @iframe.get(0).contentWindow
      iframeWin.jasmine.getEnv().addReporter new iframeWin.CoffeeKoansReporter @
      iframeWin.eval CoffeeScript.compile(@editor.code(), { bare: true })
      iframeWin.jasmine.getEnv().execute()



class KoanEditor

  constructor: ->
    @editor = ace.edit("koan_editor")
    @editor.name = "koan_editor"
    @editor.setTheme("ace/theme/textmate");
    @editor.getSession().setTabSize(2)
    @editor.getSession().setUseSoftTabs(true);
    coffeeMode = require("ace/mode/coffee").Mode;
    @editor.getSession().setMode new coffeeMode()

  code: ->
    @editor.getSession().getValue()

  setCode: (code)->
    @editor.getSession().setValue code

  find: (text) -> @editor.find(text)

$ ->
  window.koanEditor = new KoanEditor()
  window.koanRunnerView = new KoanRunnerView(el: $("#koan_runner"), editor: koanEditor)
  window.koanRunnerView.loadCurrentKoan()
  $('body').keydown (e)->
    if (e.which == 13 && (e.ctrlKey || e.metaKey))
      e.preventDefault()
      window.koanRunnerView.run()
