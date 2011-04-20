provides "redis"
redis Mash.new

begin
  require 'redis'
rescue LoadError => e
  Ohai::Log.warn e.message
end

port = 6379
info = Mash.new(Redis.new(:port => port).info).symbolize_keys

redis[:version]                    = info[:redis_version]
redis[:arch_bits]                  = info[:arch_bits]
redis[:multiplexing_api]           = info[:multiplexing_api]
redis[:process_id]                 = info[:process_id]
redis[:uptime_in_seconds]          = info[:uptime_in_seconds]
redis[:uptime_in_days]             = info[:uptime_in_days]
redis[:lru_clock]                  = info[:lru_clock]
redis[:used_cpu_sys]               = info[:used_cpu_sys]
redis[:used_cpu_user]              = info[:used_cpu_user]
redis[:used_cpu_sys_childrens]     = info[:used_cpu_sys_childrens]
redis[:used_cpu_user_childrens]    = info[:used_cpu_user_childrens]
redis[:connected_clients]          = info[:connected_clients]
redis[:connected_slaves]           = info[:connected_slaves]
redis[:client_longest_output_list] = info[:client_longest_output_list]
redis[:client_biggest_input_buf]   = info[:client_biggest_input_buf]
redis[:blocked_clients]            = info[:blocked_clients]
redis[:used_memory]                = info[:used_memory]
redis[:used_memory_human]          = info[:used_memory_human]
redis[:used_memory_rss]            = info[:used_memory_rss]
redis[:mem_fragmentation_ratio]    = info[:mem_fragmentation_ratio]
redis[:use_tcmalloc]               = info[:use_tcmalloc]
redis[:loading]                    = info[:loading]
redis[:aof_enabled]                = info[:aof_enabled]
redis[:changes_since_last_save]    = info[:changes_since_last_save]
redis[:bgsave_in_progress]         = info[:bgsave_in_progress]
redis[:last_save_time]             = info[:last_save_time]
redis[:bgrewriteaof_in_progress]   = info[:bgrewriteaof_in_progress]
redis[:total_connections_received] = info[:total_connections_received]
redis[:total_commands_processed]   = info[:total_commands_processed]
redis[:expired_keys]               = info[:expired_keys]
redis[:evicted_keys]               = info[:evicted_keys]
redis[:keyspace_hits]              = info[:keyspace_hits]
redis[:keyspace_misses]            = info[:keyspace_misses]
redis[:hash_max_zipmap_entries]    = info[:hash_max_zipmap_entries]
redis[:hash_max_zipmap_value]      = info[:hash_max_zipmap_value]
redis[:pubsub_channels]            = info[:pubsub_channels]
redis[:pubsub_patterns]            = info[:pubsub_patterns]
redis[:vm_enabled]                 = info[:vm_enabled]
redis[:role]                       = info[:role]