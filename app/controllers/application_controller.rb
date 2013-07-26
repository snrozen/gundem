class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :last_message

  def last_message
  	@last_message = Message.find(:all, :limit => 5, :order=> 'created_at desc')
  end

end
