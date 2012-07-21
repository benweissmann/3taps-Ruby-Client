module ThreeTaps
  # Class Message represents structure of message
  #
  #  message = Message.new
  #  message.code    # => Integer
  #  message.message # => String
  #
  class Message < Struct.new(:code, :message)

  end
end