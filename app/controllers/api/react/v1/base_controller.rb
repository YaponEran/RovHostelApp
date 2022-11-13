module Api
  module React
    module V1
      class BaseController < ApplicationController
        include Dry::Monads::Result::Mixin

        layout false
      end
    end
  end
end