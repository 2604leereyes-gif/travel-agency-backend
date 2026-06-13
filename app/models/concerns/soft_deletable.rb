module SoftDeletable
  extend ActiveSupport::Concern

  included do
    default_scope { where(deleted_at: nil) }
  end

  def destroy
    run_callbacks(:destroy) do
      soft_delete
    end
  end

  def soft_delete
    update(deleted_at: Time.current)
  end

  def restore
    update(deleted_at: nil)
  end

  def deleted?
    deleted_at.present?
  end

  class_methods do
    def view_deleted
      unscope(where: :deleted_at).where.not(deleted_at: nil)
    end

    def view_all
      unscope(where: :deleted_at)
    end
  end
end