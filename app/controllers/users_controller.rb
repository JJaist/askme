class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :authorize_user, only: %i[edit update destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id

      redirect_to root_path, notice: 'Вы успешно зарегистрировались!'
    else
      flash.now[:alert] = 'Не верно заполнены поля регистрации'

      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)

      redirect_to root_path, notice: 'Данные пользователя обновлены'
    else
      flash.now[:alert] = 'Возникла ошибка при попытке сохранения'

      render :edit
    end
  end

  def destroy
    @user.destroy

    session.delete(:user_id)

    redirect_to root_path, notice: 'Пользователь удален'
  end

  def show
    @questions = @user.questions.order(created_at: :desc)
    @question = Question.new(user: @user)
  end

  private

  def user_params
  params.require(:user).permit(
        :name, :nickname, :email, :header_color, :password, :password_confirmation
  )
  end

  def set_user
    @user = User.find_by(nickname: params[:nickname])
  end

  def authorize_user
    redirect_with_alert unless @user == current_user
  end
end
