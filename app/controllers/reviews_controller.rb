class ReviewsController < ApplicationController

	def new
		@restaurant = Restaurant.find(params[:restaurant_id])
		@review = Review.new
	end

	def destroy
		# @review = current_user.reviews.find(params[:id])
		@review = Review.find(params[:id])
		@review.destroy
		flash[:notice] = 'Review deleted successfully'
		redirect_to restaurants_path
	end


	    # @restaurant = current_user.restaurants.find(params[:id])
	    # @restaurant.destroy
	   	# flash[:notice] = 'Restaurant deleted successfully'
	   	# redirect_to '/restaurants'
	    # rescue ActiveRecord::RecordNotFound
	    # flash[:notice] = "You're not allowed to delete!"
	    # redirect_to root_path

	def create
		# @restaurant = Restaurant.find(params[:restaurant_id])
		# @restaurant.reviews.create(review_params)
		@restaurant = Restaurant.find(params[:restaurant_id])
		@review = @restaurant.reviews.new(review_params)
		@review.user = current_user
		if @review.save
			flash[:notice] = "Review successfuly saved"
			redirect_to restaurants_path
		else @review.delete
			flash[:notice] = "You have already reviewed this restaurant"
			redirect_to restaurants_path
		end
	end


	def review_params
		params.require(:review).permit(:thoughts, :rating)
	end

end
