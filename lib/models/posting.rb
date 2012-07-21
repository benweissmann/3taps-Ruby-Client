module ThreeTaps
  # Class Posting represents structure of posting:
  #
  #  posting = Posting.new
  #  posting.postKey            # => String
  #  posting.heading            # => String
  #  posting.body               # => String
  #  posting.category           # => Boolean
  #  posting.source             # => Array of Annotation objects
  #  posting.location           # => String
  #  posting.longitude          # => Float
  #  posting.latitude           # => Float
  #  posting.language           # => String
  #  posting.price              # => String
  #  posting.currency           # => String
  #  posting.images             # => Array of String objects
  #  posting.externalURL        # => String
  ##  posting.externalID         # => String
  #  posting.accountName        # => String
  #  posting.accountID          # => String
  #  posting.clickCount         # => Integer
  #  posting.timestamp          # => Date
  #  posting.expiration         # => Date
  #  posting.indexed            # => Date
  #  posting.trustedAnnotations # => Array of Annotation objects
  #  posting.annotations        # => Array of Annotation objects
  #  posting.errors             # => Array of String objects
  #  posting.status             # => String
  #  posting.history            # => String

  #  posting.to_json                   # => Array of JSON objects
  #  posting.to_json_for_update        # => Array of JSON objects
  #  posting.to_json_for_status_client # => Array of JSON objects
  #  posting.to_json_for_status        # => Array of JSON objects
  class Posting < SuperModel::Base
    attributes :postKey, :heading, :body, :category, :source, :location,
      :longitude, :latitude, :language, :price, :currency, :images,
      :externalURL, :externalID, :accountName, :accountID, :clickCount,
      :timestamp, :expiration, :indexed, :trustedAnnotations,
      :annotations, :errors, :status, :history
    def initialize(*params)
      super(*params)
      @attributes[:images] ||= []
      @attributes[:annotations] ||= {}
      @attributes[:status] ||= StatusUpdateRequest.from_hash(:event => '', :timestump => nil, :attributes => {}, :errors => [])
    end

    def to_json
      posting = "{"+'source:'+"'#{self.source}'" + ',category:' + "'#{self.category}'" + ',location:' + "'#{self.location}'" + ',heading:' +  "'#{self.heading.to_s[0,254]}'"
      if self.timestamp
        posting << ",timestamp: '#{(Time.at(self.timestamp).utc.to_s(:db)).gsub("-","/")}'"
      else
        posting << ",timestamp: '#{(Time.now.utc.to_s(:db)).gsub("-","/")}'"
      end
      posting << ',images:' + "[#{images.collect{ |image| "'#{image}'"}.join(',')}]"
      unless self.body.blank?
        self.body.gsub!(/[&']/,"")
        #self.body.gsub!(/\s*<[^>]*>/,"")
        posting << ',body:' + "'#{ActiveSupport::JSON.encode(self.body)}'"
      end
      posting <<  ',price:' + "#{self.price.to_f}"
      posting <<  ',currency:' + "'#{self.currency}'"
      posting <<  ',accountName:' + "'#{self.accountName}'"
      posting <<  ',accountID:' + "'#{self.accountID}'"
      posting <<  ',externalURL:' + "'#{self.externalURL}'"
      posting <<  ',externalID:' + "'#{self.externalID}'"
      if self.annotations
        annotations = []
        self.annotations.each{|k,v| annotations << "#{k}:" + "'#{v}'"}
        posting << ',annotations:' + "{#{annotations.join(',')}}"
      end
      posting  +  "}"
    end

    def to_json_for_update
      data = "['#{self.postKey}',"
      data << "{heading:"+  "'#{self.heading}'"  unless self.heading.blank?
      data << ",images:" + "[#{images.collect{ |image| "'#{image}'"}.join(',')}]"
      data << ",source:'#{self.source}'" unless self.source.blank?
      data << ",category:'#{self.category}'" unless self.category.blank?
      data << ",location:'#{self.location}'" unless self.location.blank?
      data << ",body:" + "'#{self.body}'" unless self.body.blank?
      data <<  ',price:' + "'#{self.price}'"
      data <<  ',currency:' + "'#{self.currency}'"
      data <<  ',accountName:' + "'#{self.accountName}'"
      data <<  ',accountID:' + "'#{self.accountID}'"
      data <<  ',externalURL:' + "'#{self.externalURL}'"
      data <<  ',externalID:' + "'#{self.externalID}'"
      if self.annotations
        annotations = []
        self.annotations.each{|k,v| annotations << "#{k}:" + "'#{v}'"}
        data << ",annotations:" + "{#{annotations.join(',')}}"
      end
      data << "}"
      data << "]"
    end

    def to_json_for_status
      # {source: 'CRAIG', externalID: 3434399120}
      data = "source:'#{self.source}', " unless self.source.blank?
      data << "externalID: '#{self.externalID}'" unless self.externalID.blank?
      data
    end
    def to_json_for_status_client
      # source: 'CRAIG', externalID: 3434399120
      data = "source:'#{self.source}', " unless self.source.blank?
      data << "externalID: '#{self.externalID}'" unless self.externalID.blank?
      data
    end

  end
end