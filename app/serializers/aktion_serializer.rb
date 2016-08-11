class AktionSerializer < ActiveModel::Serializer
  attributes :timeslot, :focus, :player_name, :verb_name, :project_name, :team_name, :role_name, :flow, :flow_notes, :value, :value_notes
  
  def verb_name
    object.verb.try(:name)
  end

  def project_name
    object.project.try(:name)
  end

  def team_name
    object.team.try(:name)
  end

  def role_name
    object.role.try(:name)
  end

  def player_name
    object.player.try(:name)
  end
end
