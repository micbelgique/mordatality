class HomeController < ApplicationController
  def show
    params[:age]  ||= '18'
    params[:city] ||= City.find_by_name_fr('Mons').id
  end
end
