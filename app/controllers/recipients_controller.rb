class RecipientsController < ApplicationController
  before_action :require_login
  before_action :set_recipient, only: [:edit, :update, :destroy, :show]

  # [MODEL & VIEW] Lists all recipients.
  # Queries the User model (current_user) to fetch associated recipients (has_many association).
  # Passes the collection @recipients to the 'index' View for iteration and display.
  def index
    @recipients = current_user.recipients
  end

  # [MODEL & VIEW] Prepares the form for a new recipient.
  # Initializes a new Recipient object scoped to the current_user (ensuring foreign keys are set).
  # Used by the 'new' View to build the form.
  def new
    @recipient = current_user.recipients.new
  end

  # [MODEL] Processes the form submission to create a record.
  # 1. Accepts parameters.
  # 2. Attempts to save to the database via the Model.
  # 3. Redirects (Controller logic) on success or renders 'new' (View) on failure.
  def create
    @recipient = current_user.recipients.new(recipient_params)

    if @recipient.save
      redirect_to @recipient, notice: "Recipient added"
    else
      render :new, status: 422
    end
  end

  # [VIEW] Renders the edit form.
  # The actual data fetching happens in the `set_recipient` private method (Model interaction).
  # Rails automatically renders 'edit.html.erb' here.
  def edit
  end

  # [MODEL] Handles database updates.
  # Updates the instance variable @recipient (set by before_action) with new params.
  # If Model validations pass, redirects to the 'show' View (via @recipient path).
  def update
    if @recipient.update(recipient_params)
      redirect_to @recipient, notice: "Recipient updated"
    else
      render :edit, status: 422
    end
  end

  # [MODEL] Removes a record from the database.
  # Triggers the destroy method on the @recipient model instance.
  # Redirects to the index View/action after deletion.
  def destroy
    @recipient.destroy
    redirect_to recipients_path, notice: "Recipient deleted"
  end

  # [VIEW] Displays a single recipient.
  # The data is fetched via `set_recipient` (Model).
  # Rails implicitly renders 'show.html.erb' using the @recipient data.
  def show
    # no need to do anything here—set_recipient already sets @recipient
    # Rails will render show.html.erb automatically
  end

  private

  # [MODEL] Helper method to keep code DRY (Don't Repeat Yourself).
  # Finds a specific Recipient record belonging to the logged-in User based on the URL ID parameter.
  # Prevents users from accessing recipients they don't own (Security).
  def set_recipient
    @recipient = current_user.recipients.find_by(id: params[:id])
    redirect_to recipients_path, alert: "Recipient not found" unless @recipient
  end

  # [CONTROLLER] Whitelists allowed form fields for mass assignment to the Model.
  def recipient_params
    params.require(:recipient).permit(
      :name,
      :age,
      :relationship,
      :hobbies,
      :dislikes
    )
  end

  # [CONTROLLER] Authentication guard.
  # Ensures no actions in this controller can be accessed unless a user is logged in.
  def require_login
    redirect_to login_path unless current_user
  end
end
