class RestaurantsController < ApplicationController

	before_action :authenticate_user!, :except => [:index, :show]
	
	def index
	    @restaurants = Restaurant.all
	end

    def new
 	    @restaurant = Restaurant.new
    end

    def create
	  @restaurant = Restaurant.new(restaurant_params)
	  @restaurant.user = current_user
	  if @restaurant.save
	    redirect_to restaurants_path
	  else
	  	flash[:notice] = @restaurant.errors.messages.map{|k,v| "#{k}=#{v}"}.join("\n")
	    redirect_to restaurants_path
	  end
    end

    def restaurant_params
    	params.require(:restaurant).permit(:name, :image) 
    end

	def show
	  @restaurant = Restaurant.find(params[:id])
	end

	def edit

		#Option 1 
     	# @restaurant = Restaurant.find(params[:id])
     	# if current_user != Restaurant.find(params[:id]).user
     	# 	redirect_to root_path
     	# 	flash[:notice] = "You're not allowed to edit!"
     	# end	

     	#Option 2
     	@restaurant = current_user.restaurants.find(params[:id])
     	rescue ActiveRecord::RecordNotFound
     		redirect_to root_path
     		flash[:notice] = "You're not allowed to edit!"
    end

    def update
	    @restaurant = Restaurant.find(params[:id])
	    @restaurant.update(restaurant_params)
	    redirect_to '/restaurants'
    end

    def destroy
	    # @restaurant = Restaurant.find(params[:id])
	    @restaurant = current_user.restaurants.find(params[:id])
	    @restaurant.destroy
	   	flash[:notice] = 'Restaurant deleted successfully'
	   	redirect_to '/restaurants'
	    rescue ActiveRecord::RecordNotFound
	    flash[:notice] = "You're not allowed to delete!"
	    redirect_to root_path
    end

end