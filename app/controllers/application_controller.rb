class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  include Pundit
  include ActionController::MimeResponds
  before_action :authorize_request
  attr_reader :current_user

  def pundit_user
    AuthorizationContext.new(current_user, current_organization)
  end

  private

  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end
end