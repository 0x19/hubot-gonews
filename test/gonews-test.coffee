chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'gonews', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/gonews')(@robot)

  it 'registers can access gonews', ->
    expect(@robot.hear).to.have.been.calledWith(/gonews/)
