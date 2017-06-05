class TopicPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    super && user.admin?
  end

  def update?
    create?
  end

  def destroy?
    update?
  end
end