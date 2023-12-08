class AtmSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :address, :lat, :lng, :distance
end