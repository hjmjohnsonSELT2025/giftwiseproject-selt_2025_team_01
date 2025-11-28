class EventsController < ApplicationController
  # [CONTROLLER] Ensure the user is logged in before accessing any event actions.
  before_action :require_login

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
