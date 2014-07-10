# class Cache

#   attr_reader :map_info, :updated_at

#   def initialize
#     @map_info = {}
#     if Object.const_defined?('Trend')
#       Trend.all.each do |t|
#         @map_info[t.id] = Trend.map_info(t.id)
#       end
#     end
#     @updated_at = Time.now
#   end

# end

# Rails.cache.write('cache', Cache.new)
