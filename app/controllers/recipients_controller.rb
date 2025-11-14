class RecipientsController < ApplicationController
  before_action :require_login
  before_action :set_recipient, only: [:edit, :update, :destroy]

  def index
    @recipients = current_user.recipients
  end

  def new
    @recipient = current_user.recipients.new
  end

  def create
    @recipient = current_user.recipients.new(recipient_params)

    if @recipient.save
      redirect_to recipients_path, notice: "Recipient added"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @recipient.update(recipient_params)
      redirect_to recipients_path, notice: "Recipient updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @recipient.destroy
    redirect_to recipients_path, notice: "Recipient deleted"
  end

  private

  def set_recipient
    @recipient = current_user.recipients.find(params[:id])
  end

  def recipient_params
    params.require(:recipient).permit(:name, :description)
  end

  def require_login
    redirect_to login_path unless current_user
  end
end
