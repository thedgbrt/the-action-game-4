class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :action_count
  
  def action_count
    object.aktions.try(:count)
  end
end
