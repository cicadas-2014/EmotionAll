class Cache

  attr_reader :map_info, :updated_at

  def initialize
    @map_info = {}
    # binding.pry
    if ActiveRecord::Base.connection.table_exists?('trends')
      Trend.all.each do |t|
        @map_info[t.id] = Trend.map_info(t.id)
      end
      @updated_at = Time.now
    end
  end
end

Rails.cache.write('cache', Cache.new)
