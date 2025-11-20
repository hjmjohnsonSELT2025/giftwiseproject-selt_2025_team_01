class RecipientsController < ApplicationController
  before_action :require_login
  before_action :set_recipient, only: [:edit, :update, :destroy, :show]

  def index
    @recipients = current_user.recipients
  end

  def new
    @recipient = current_user.recipients.new
  end

  def create
    @recipient = current_user.recipients.new(recipient_params)

    if @recipient.save
      redirect_to @recipient, notice: "Recipient added"
    else
      render :new, status: 422
    end
  end

  def edit
  end

  def update
    if @recipient.update(recipient_params)
      redirect_to @recipient, notice: "Recipient updated"
    else
      render :edit, status: 422
    end
  end

  def destroy
    @recipient.destroy
    redirect_to recipients_path, notice: "Recipient deleted"
  end

  def show
    # no need to do anything here—set_recipient already sets @recipient
    # Rails will render show.html.erb automatically
  end

  private

  def set_recipient
    @recipient = current_user.recipients.find_by(id: params[:id])
    redirect_to recipients_path, alert: "Recipient not found" unless @recipient
  end

  def recipient_params
    params.require(:recipient).permit(
      :name,
      :age,
      :relationship,
      :hobbies,
      :dislikes
    )
  end

  def require_login
    redirect_to login_path unless current_user
  end
end
