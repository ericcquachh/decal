require 'spec_helper'

describe AdminController do

	before :each do
		Course.create(title: "Flirting in French", category: "Languages", units: "2", status: "Full", pending: true)
		Course.create(title: "Flirting in Chinese", category: "Languages", units: "2", status: "Full", pending: false)
	end

	it "should test the admin index functionality" do
		#my god ted, this was the only thing i can think of to test it
		get :index, :section_time => 42
	end

	it "should create a particular param" do
		get :create, 'Flirting in French' => '1'
		response.should redirect_to('/admin')
		get :create, 'Flirting in Chinese' => '1'
		response.should redirect_to('/admin')
	end


end