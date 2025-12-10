class EventRecipientGiftIdeasController < ApplicationController
  before_action :require_login
  before_action :set_event
  before_action :set_recipient
  before_action :set_event_recipient
  before_action :set_gift_idea, only: [:edit, :update, :destroy]

  # GET /events/:event_id/recipients/:recipient_id/gift_ideas
  def index
    @gift_ideas = @event_recipient.event_recipient_gift_ideas
    redirect_to event_path(@event)
  end

  # GET /events/:event_id/recipients/:recipient_id/gift_ideas/new
  def new
    @gift_idea = @event_recipient.event_recipient_gift_ideas.new
  end

  # POST /events/:event_id/recipients/:recipient_id/gift_ideas
  def create
    @gift_idea = @event_recipient.event_recipient_gift_ideas.new(gift_idea_params)

    if @gift_idea.save
      flash[:notice] = "Gift idea created."
      redirect_to event_path(@event)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /events/:event_id/recipients/:recipient_id/gift_ideas/:id/edit
  def edit
  end

  # PATCH/PUT /events/:event_id/recipients/:recipient_id/gift_ideas/:id
  def update
    if @gift_idea.update(gift_idea_params)
      flash[:notice] = "Gift idea updated."
      redirect_to event_path(@event)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /events/:event_id/recipients/:recipient_id/gift_ideas/:id
  def destroy
    @gift_idea.destroy
    flash[:notice] = "Gift idea deleted."
    redirect_to event_path(@event)
  end

  private

  def set_event
    @event = current_user.events.find_by(id: params[:event_id])
    redirect_to events_path, alert: "Event not found." unless @event
  end

  def set_recipient
    @recipient = current_user.recipients.find_by(id: params[:recipient_id])
    redirect_to event_path(@event), alert: "Recipient not found." unless @recipient
  end

  def set_event_recipient
    @event_recipient = EventRecipient.find_by(event: @event, recipient: @recipient)
    redirect_to event_path(@event), alert: "Recipient is not part of this event." unless @event_recipient
  end

  def set_gift_idea
    @gift_idea = @event_recipient.event_recipient_gift_ideas.find_by(id: params[:id])
    redirect_to event_path(@event), alert: "Gift idea not found." unless @gift_idea
  end

  def gift_idea_params
    params.require(:event_recipient_gift_idea).permit(:title, :notes, :url)
  end

  def require_login
    redirect_to login_path unless current_user
  end
end