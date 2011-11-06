describe 'About Objects', ->

  it 'should allow me to interate over properies with of', ->
    object = 
      foo: 'bar'
      biz: 'bang'
    keys = key for key, value of object
    values = value for key, value of object
    expect(keys).toEqual(FILL_ME_IN)
    expect(values).toEqual(FILL_ME_IN)

  it "should know that @property is the same as this.property", ->
    currentYear = 2011 # Update me!
    meglomaniac =
      mastermind: 'James Wood'
      henchman: 'Adam West'
      birthYear: 1970
      calculateAge: -> currentYear - @birthYear

    expect(currentYear).toBe(FILL_ME_IN)
    expect(meglomaniac.calculateAge()).toBe(FILL_ME_IN)


  describe "'in' keyword", ->
    meglomaniac = {}
    beforeEach ->
      meglomaniac =
        mastermind: 'The Monarch'
        henchwoman: 'Dr Girlfriend'
        theBomb: true

    it 'should have the bomb', ->
      hasBomb = meglomaniac.theBomb? # ? is the existence operator
      expect(hasBomb).toBe(FILL_ME_IN)

    it 'should not have the detonator however', ->
      hasDetonator = meglomaniac.theDetonator?
      expect(hasDetonator).toBe(FILL_ME_IN)
  # end 'in' keyword section


  it 'should use prototype to add to all objects', ->
      Circle = (radius) -> @radius = radius

      simpleCircle = new Circle(10)
      colouredCircle = new Circle(5)
      colouredCircle.colour = 'red'

      expect(simpleCircle.colour).toBe(FILL_ME_IN)
      expect(colouredCircle.colour).toBe(FILL_ME_IN)

      Circle.prototype.describe = -> 'This circle has a radius of: ' + @radius

      expect(simpleCircle.describe()).toBe(FILL_ME_IN)
      expect(colouredCircle.describe()).toBe(FILL_ME_IN)


