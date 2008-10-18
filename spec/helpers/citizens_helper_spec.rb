require File.dirname(__FILE__) + '/../spec_helper'
include ApplicationHelper
include CitizensHelper
include AuthenticatedTestHelper

describe CitizensHelper do
  before do
    @citizen = mock_citizen
  end
  
  describe "if_authorized" do 
    it "yields if authorized" do
      should_receive(:authorized?).with('a','r').and_return(true)
      if_authorized?('a','r'){|action,resource| [action,resource,'hi'] }.should == ['a','r','hi']
    end
    it "does nothing if not authorized" do
      should_receive(:authorized?).with('a','r').and_return(false)
      if_authorized?('a','r'){ 'hi' }.should be_nil
    end
  end
  
  describe "link_to_citizen" do
    it "should give an error on a nil citizen" do
      lambda { link_to_citizen(nil) }.should raise_error('Invalid citizen')
    end
    it "should link to the given citizen" do
      should_receive(:citizen_path).at_least(:once).and_return('/citizens/1')
      link_to_citizen(@citizen).should have_tag("a[href='/citizens/1']")
    end
    it "should use given link text if :content_text is specified" do
      link_to_citizen(@citizen, :content_text => 'Hello there!').should have_tag("a", 'Hello there!')
    end
    it "should use the login as link text with no :content_method specified" do
      link_to_citizen(@citizen).should have_tag("a", 'user_name')
    end
    it "should use the name as link text with :content_method => :name" do
      link_to_citizen(@citizen, :content_method => :name).should have_tag("a", 'U. Surname')
    end
    it "should use the login as title with no :title_method specified" do
      link_to_citizen(@citizen).should have_tag("a[title='user_name']")
    end
    it "should use the name as link title with :content_method => :name" do
      link_to_citizen(@citizen, :title_method => :name).should have_tag("a[title='U. Surname']")
    end
    it "should have nickname as a class by default" do
      link_to_citizen(@citizen).should have_tag("a.nickname")
    end
    it "should take other classes and no longer have the nickname class" do
      result = link_to_citizen(@citizen, :class => 'foo bar')
      result.should have_tag("a.foo")
      result.should have_tag("a.bar")
    end
  end

  describe "link_to_login_with_IP" do
    it "should link to the login_path" do
      link_to_login_with_IP().should have_tag("a[href='/login']")
    end
    it "should use given link text if :content_text is specified" do
      link_to_login_with_IP('Hello there!').should have_tag("a", 'Hello there!')
    end
    it "should use the login as link text with no :content_method specified" do
      link_to_login_with_IP().should have_tag("a", '0.0.0.0')
    end
    it "should use the ip address as title" do
      link_to_login_with_IP().should have_tag("a[title='0.0.0.0']")
    end
    it "should by default be like school in summer and have no class" do
      link_to_login_with_IP().should_not have_tag("a.nickname")
    end
    it "should have some class if you tell it to" do
      result = link_to_login_with_IP(nil, :class => 'foo bar')
      result.should have_tag("a.foo")
      result.should have_tag("a.bar")
    end
    it "should have some class if you tell it to" do
      result = link_to_login_with_IP(nil, :tag => 'abbr')
      result.should have_tag("abbr[title='0.0.0.0']")
    end
  end

  describe "link_to_current_citizen, When logged in" do
    before do
      stub!(:current_citizen).and_return(@citizen)
    end
    it "should link to the given citizen" do
      should_receive(:citizen_path).at_least(:once).and_return('/citizens/1')
      link_to_current_citizen().should have_tag("a[href='/citizens/1']")
    end
    it "should use given link text if :content_text is specified" do
      link_to_current_citizen(:content_text => 'Hello there!').should have_tag("a", 'Hello there!')
    end
    it "should use the login as link text with no :content_method specified" do
      link_to_current_citizen().should have_tag("a", 'user_name')
    end
    it "should use the name as link text with :content_method => :name" do
      link_to_current_citizen(:content_method => :name).should have_tag("a", 'U. Surname')
    end
    it "should use the login as title with no :title_method specified" do
      link_to_current_citizen().should have_tag("a[title='user_name']")
    end
    it "should use the name as link title with :content_method => :name" do
      link_to_current_citizen(:title_method => :name).should have_tag("a[title='U. Surname']")
    end
    it "should have nickname as a class" do
      link_to_current_citizen().should have_tag("a.nickname")
    end
    it "should take other classes and no longer have the nickname class" do
      result = link_to_current_citizen(:class => 'foo bar')
      result.should have_tag("a.foo")
      result.should have_tag("a.bar")
    end
  end

  describe "link_to_current_citizen, When logged out" do
    before do
      stub!(:current_citizen).and_return(nil)
    end
    it "should link to the login_path" do
      link_to_current_citizen().should have_tag("a[href='/login']")
    end
    it "should use given link text if :content_text is specified" do
      link_to_current_citizen(:content_text => 'Hello there!').should have_tag("a", 'Hello there!')
    end
    it "should use 'not signed in' as link text with no :content_method specified" do
      link_to_current_citizen().should have_tag("a", 'not signed in')
    end
    it "should use the ip address as title" do
      link_to_current_citizen().should have_tag("a[title='0.0.0.0']")
    end
    it "should by default be like school in summer and have no class" do
      link_to_current_citizen().should_not have_tag("a.nickname")
    end
    it "should have some class if you tell it to" do
      result = link_to_current_citizen(:class => 'foo bar')
      result.should have_tag("a.foo")
      result.should have_tag("a.bar")
    end
  end

end
