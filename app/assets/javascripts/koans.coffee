canon = require('pilot/canon')

class KoanRunnerView extends Backbone.View
  
  koans: ["AboutExpects", "AboutFunctions", "AboutFatArrow", "AboutArrays", "AboutExistance",  "AboutObjects", "AboutInheritance", "AboutObjects", "AboutStrings"]
  
  constructor: (options)->
    super options
    @editor = options.editor
    @koanIndex = 0
  
  selectKoan: (event)->
    @loadKoan @$("#koan_select").val()
    
  loadCurrentKoan: (index) ->
    @loadKoan(@koanIndex)
    
  loadKoan: (index)->
    $.get "/koans/#{@koans[index]}.coffee", (data)=>
      @editor.setCode data
      @run()

  koanCompleted: ->
    @koanIndex += 1
    @loadCurrentKoan()

  events:
    "click .try-it": "run"
    "change #koan_select": "selectKoan"
  

  positiveReinforcements: [
    'Good job!'
    'Way to go!'
    "You're awesome!"
    'Keep it up!'
  ]

  randomPositive: ->
    @positiveReinforcements[Math.round((Math.random() * @positiveReinforcements.length) + 1)]

  displaySuccess: (text) ->
    @$(".spec-results").append "<p><code>#{text}</code> has expanded your awareness. #{@randomPositive()}</p>"

  displayFailure: (spec) ->
    @$(".spec-results").append("<p class='error'>Consider <code>#{spec.description}</code>. It has damaged your karma:</p>")
    @$(".spec-results").append("<ul></ul>")
    for expectation in spec.results().getItems()
      @$("ul").append("<li>#{expectation.message}</li>") unless expectation.passed()
    @editor.find spec.description
    
  render: ->
    @$("#koan_select").html()
    for index in [0...@koans.length]
      @$("#koan_select").append("<option value='#{index}'>#{@koans[index]}</option>")
    @loadCurrentKoan()
    
  findInEditor: (text) ->
    @editor.find text

  run: (event) ->
    event.preventDefault() if event?
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
    @editor.setTheme("ace/theme/textmate")
    @editor.getSession().setTabSize(2)
    @editor.getSession().setUseSoftTabs(true)
    coffeeMode = require("ace/mode/coffee").Mode
    @editor.getSession().setMode new coffeeMode()
    canon.addCommand
      name: 'myCommand'
      bindKey:
          win: 'Ctrl-s'
          mac: 'Command-s'
          sender: 'editor'
      exec: (env, args, request) ->
        window.koanRunnerView.run()
    
  code: ->
    @editor.getSession().getValue()

  setCode: (code)->
    @editor.getSession().setValue code

  find: (text) -> @editor.find(text)

$ ->
  window.koanEditor = new KoanEditor()
  window.koanRunnerView = new KoanRunnerView(el: $("#koan_runner"), editor: koanEditor)
  window.koanRunnerView.render()
  $('body').keydown (e)->
    if (e.which == 13 && (e.ctrlKey || e.metaKey))
      e.preventDefault()
      window.koanRunnerView.run()


  

