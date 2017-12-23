module Admin
  # Base controller all app controllers should inherit from to ensure they inherit the correct settings
  class AdminController < ApplicationController
    protect_from_forgery with: :exception
  end
end
