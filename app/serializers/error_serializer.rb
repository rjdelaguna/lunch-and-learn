class ErrorSerializer
  include JSONAPI::Serializer
  attributes :message, :status_code
end