require 'webrick'
require 'controller_base'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'erb'

describe ControllerBase do
  before(:all) do
    class UsersController < ControllerBase
      def index
      end
    end
  end
  after(:all) { Object.send(:remove_const, "UsersController") }

  let(:req) { WEBrick::HTTPRequest.new(Logger: nil) }
  let(:res) { WEBrick::HTTPResponse.new(HTTPVersion: '1.0') }
  let(:users_controller) { UsersController.new(req, res) }

  describe "#render_content" do
    before(:each) do
      users_controller.render_content "somebody", "text/html"
    end

    it "sets the response content type" do
      users_controller.res.content_type.should == "text/html"
    end

    it "sets the response body" do
      users_controller.res.body.should == "somebody"
    end

    describe "#already_built_response?" do
      let(:users_controller2) { UsersController.new(req, res) }

      it "is false before rendering" do
        users_controller2.already_built_response?.should be false
      end

      it "is true after rendering content" do
        users_controller2.render_content "sombody", "text/html"
        users_controller2.already_built_response?.should be true
      end

      it "raises an error when attempting to render twice" do
        users_controller2.render_content "sombody", "text/html"
        expect do
          users_controller2.render_content "sombody", "text/html"
        end.to raise_error
      end
    end
  end

  describe "#redirect" do
    before(:each) do
      users_controller.redirect_to("http://www.google.com")
    end

    it "sets the header" do
      users_controller.res.header["location"].should == "http://www.google.com"
    end

    it "sets the status" do
      users_controller.res.status.should == 302
    end

    describe "#already_built_response?" do
      let(:users_controller2) { UsersController.new(req, res) }

      it "is false before rendering" do
        users_controller2.already_built_response?.should be false
      end

      it "is true after rendering content" do
        users_controller2.redirect_to("http://google.com")
        users_controller2.already_built_response?.should be true
      end

      it "raises an error when attempting to render twice" do
        users_controller2.redirect_to("http://google.com")
        expect do
          users_controller2.redirect_to("http://google.com")
        end.to raise_error
      end
    end
  end
end

describe ControllerBase do
  before(:all) do
    class CatsController < ControllerBase
      def index
        @cats = ["GIZMO"]
      end
    end
  end
  after(:all) { Object.send(:remove_const, "CatsController") }

  let(:req) { WEBrick::HTTPRequest.new(Logger: nil) }
  let(:res) { WEBrick::HTTPResponse.new(HTTPVersion: '1.0') }
  let(:cats_controller) { CatsController.new(req, res) }

  describe "#render" do
    before(:each) do
      cats_controller.render(:index)
    end

    it "renders the html of the index view" do
      cats_controller.res.body.should include("ALL THE CATS")
      cats_controller.res.body.should include("<h1>")
      cats_controller.res.content_type.should == "text/html"
    end

    describe "#already_built_response?" do
      let(:cats_controller2) { CatsController.new(req, res) }

      it "is false before rendering" do
        cats_controller2.already_built_response?.should be false
      end

      it "is true after rendering content" do
        cats_controller2.render(:index)
        cats_controller2.already_built_response?.should be true
      end

      it "raises an error when attempting to render twice" do
        cats_controller2.render(:index)
        expect do
          cats_controller2.render(:index)
        end.to raise_error
      end
    end
  end
end

require 'session'

describe Session do
  let(:req) { WEBrick::HTTPRequest.new(Logger: nil) }
  let(:res) { WEBrick::HTTPResponse.new(HTTPVersion: '1.0') }
  let(:cook) { WEBrick::Cookie.new('_rails_lite_app', { xyz: 'abc' }.to_json) }

  it "deserializes json cookie if one exists" do
    req.cookies << cook
    session = Session.new(req)
    session['xyz'].should == 'abc'
  end

  describe "#store_session" do
    context "without cookies in request" do
      before(:each) do
        session = Session.new(req)
        session['first_key'] = 'first_val'
        session.store_session(res)
      end

      it "adds new cookie with '_rails_lite_app' name to response" do
        cookie = res.cookies.find { |c| c.name == '_rails_lite_app' }
        cookie.should_not be_nil
      end

      it "stores the cookie in json format" do
        cookie = res.cookies.find { |c| c.name == '_rails_lite_app' }
        JSON.parse(cookie.value).should be_instance_of(Hash)
      end
    end

    context "with cookies in request" do
      before(:each) do
        cook = WEBrick::Cookie.new('_rails_lite_app', { pho: "soup" }.to_json)
        req.cookies << cook
      end

      it "reads the pre-existing cookie data into hash" do
        session = Session.new(req)
        session['pho'].should == 'soup'
      end

      it "saves new and old data to the cookie" do
        session = Session.new(req)
        session['machine'] = 'mocha'
        session.store_session(res)
        cookie = res.cookies.find { |c| c.name == '_rails_lite_app' }
        h = JSON.parse(cookie.value)
        h['pho'].should == 'soup'
        h['machine'].should == 'mocha'
      end
    end
  end
