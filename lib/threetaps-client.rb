require 'rubygems'
require 'cgi'
require 'supermodel'
require 'active_support'
require 'curb'
require 'struct'

module ThreeTaps
  VERSION = '1.0.11'
end

require 'client/client'
require 'client/search_client'
require 'client/posting_client'
require 'client/geocoder_client'
require 'client/reference_client'
require 'client/search_client'
require 'client/status_client'


require 'dto/geocoder/geocoder_request'
require 'dto/geocoder/geocoder_response'

require 'dto/posting/create_response'
require 'dto/posting/delete_response'
require 'dto/posting/update_response'
require 'dto/posting/exists_response'

require 'dto/status/get_status_response'
require 'dto/status/status_update_request'

require 'dto/search/best_match_response'
require 'dto/search/count_response'
require 'dto/search/range_response'
require 'dto/search/range_request'
require 'dto/search/search_response'
require 'dto/search/search_request'
require 'dto/search/summary_response'
require 'dto/search/summary_request'

require 'models/category'
require 'models/location'
require 'models/message'
require 'models/posting'
require 'models/posting_history'
require 'models/source'
require 'models/annotations/annotation'
require 'models/annotations/annotation_option'

