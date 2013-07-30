class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :last_message


	private

	def current_user
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def last_message
		@last_message = Message.find(:all, :limit => 5, :order=> 'created_at desc')
	end

end
