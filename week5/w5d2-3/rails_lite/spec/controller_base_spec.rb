require 'webrick'
require 'controller_base'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'erb'
require 'params'

describe ControllerBase do
  describe 'test set 1' do
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

  describe 'test set 2' do
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

  describe 'test set 3' do
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
end