class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :follower_list, :following_list]

  # GET /users/1
  # GET /users/1.json
  def show
    redirect_to main_menu_path if @user.blocking?(current_user)
    @records = @user.records.page(params[:records_page]).per(5).order("created_at DESC")
    @create_questions = @user.create_questions.page(params[:create_questions_page]).per(5).order(:id)
    @solve_questions = @user.questions.page(params[:solve_questions_page]).per(5).order(:id)
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if current_user != @user
      redirect_to :user
    end
  end

  def do_follow
    @user = User.find_by(account: params[:follow_account])
    current_user.follow @user 
    redirect_to @user
  end

  def do_unfollow
    @user = User.find_by(account: params[:follow_account])
    current_user.unfollow @user
    redirect_to @user
  end

  def do_block
    @user = User.find_by(account: params[:block_account])
    current_user.block @user 
    redirect_to @user
  end

  def do_unblock
    @user = User.find_by(account: params[:block_account])
    current_user.unblock @user
    redirect_to @user
  end

  def follower_list
    @users = @user.followers.order(:id).page(params[:page]).per(10)
  end

  def following_list
    @users = @user.following.order(:id).page(params[:page]).per(10)
  end

  def search_result
     @users = User.search(params[:search]).page(params[:page]).per(10)
  end
  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.solved_question_number = 0
    @user.created_question_number = 0
    respond_to do |format|
      if @user.save
       log_in @user
       format.html { redirect_to @user, notice: 'User was successfully created.' }
       format.json { render :show, status: :created, location: @user }
     else
      format.html { render :new }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end
end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to home_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by(name: params[:name])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:account, :name, :password, :password_confirmation, :passward_digest, :image)
    end
  end