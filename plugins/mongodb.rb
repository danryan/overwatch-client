provides "mongo"
mongo Mash.new

begin
  require 'mongo'
rescue LoadError => e
  Ohai::Log.warn e.message
end

connection = Mongo::Connection.new
server_stats = connection.db("local").command('serverStatus' => 1)

mongo[:version] = server_stats['version']
mongo[:uptime] = server_stats['uptime']
mongo[:host] = server_stats['host']
mongo[:uptime_estimate] = server_stats['uptimeEstimate']

# DB stats
mongo[:databases] = {}
connection.database_names.map(&:to_sym).each do |db_name|
  stats = connection.db(db_name).stats
  mongo[:databases][db_name]                = Mash.new
  mongo[:databases][db_name][:collections]  = stats['collections']
  mongo[:databases][db_name][:objects]      = stats['objects']
  mongo[:databases][db_name][:indexes]      = stats['indexes']
  mongo[:databases][db_name][:data_size]    = stats['dataSize']
  mongo[:databases][db_name][:storage_size] = stats['storageSize']
  mongo[:databases][db_name][:file_size]    = stats['fileSize']
  mongo[:databases][db_name][:avg_obj_size] = stats['avgObjSize']
  mongo[:databases][db_name][:index_size]   = stats['indexSize']
  mongo[:databases][db_name][:num_extents]  = stats['numExtents']
end

# Connections
mongo[:connections]             = Mash.new
mongo[:connections][:current]   = server_stats['connections']['current']
mongo[:connections][:available] = server_stats['connections']['available']

# Memory usage
mongo[:memory]             = Mash.new
mongo[:memory][:resident]  = server_stats['mem']['resident']
mongo[:memory][:virtual]   = server_stats['mem']['virtual']
mongo[:memory][:supported] = server_stats['mem']['supported']
mongo[:memory][:mapped]    = server_stats['mem']['mapped']

# Global lock
mongo[:global_lock]                            = Mash.new
mongo[:global_lock][:ratio]                    = server_stats['globalLock']['ratio']
mongo[:global_lock][:current_queue]            = Mash.new
mongo[:global_lock][:current_queue][:total]    = server_stats['globalLock']['currentQueue']['total']
mongo[:global_lock][:current_queue][:readers]  = server_stats['globalLock']['currentQueue']['readers']
mongo[:global_lock][:current_queue][:writers]  = server_stats['globalLock']['currentQueue']['writers']
mongo[:global_lock][:active_clients]           = Mash.new
mongo[:global_lock][:active_clients][:total]   = server_stats['globalLock']['activeClients']['total']
mongo[:global_lock][:active_clients][:readers] = server_stats['globalLock']['activeClients']['readers']
mongo[:global_lock][:active_clients][:writers] = server_stats['globalLock']['activeClients']['writers']


# Index counters
mongo[:index_counters]              = Mash.new
mongo[:index_counters][:accesses]   = server_stats['indexCounters']['btree']['accesses']
mongo[:index_counters][:hits]       = server_stats['indexCounters']['btree']['hits']
mongo[:index_counters][:misses]     = server_stats['indexCounters']['btree']['misses']
mongo[:index_counters][:resets]     = server_stats['indexCounters']['btree']['resets']
mongo[:index_counters][:miss_ratio] = server_stats['indexCounters']['btree']['missRatio']

# Background flushing
mongo[:background_flushing]                 = Mash.new
mongo[:background_flushing][:flushes]       = server_stats['backgroundFlushing']['flushes']
mongo[:background_flushing][:total_ms]      = server_stats['backgroundFlushing']['average_ms']
mongo[:background_flushing][:last_ms]       = server_stats['backgroundFlushing']['last_ms']
mongo[:background_flushing][:last_finished] = server_stats['backgroundFlushing']['last_finished'].to_s

# Op counters
mongo[:op_counters]           = Mash.new
mongo[:op_counters][:insert]  = server_stats['opcounters']['insert']
mongo[:op_counters][:query]   = server_stats['opcounters']['query']
mongo[:op_counters][:update]  = server_stats['opcounters']['update']
mongo[:op_counters][:delete]  = server_stats['opcounters']['delete']
mongo[:op_counters][:getmore] = server_stats['opcounters']['getmore']
mongo[:op_counters][:command] = server_stats['opcounters']['command']

# Asserts
mongo[:asserts]             = Mash.new
mongo[:asserts][:regular]   = server_stats['asserts']['regular']
mongo[:asserts][:warning]   = server_stats['asserts']['warning']
mongo[:asserts][:msg]       = server_stats['asserts']['msg']
mongo[:asserts][:user]      = server_stats['asserts']['user']
mongo[:asserts][:rollovers] = server_stats['asserts']['rollovers']

# Network
mongo[:network]                = Mash.new
mongo[:network][:bytes_in]     = server_stats['network']['bytesIn']
mongo[:network][:bytes_out]    = server_stats['network']['bytesOut']
mongo[:network][:num_requests] = server_stats['network']['numRequests']

# Replica Set

begin
  admin = connection.db("admin")
  repl_stats = admin.command('replSetGetStatus' => 1)
rescue Mongo::OperationFailure => e
  Ohai::Log.warn e.message
end

mongo[:repl_set] = Mash.new
mongo[:repl_set][:set] = repl_set['set']
mongo[:repl_set][:date] = repl_set['date']
mongo[:repl_set][:my_state] = repl_set['myState']
mongo[:repl_set][:members] = []
repl_set['members'].each do |member|
  mongo[:repl_set][:members] << member.symbolize_keys
end