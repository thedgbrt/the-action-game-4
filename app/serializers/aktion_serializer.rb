class AktionSerializer < ActiveModel::Serializer
  attributes :id, :focus, :verb, :project_name
  
  def fake_rating
    rand(30..95)
  end

  def verb_name
    object.verb.try(:name)
  end

  def project_name
    object.project.try(:name)
  end
end
