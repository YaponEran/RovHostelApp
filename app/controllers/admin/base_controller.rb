module Admin
  class BaseController < ApplicationController
    include Dry::Monads::Result::Mixin
    before_action :authenticate_admin_user!

    layout 'admin'
  end
end