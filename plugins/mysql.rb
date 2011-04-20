provides "mysql"
mysql Mash.new

begin
  require 'mysql'
rescue LoadError => e
  Ohai::Log.warn e.message
end

user = nil
passwd = nil
port = nil
connection = Mysql.connect("localhost", user, passwd, nil, port )

global_status = Mash.new

raw_status = connection.query("SHOW GLOBAL STATUS")
raw_status.each do |row|
  global_status[row.first] = row.last.to_i
end

variables = Mash.new

raw_variables = connection.query("SHOW VARIABLES")
raw_variables.each do |row|
  variables[row.first] = row.last.to_i
end

mysql[:max_used_connections] = global_status['Max_used_connections']
mysql[:connections]          = global_status['Connections']
mysql[:slow_queries]         = global_status['Slow_queries']

# Threads
mysql[:threads_cached]       = global_status['Threads_cached']
mysql[:threads_connected]    = global_status['Threads_connected']
mysql[:threads_created]      = global_status['Threads_created']
mysql[:threads_running]      = global_status['Threads_running']

# Errors
mysql[:aborted_clients]      = global_status['Aborted_clients']
mysql[:aborted_connects]     = global_status['Aborted_connects']

# Network

mysql[:bytes_received] = global_status['Bytes_received']
mysql[:bytes_sent]     = global_status['Bytes_sent']

# Temp tables

mysql[:created_tmp_disk_tables] = global_status["Created_tmp_disk_tables"]
mysql[:created_tmp_files]       = global_status["Created_tmp_files"]
mysql[:created_tmp_tables]      = global_status["Created_tmp_tables"]

mysql[:table_locks_waited]      = global_status["Table_locks_waited"]

# InnoDB

mysql[:innodb_buffer_pool_pages_data]          = global_status["Innodb_buffer_pool_pages_dirty"]
mysql[:innodb_buffer_pool_pages_dirty]         = global_status["Innodb_buffer_pool_pages_flushed"]
mysql[:innodb_buffer_pool_pages_flushed]       = global_status["Innodb_buffer_pool_pages_free"]
mysql[:innodb_buffer_pool_pages_free]          = global_status["Innodb_buffer_pool_pages_misc"]
mysql[:innodb_buffer_pool_pages_misc]          = global_status["Innodb_buffer_pool_pages_total"]
mysql[:innodb_buffer_pool_pages_total]         = global_status["Innodb_buffer_pool_read_ahead"]
mysql[:innodb_buffer_pool_read_ahead]          = global_status["Innodb_buffer_pool_read_ahead_evicted"]
mysql[:innodb_buffer_pool_read_ahead_evicted]  = global_status["Innodb_buffer_pool_read_requests"]
mysql[:innodb_buffer_pool_read_requests]       = global_status["Innodb_buffer_pool_reads"]
mysql[:innodb_buffer_pool_reads]               = global_status["Innodb_buffer_pool_wait_free"]
mysql[:innodb_buffer_pool_wait_free]           = global_status["Innodb_buffer_pool_write_requests"]
mysql[:innodb_buffer_pool_write_requests]      = global_status["Innodb_data_fsyncs"]
mysql[:innodb_data_fsyncs]                     = global_status["Innodb_data_pending_fsyncs"]
mysql[:innodb_data_pending_fsyncs]             = global_status["Innodb_data_pending_reads"]
mysql[:innodb_data_pending_reads]              = global_status["Innodb_data_pending_writes"]
mysql[:innodb_data_pending_writes]             = global_status["Innodb_data_read"]
mysql[:innodb_data_read]                       = global_status["Innodb_data_reads"]
mysql[:innodb_data_reads]                      = global_status["Innodb_data_writes"]
mysql[:innodb_data_writes]                     = global_status["Innodb_data_written"]
mysql[:innodb_data_written]                    = global_status["Innodb_dblwr_pages_written"]
mysql[:innodb_dblwr_pages_written]             = global_status["Innodb_dblwr_writes"]
mysql[:innodb_dblwr_writes]                    = global_status["Innodb_have_atomic_builtins"]
mysql[:innodb_have_atomic_builtins]            = global_status["Innodb_log_waits"]
mysql[:innodb_log_waits]                       = global_status["Innodb_log_write_requests"]
mysql[:innodb_log_write_requests]              = global_status["Innodb_log_writes"]
mysql[:innodb_log_writes]                      = global_status["Innodb_os_log_fsyncs"]
mysql[:innodb_os_log_fsyncs]                   = global_status["Innodb_os_log_pending_fsyncs"]
mysql[:innodb_os_log_pending_fsyncs]           = global_status["Innodb_os_log_pending_writes"]
mysql[:innodb_os_log_pending_writes]           = global_status["Innodb_os_log_written"]
mysql[:innodb_os_log_written]                  = global_status["Innodb_page_size"]
mysql[:innodb_page_size]                       = global_status["Innodb_pages_created"]
mysql[:innodb_pages_created]                   = global_status["Innodb_pages_read"]
mysql[:innodb_pages_read]                      = global_status["Innodb_pages_written"]
mysql[:innodb_pages_written]                   = global_status["Innodb_row_lock_current_waits"]
mysql[:innodb_row_lock_current_waits]          = global_status["Innodb_row_lock_time"]
mysql[:innodb_row_lock_time]                   = global_status["Innodb_row_lock_time_avg"]
mysql[:innodb_row_lock_time_avg]               = global_status["Innodb_row_lock_time_max"]
mysql[:innodb_row_lock_time_max]               = global_status["Innodb_row_lock_waits"]
mysql[:innodb_row_lock_waits]                  = global_status["Innodb_rows_deleted"]
mysql[:innodb_rows_deleted]                    = global_status["Innodb_rows_inserted"]
mysql[:innodb_rows_inserted]                   = global_status["Innodb_rows_read"]
mysql[:innodb_rows_read]                       = global_status["Innodb_rows_updated"]
mysql[:innodb_rows_updated]                    = global_status["Innodb_truncated_status_writes"]
mysql[:innodb_truncated_status_writes]         = global_status["Innodb_buffer_pool_pages_data"]

