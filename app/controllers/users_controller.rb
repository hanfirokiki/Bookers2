class UsersController < ApplicationController
  before_action :current_user, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    unless @user.id == current_user.id
     redirect_to user_path(current_user.id)
    end
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
        flash[:notice] = "You have updated user successfully"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
     #user = User.find(params[:id])
   #unless user.id == current_user.id
    # redirect_to user_path
   #end
  end
  def index
      @user = current_user
      @book = Book.new
      @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
        flash[:notice] = "You have updated user successfully"
     redirect_to user_path(@user.id)
    else
     render :new
    end
  end

  private

   def user_params
     params.require(:user).permit(:name, :image, :introduction)
   end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
   end
end