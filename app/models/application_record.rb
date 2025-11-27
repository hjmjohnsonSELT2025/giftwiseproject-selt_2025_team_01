class ApplicationRecord < ActiveRecord::Base
  # [MODEL] Base class for all models in the application.
  # This class inherits from ActiveRecord::Base, which provides the Object-Relational Mapping (ORM)
  # capabilities (connecting Ruby classes to database tables).

  # Tells Rails that this is an abstract class and there is no 'application_records' table.
  # All other models (like User, Recipient) will inherit from this class to share configuration.
  primary_abstract_class
end
