class TripSerializer < ActiveModel::Serializer
  attributes :id, :destination, :created_at, :updated_at, :start_date, :end_date, :comment
end
