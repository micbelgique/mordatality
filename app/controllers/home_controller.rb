class HomeController < ApplicationController
  def show
    params[:age] ||= '18'
  end
end