end

describe ControllerBase do
  before(:all) do
    class CatsController < ControllerBase
    end
  end
  after(:all) { Object.send(:remove_const, "CatsController") }

  let(:req) { WEBrick::HTTPRequest.new(Logger: nil) }
  let(:res) { WEBrick::HTTPResponse.new(HTTPVersion: '1.0') }
  let(:cats_controller) { CatsController.new(req, res) }

  describe "#session" do
    it "returns a session instance" do
      expect(cats_controller.session).to be_a(Session)
    end

    it "returns the same instance on successive invocations" do
      first_result = cats_controller.session
      expect(cats_controller.session).to be(first_result)
    end
  end

  shared_examples_for "storing session data" do
    it "should store the session data" do
      cats_controller.session['test_key'] = 'test_value'
      cats_controller.send(method, *args)
      cookie = res.cookies.find { |c| c.name == '_rails_lite_app' }
      h = JSON.parse(cookie.value)
      expect(h['test_key']).to eq('test_value')
    end
  end

  describe "#render_content" do
    let(:method) { :render_content }
    let(:args) { ['test', 'text/plain'] }
    include_examples "storing session data"
  end

  describe "#redirect_to" do
    let(:method) { :redirect_to }
    let(:args) { ['http://appacademy.io'] }
    include_examples "storing session data"
  end
end

require 'params'

describe Params do
  before(:all) do
    class CatsController < ControllerBase
      def index
        @cats = ["Gizmo"]
      end
    end
  end
  after(:all) { Object.send(:remove_const, "CatsController") }

  let(:req) { WEBrick::HTTPRequest.new(Logger: nil) }
  let(:res) { WEBrick::HTTPResponse.new(HTTPVersion: '1.0') }
  let(:cats_controller) { CatsController.new(req, res) }

  it "handles an empty request" do
    expect { Params.new(req) }.to_not raise_error
  end

  context "query string" do
    it "handles single key and value" do
      req.query_string = "key=val"
      params = Params.new(req)
      params["key"].should == "val"
    end

    it "handles multiple keys and values" do
      req.query_string = "key=val&key2=val2"
      params = Params.new(req)
      params["key"].should == "val"
      params["key2"].should == "val2"
    end

    it "handles nested keys" do
      req.query_string = "user[address][street]=main"
      params = Params.new(req)
      params["user"]["address"]["street"].should == "main"
    end
  end

  context "post body" do
    it "handles single key and value" do
      req.stub(:body) { "key=val" }
      params = Params.new(req)
      params["key"].should == "val"
    end

    it "handles multiple keys and values" do
      req.stub(:body) { "key=val&key2=val2" }
      params = Params.new(req)
      params["key"].should == "val"
      params["key2"].should == "val2"
    end

    it "handles nested keys" do
      req.stub(:body) { "user[address][street]=main" }
      params = Params.new(req)
      params["user"]["address"]["street"].should == "main"
    end
  end

  context "route params" do
    it "handles route params" do
      params = Params.new(req, {"id" => 5, "user_id" => 22})
      params["id"].should == 5
      params["user_id"].should == 22
    end
  end

  # describe "strong parameters" do
  #   describe "#permit" do
  #     it "allows the permitting of multiple attributes" do
  #       req.query_string = "key=val&key2=val2&key3=val3"
  #       params = Params.new(req)
  #       params.permit("key", "key2")
  #       params.permitted?("key").should be true
  #       params.permitted?("key2").should be true
  #       params.permitted?("key3").should be false
  #     end
  #
  #     it "collects up permitted keys across multiple calls" do
  #       req.query_string = "key=val&key2=val2&key3=val3"
  #       params = Params.new(req)
  #       params.permit("key")
  #       params.permit("key2")
  #       params.permitted?("key").should be true
  #       params.permitted?("key2").should be true
  #       params.permitted?("key3").should be false
  #     end
  #   end
  #
  #   describe "#require" do
  #     it "throws an error if the attribute does not exist" do
  #       req.query_string = "key=val"
  #       params = Params.new(req)
  #       expect { params.require("key") }.to_not raise_error
  #       expect { params.require("key2") }.to raise_error(Params::AttributeNotFoundError)
  #     end
  #   end
  #
  #   describe "interaction with ARLite models" do
  #     it "throws a ForbiddenAttributesError if mass assignment is attempted with unpermitted attributes" do
  #
  #     end
  #   end
  # end
