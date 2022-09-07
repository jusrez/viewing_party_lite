class UsersController < ApplicationController
  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to "/users/#{user.id}"
    else
      flash[:alert] = "Error: #{error_message(user.errors)}"
      redirect_to '/register'
    end
  end

  def show
    @user = User.find(params[:id])
    @viewing_parties = @user.viewing_parties
    movie_ids = @viewing_parties.map { |vp| vp.movie_id }
    @movies = MovieFacade.movies(movie_ids)
  end

  def login_form
  end

  def login_user
    user = User.find_by(email: params[:email])
    flash[:success] = "Welcome, #{user.name}"
    redirect_to user_path(user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
