# app/controllers/recipients_controller.rb
class RecipientsController < ApplicationController
  def index
    @recipients = Recipient.all
  end

  def show
    @recipient = Recipient.find(params[:id])
  end

  def new
    @recipient = Recipient.new
  end

  def create
    @recipient = Recipient.new(recipient_params)

    if @recipient.save
      flash[:notice] = "Recipient was successfully created"
      redirect_to @recipient
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def recipient_params
    params.require(:recipient).permit(
      :first_name,
      :last_name,
      :age,
      :occupation,
      :hobbies,
      :likes,
      :dislikes
    )
  end
end
