class GiftIdeasController < ApplicationController
  before_action :require_login
  before_action :set_recipient
  before_action :set_gift_idea, only: [:destroy]

  def new
    @gift_idea= @recipient.gift_ideas.build
  end

  def create
    @gift_idea = @recipient.gift_ideas.build(gift_idea_params)
    if @gift_idea.save
      redirect_to recipients_path, notice: "Gift idea added."
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def destroy
    @gift_idea.destroy
    redirect_to recipient_path(@recipient), notice: "Gift idea deleted."
  end

  private

  def set_recipient
    @recipient= current_user.recipients.find(params[:recipient_id])
  end

  def set_gift_idea
    @gift_idea = @recipient.gift_ideas.find(params[:id])
  end

  def gift_idea_params
    params.require(:gift_idea).permit(:title, :notes, :url)
  end


end