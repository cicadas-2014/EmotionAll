class Cache

  attr_reader :map_info, :updated_at

  def initialize
    @map_info = {}

    if ActiveRecord::Base.connection.table_exists?('trends')
      Trend.most_popular(30).each do |t|
        @map_info[t.id] = Trend.map_info(t.id)
      end
      @updated_at = Time.now
    end
  end
end

Rails.cache.write('cache', Cache.new)
