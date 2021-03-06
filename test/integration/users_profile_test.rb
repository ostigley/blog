require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
	include ApplicationHelper

	def setup
		@user = users(:Oliver)
	end

	test "profile diplay" do 
		get user_path(@user)

		assert_template 'users/show'
		assert_select 'title', full_title(@user.name)
		assert_select 'h1', text: @user.name
		assert_select 'h1>img.gravatar'
	#	assert_select 'div.pagination'
		assert_match @user.microposts.count.to_s, response.body
		@user.microposts.paginate(page: 1).each do |micropost|
			assert_match micropost.content, response.body
		end		
	end		 

end