# Qcache
mysql[:qcache_free_blocks]      = global_status["Qcache_free_blocks"]
mysql[:qcache_free_memory]      = global_status["Qcache_free_memory"]
mysql[:qcache_hits]             = global_status["Qcache_hits"]
mysql[:qcache_inserts]          = global_status["Qcache_inserts"]
mysql[:qcache_lowmem_prunes]    = global_status["Qcache_lowmem_prunes"]
mysql[:qcache_not_cached]       = global_status["Qcache_not_cached"]
mysql[:qcache_queries_in_cache] = global_status["Qcache_queries_in_cache"]
mysql[:qcache_total_blocks]     = global_status["Qcache_total_blocks"]

# Keys
mysql[:key_blocks_not_flushed]  = global_status["Key_blocks_not_flushed"]                                    
mysql[:key_blocks_unused]       = global_status["Key_blocks_unused"]                                         
mysql[:key_blocks_used]         = global_status["Key_blocks_used"]                                           
mysql[:key_read_requests]       = global_status["Key_read_requests"]                                         
mysql[:key_reads]               = global_status["Key_reads"]                                                 
mysql[:key_write_requests]      = global_status["Key_write_requests"]                                        
mysql[:key_writes]              = global_status["Key_writes"]           

## VARIABLES

# Binlog
mysql[:binlog_cache_size]                       = variables["binlog_cache_size"]
mysql[:binlog_direct_non_transactional_updates] = variables["binlog_direct_non_transactional_updates"]
mysql[:binlog_format]                           = variables["binlog_format"]
mysql[:binlog_stmt_cache_size]                  = variables["binlog_stmt_cache_size"]      

# Max

mysql[:max_allowed_packet]          = variables["max_allowed_packet"]
mysql[:max_binlog_cache_size]       = variables["max_binlog_cache_size"]
mysql[:max_binlog_size]             = variables["max_binlog_size"]
mysql[:max_binlog_stmt_cache_size]  = variables["max_binlog_stmt_cache_size"]
mysql[:max_connect_errors]          = variables["max_connect_errors"]
mysql[:max_connections]             = variables["max_connections"]
mysql[:max_delayed_threads]         = variables["max_delayed_threads"]
mysql[:max_error_count]             = variables["max_error_count"]
mysql[:max_heap_table_size]         = variables["max_heap_table_size"]
mysql[:max_insert_delayed_threads]  = variables["max_insert_delayed_threads"]
mysql[:max_join_size]               = variables["max_join_size"]
mysql[:max_length_for_sort_data]    = variables["max_length_for_sort_data"]
mysql[:max_long_data_size]          = variables["max_long_data_size"]
mysql[:max_prepared_stmt_count]     = variables["max_prepared_stmt_count"]
mysql[:max_relay_log_size]          = variables["max_relay_log_size"]
mysql[:max_seeks_for_key]           = variables["max_seeks_for_key"]
mysql[:max_sort_length]             = variables["max_sort_length"]
mysql[:max_sp_recursion_depth]      = variables["max_sp_recursion_depth"]
mysql[:max_tmp_tables]              = variables["max_tmp_tables"]
mysql[:max_user_connections]        = variables["max_user_connections"]
mysql[:max_write_lock_count]        = variables["max_write_lock_count"]             