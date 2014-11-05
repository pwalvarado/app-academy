require 'route'
require 'webrick'

describe Route do
  let(:req) { WEBrick::HTTPRequest.new(Logger: nil) }
  let(:res) { WEBrick::HTTPResponse.new(HTTPVersion: '1.0') }

  describe "#matches?" do
    it "matches simple regular expression" do
      index_route = Route.new(Regexp.new("^/users$"), :get, "x", :x)
      req.stub(:path) { "/users" }
      req.stub(:request_method) { :get }
      index_route.matches?(req).should be true
    end

    it "matches regular expression with capture" do
      index_route = Route.new(Regexp.new("^/users/(?<id>\\d+)$"), :get, "x", :x)
      req.stub(:path) { "/users/1" }
      req.stub(:request_method) { :get }
      index_route.matches?(req).should be true
    end

    it "correctly doesn't matche regular expression with capture" do
      index_route = Route.new(Regexp.new("^/users/(?<id>\\d+)$"), :get, "UsersController", :index)
      req.stub(:path) { "/statuses/1" }
      req.stub(:request_method) { :get }
      index_route.matches?(req).should be false
    end
  end

  describe "#run" do
    before(:all) { class DummyController; end }
    after(:all) { Object.send(:remove_const, "DummyController") }

    it "instantiates controller and invokes action" do
      # reader beware. hairy adventures ahead.
      # this is really checking way too much implementation,
      # but tests the aproach recommended in the project
      req.stub(:path) { "/users" }

      dummy_controller_class = DummyController
      dummy_controller_instance = DummyController.new
      dummy_controller_instance.stub(:invoke_action)
      dummy_controller_class.stub(:new).with(req, res, {}) { dummy_controller_instance }
      dummy_controller_class.stub(:new).with(req, res) { dummy_controller_instance }
      dummy_controller_instance.should_receive(:invoke_action)
      index_route = Route.new(Regexp.new("^/users$"), :get, dummy_controller_class, :index)
      index_route.run(req, res)
    end
  end
end