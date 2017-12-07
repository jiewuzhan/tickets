module Tickets
  class Trains
    attr_accessor :options, :available_trains

    @@head ||= '车次 车站 时间 历时 一等座 二等座 软卧 硬卧 硬座 无座'.split()

    def initialize(available_trains, options)
      @available_trains = available_trains
      @options = options
    end

    def pretty_print
      table = Terminal::Table.new(headings: @@head, rows: format_trains) do |t|
        t.title = "#{options[:from].colorize(:blue)}到#{options[:to].colorize(:red)}余票查询-#{options[:date].colorize(:green)}"
        # t.style = { border_x: '=', all_separators: true  }
      end

      puts table
    end

    private
    def filters
      [:gaotie, :kuaisu, :tekuai, :zhida, :dongche].select { |s| options[s] }.map { |s| s[0] }
    end

    def format_trains
      trains = available_trains.map { |raw_train| raw_train.split('|') }.select { |train_ary| filters.empty? || filters.include?(train_ary[3][0].downcase) }

      trains.map do |train_ary|
        [
          train_ary[3],
          [
            Tickets::Stations.hash_format.key(train_ary[6]).colorize(:blue), 
            Tickets::Stations.hash_format.key(train_ary[7]).colorize(:red)
          ].join("\n"),
          [
            train_ary[8].colorize(:blue), 
            train_ary[9].colorize(:red)
          ].join("\n"),
          train_ary[10], train_ary[31] || '--', train_ary[30] || '--',
          train_ary[23] || '--', train_ary[28] || '--', train_ary[29] || '--', train_ary[26] || '--'
        ] 
      end
    end

  end
end
