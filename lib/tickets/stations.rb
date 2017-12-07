module Tickets
  class Stations
    def self.hash_format
      @@stations ||= get_stations
    end

    def self.get_stations
      url = %(https://kyfw.12306.cn/otn/resources/js/framework/station_name.js?station_version=1.9033)
      resp = RestClient::Request.execute(url: url, method: :get, verify_ssl: false)
      resp.scan(/([\u4e00-\u9fa5]+)\|([A-Z]+)/).to_h
    end
  end
end
