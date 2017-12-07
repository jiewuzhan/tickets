
module Tickets
  class Cli 
    attr_accessor :options

    def initialize(options)
      @options = options
    end

    def query
      from = Tickets::Stations.hash_format[options[:from]]
      to = Tickets::Stations.hash_format[options[:to]]
      url = "https://kyfw.12306.cn/otn/leftTicket/query?leftTicketDTO.train_date=#{options[:date]}&leftTicketDTO.from_station=#{from}&leftTicketDTO.to_station=#{to}&purpose_codes=ADULT"
      
      resp = RestClient::Request.execute(url: url, method: :get, verify_ssl: false)
      available_trains = JSON.parse(resp)['data']['result']
      Tickets::Trains.new(available_trains, options).pretty_print      
    end
  end
end