module Client
  class BaseController < ApplicationController
    include Dry::Monads::Result::Mixin

    before_action :authenticate_customer_user!

    layout "client"
  end
end