module StartBeforeEndConcern
  extend ActiveSupport::Concern

  included do
    validate :start_before_end
  end

  private

  def start_before_end
    errors.add :end_date, "must be after starts_at" if start_date && end_date && end_date <= start_date
  end
end
