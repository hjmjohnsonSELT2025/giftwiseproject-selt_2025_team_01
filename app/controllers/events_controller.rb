class EventsController < ApplicationController
  # [CONTROLLER] Ensure the user is logged in before accessing any event actions.
  #before_action :require_login

  # [MODEL] Fetches the Event instance for certain actions to avoid repeating code.
  # Ensures users can only edit/update/destroy/show their own events.
  before_action :set_event, only: [:edit, :update, :destroy, :show]

  # [MODEL & VIEW] Lists all events belonging to the current user.
  # Passes @events to the index view for iteration and display.
  def index
    @events = current_user.events
  end

  # [MODEL & VIEW] Prepares a new Event instance for the 'new' form.
  # Scoped to current_user to automatically assign user_id when saving.
  def new
    @event = current_user.events.build
  end

  # [MODEL & CONTROLLER] Processes form submission to create a new Event.
  # 1. Builds a new Event with permitted params.
  # 2. Saves it to the database.
  # 3. Redirects to index on success, or re-renders 'new' view if validation fails.
  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to events_path, notice: 'Event created!'
    else
      render :new
    end
  end

  # [VIEW] Prepares the edit form for an existing event.
  # @event is set by set_event before_action.
  def edit; end

  # [MODEL & CONTROLLER] Updates an existing Event.
  # If validations pass, redirects to the index; otherwise, re-renders the edit form.
  def update
    if @event.update(event_params)
      redirect_to events_path, notice: 'Event updated!'
    else
      render :edit
    end
  end

  # [MODEL & CONTROLLER] Deletes an existing Event.
  # Redirects to the events index after deletion.
  def destroy
    @event.destroy
    redirect_to events_path, notice: 'Event deleted'
  end

  # [VIEW] Shows a single Event (optional for now).
  # Uses @event set in set_event.
  def show
    # Rails will automatically render show.html.erb
  end

  # ========================
  # Recipient stuff below
  # ========================

  # [MODEL & CONTROLLER] Assigns a recipient to an event.
  # POST /events/:id/add_recipient
  # - Fetches the event owned by the current user.
  # - Fetches the recipient owned by the current user.
  # - Adds the recipient to the event unless already assigned.
  # - Redirects back to the event show page.
  #
  # This action creates a new join table entry in event_recipients,
  # enabling many-to-many assignment of recipients to events.
  def add_recipient
    @event = current_user.events.find(params[:id])
    recipient = current_user.recipients.find(params[:recipient_id])

    # Add recipient if not already associated
    @event.recipients << recipient unless @event.recipients.include?(recipient)

    redirect_to event_path(@event), notice: "Recipient added."
  end

  # [MODEL & CONTROLLER] Removes a recipient from an event.
  # DELETE /events/:id/remove_recipient
  # - Fetches the event owned by the current user.
  # - Fetches the recipient owned by the current user.
  # - Deletes the corresponding join table entry.
  # - Redirects back to the event show page.
  #
  # This allows users to dynamically manage which recipients belong to
  # which events without deleting the recipient itself.
  def remove_recipient
    @event = current_user.events.find(params[:id])
    recipient = current_user.recipients.find(params[:recipient_id])

    # Find the join record and destroy it to trigger dependent: :destroy
    event_recipient = @event.event_recipients.find_by(recipient_id: recipient.id)
    event_recipient.destroy if event_recipient

    redirect_to event_path(@event), notice: "Recipient removed."
  end

  private

  # [MODEL] DRY helper method to fetch a specific Event belonging to the logged-in user.
  # Prevents access to events owned by other users (security).
  def set_event
    @event = current_user.events.find_by(id: params[:id])
    redirect_to events_path, alert: 'Event not found' unless @event
  end

  # [CONTROLLER] Strong parameters for mass assignment protection.
  # Only allows safe attributes to be written to the database.
  def event_params
    params.require(:event).permit(:name, :date, :description, :theme, :budget)
  end
end
