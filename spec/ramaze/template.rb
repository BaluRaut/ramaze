#          Copyright (c) 2006 Michael Fellinger m.fellinger@gmail.com
# All files in this distribution are subject to the terms of the Ruby license.

require 'spec/helper'
require 'ramaze/template'

module Ramaze::Template
  class TestTemplate < Template
    Ramaze::Controller.register_engine self, %w[ test ]
    class << self
      def transform controller, options = {}
        action, parameter, file, bound = *super
        [ controller.class.name,
          action,
          parameter,
          file
        ].to_yaml
      end
    end
  end
end

class TCTemplateController < Ramaze::Controller
  trait :engine => Ramaze::Template::TestTemplate
  trait :template_root => (File.dirname(__FILE__)/:template/:ramaze)

  def index *args
  end

  def some_other_method *args
  end
end

describe "testing ramaze template" do
  ramaze(:mapping => {'/' => TCTemplateController})

  def getpage page
    @controller, @action, @parameter, @file = YAML.load(get( page ).body)
  end

  it "Gets a blank page" do
    getpage("/index")

    @controller.should == "TCTemplateController"
    @action.should == "index"
    @parameter.should == []
    @file.should == nil
  end

  it "Maps the index" do
    getpage("/")

    @controller.should == "TCTemplateController"
    @action.should == "index"
    @parameter.should == []
    @file.should == nil
  end

  it "Parses parameters" do
    getpage("/one/two/three")

    @controller.should == "TCTemplateController"
    @action.should == "index"
    @parameter.should == %w{one two three}
    @file.should == nil
  end

  it "Knows about other methods" do
    getpage("/some_other_method")

    @controller.should == "TCTemplateController"
    @action.should == "some_other_method"
    @parameter.should == []
    @file.should == nil
  end

  it "Uses external template files" do
    getpage("/external")

    @controller.should == "TCTemplateController"
    @action.should == "external"
    @parameter.should == []
    file = TCTemplateController.trait[:template_root]/'external.test'
    @file.should == File.expand_path(file)
  end
end