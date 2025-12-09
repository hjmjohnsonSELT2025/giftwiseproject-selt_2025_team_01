class GiftIdeasController < ApplicationController
  before_action :require_login
  before_action :set_recipient
  before_action :set_gift_idea, only: [:edit, :update, :destroy]

  def new
    @gift_idea= @recipient.gift_ideas.build
  end

  def suggest
    suggestion = generate_ai_suggestion(@recipient)
    render json: suggestion
  end

  def create
    @gift_idea = @recipient.gift_ideas.build(gift_idea_params)
    if @gift_idea.save
      redirect_to @recipient, notice: "Gift idea was successfully created."
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @gift_idea.update(gift_idea_params)
      redirect_to recipient_path(@recipient), notice: "Gift idea was successfully updated."
    else
      render :edit, status: :unprocessable_entity
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

  def generate_ai_suggestion(recipient)
    # Build a prompt based on recipient's profile
    profile_info = []
    profile_info << "Name: #{recipient.name}"
    profile_info << "Age: #{recipient.age}" if recipient.age.present?
    profile_info << "Relationship: #{recipient.relationship}" if recipient.relationship.present?
    profile_info << "Hobbies: #{recipient.hobbies}" if recipient.hobbies.present?
    profile_info << "Dislikes: #{recipient.dislikes}" if recipient.dislikes.present?

    # For now, return a placeholder. You'll need to integrate with an AI API like OpenAI
    # Example: Use OpenAI's API, Anthropic's Claude, or another service
    {
      title: "AI-suggested gift for #{recipient.name}",
      notes: "Based on their profile: #{profile_info.join(', ')}. Consider their interests and preferences.",
      url: ""
    }
  end

end