end

require 'router'

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

describe Router do
  let(:req) { WEBrick::HTTPRequest.new(Logger: nil) }
  let(:res) { WEBrick::HTTPResponse.new(HTTPVersion: '1.0') }

  describe "#add_route" do
    it "adds a route" do
      subject.add_route(1, 2, 3, 4)
      subject.routes.count.should == 1
      subject.add_route(1, 2, 3, 4)
      subject.add_route(1, 2, 3, 4)
      subject.routes.count.should == 3
    end
  end

  describe "#match" do
    it "matches a correct route" do
      subject.add_route(Regexp.new("^/users$"), :get, :x, :x)
      req.stub(:path) { "/users" }
      req.stub(:request_method) { :get }
      matched = subject.match(req)
      matched.should_not be_nil
    end

    it "doesn't match an incorrect route" do
      subject.add_route(Regexp.new("^/users$"), :get, :x, :x)
      req.stub(:path) { "/incorrect_path" }
      req.stub(:request_method) { :get }
      matched = subject.match(req)
      matched.should be_nil
    end
  end

  describe "#run" do
    it "sets status to 404 if no route is found" do
      subject.add_route(1, 2, 3, 4)
      req.stub(:path) { "/users" }
      req.stub(:request_method) { :get }
      subject.run(req, res)
      res.status.should == 404
    end
  end

  describe "http method (get, put, post, delete)" do
    it "adds methods get, put, post and delete" do
      router = Router.new
      (router.methods - Class.new.methods).should include(:get)
      (router.methods - Class.new.methods).should include(:put)
      (router.methods - Class.new.methods).should include(:post)
      (router.methods - Class.new.methods).should include(:delete)
    end

    it "adds a route when an http method method is called" do
      router = Router.new
      router.get Regexp.new("^/users$"), ControllerBase, :index
      router.routes.count.should == 1
    end
  end
end

describe "the symphony of things" do
  let(:req) { WEBrick::HTTPRequest.new(Logger: nil) }
  let(:res) { WEBrick::HTTPResponse.new(HTTPVersion: '1.0') }

  before(:all) do
    class Ctrlr < ControllerBase
      def route_render
        render_content("testing", "text/html")
      end

      def route_does_params
        render_content("got ##{ params["id"] }", "text/text")
      end

      def update_session
        session[:token] = "testing"
        render_content("hi", "text/html")
      end
    end
  end
  after(:all) { Object.send(:remove_const, "Ctrlr") }

  describe "routes and params" do
    it "route instantiates controller and calls invoke action" do
      route = Route.new(Regexp.new("^/statuses/(?<id>\\d+)$"), :get, Ctrlr, :route_render)
      req.stub(:path) { "/statuses/1" }
      req.stub(:request_method) { :get }
      route.run(req, res)
      res.body.should == "testing"
    end

    it "route adds to params" do
      route = Route.new(Regexp.new("^/statuses/(?<id>\\d+)$"), :get, Ctrlr, :route_does_params)
      req.stub(:path) { "/statuses/1" }
      req.stub(:request_method) { :get }
      route.run(req, res)
      res.body.should == "got #1"
    end
  end

  describe "controller sessions" do
    let(:ctrlr) { Ctrlr.new(req, res) }

    it "exposes a session via the session method" do
      ctrlr.session.should be_instance_of(Session)
    end

    it "saves the session after rendering content" do
      ctrlr.update_session
      res.cookies.count.should == 1
      JSON.parse(res.cookies[0].value)["token"].should == "testing"
    end
  end
end
