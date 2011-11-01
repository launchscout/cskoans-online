class Thing
  constructor: ->
    @foo = "thingfoo"
  boundCallback: ->
    callback = => @foo
  unboundCallback: ->
    callback = -> @foo

describe "About Fat Arrow", ->
  it "should preserve the current value of this", ->
    thing = new Thing()
    window.foo = "windowfoo"
    boundCallback = thing.boundCallback()
    expect(boundCallback()).toEqual FILL_ME_IN
    unboundCallback = thing.unboundCallback()
    expect(unboundCallback()).toEqual FILL_ME_IN    