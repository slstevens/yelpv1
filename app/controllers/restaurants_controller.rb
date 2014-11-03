class RestaurantsController < ApplicationController

	def index
	  @restaurants = Restaurant.all
	end

    def new
 	   @restaurant = Restaurant.new
    end

    def create
    	@restaurant = Restaurant.new(params[:restaurant])
    	redirect_to '/restaurants'
    end
end