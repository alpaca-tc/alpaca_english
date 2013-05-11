module SQLite3
  class Database
    @@db_cache = {}

    # chaching
    alias_method :old_execute, :execute
    def execute(sql, bind_vars = [], *args, &block)
      begin
        return @@db_cache[sql] if @@db_cache[sql]

        result = old_execute(sql, bind_vars, *args, &block)
        @@db_cache[sql] = result
      rescue
        return []
      end
    end
  end
end 
