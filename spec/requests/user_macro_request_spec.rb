require 'spec_helper'

describe "CRUD for user macros" do

  before do
    @hg1 = Rubix::HostGroup.new(:name => 'rubix_spec_host_group_1')
    @hg1.save
    
    @h1  = Rubix::Host.new(:name => 'rubix_spec_host_1', :host_groups => [@hg1])
    @h1.save
  end

  after do
    @h1.destroy
    @hg1.destroy
  end
  
  it "should be able to create, update, and destroy a host" do
    integration_test
    
    Rubix::UserMacro.find(:name => 'rubix_spec_macro_1', :host_id => @h1.id).should be_nil
    
    um = Rubix::UserMacro.new(:name => 'rubix_spec_macro_1', :value => 'rubix_spec_value_1', :host_id => @h1.id)
    um.save
    Rubix::UserMacro.find(:name => 'rubix_spec_macro_1', :host_id => @h1.id).should_not be_nil
    id = um.id
    id.should_not be_nil

    um.value = 'rubix_spec_value_2'
    um.update
    Rubix::UserMacro.find(:name => 'rubix_spec_macro_1', :host_id => @h1.id).value.should == 'rubix_spec_value_2'

    um.destroy
    Rubix::UserMacro.find(:name => 'rubix_spec_macro_2', :host_id => @h1.id).should be_nil
  end
end