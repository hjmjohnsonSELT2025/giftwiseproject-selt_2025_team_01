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

    # Clearer more direct prompt
    prompt_message = <<~PROMPT
      Please suggest ONE specific gift for this person.
      
      CRITICAL: If they have multiple hobbies (e.g., "basketball, running, gaming"), you MUST consider ALL of them:
      - First, look for gifts that combine 2+ hobbies (e.g., fitness tracker for running + gaming rewards)
      - If no combo gift works, pick the most unique or distinctive hobby
      - DO NOT just focus on the first hobby listed
      
      Recipient Profile:
      #{profile_info.join("\n")}
      
      Provide a real product that can be purchased online with a working URL.
    PROMPT

    ChatService.new(message: prompt_message).call
  end

end