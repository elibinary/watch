class Conditions

  attr_reader :sql, :params

  def initialize()
    @sql = ''
    @params = {}
  end

  def to_a
    return [ @sql, @params ]
  end

  def symbolize( name )
    sym = name.gsub( /\./, '_' )
    return sym.to_sym unless @params.has_key?( sym.to_sym )

    1.upto( 99 ) do |i|
      test = "#{sym}_#{i}"
      return test.to_sym unless @params.has_key?( test.to_sym )
    end

    raise( ArgumentError, "Param name already used 100 times" )
  end

  def add( clause, params, operator = 'AND' )
    params.keys.each { |key| raise( ArgumentError, "Duplicate param" ) if @params[ key ] }
    @params.merge!( params )

    unless @sql.blank? || @sql.rstrip.end_with?( '(' )
      @sql << " #{operator} "
    end
    @sql << clause
    return self
  end

  ###############################################################
  ## Helps
  ###############################################################

  def like( name, value, operator = 'AND' )
    return null( name, operator ) if nil == value
    return add( "#{name} like :#{symbolize( name )}", { symbolize( name ) => value }, operator )
  end

  def not_null( name, operator = 'AND' )
    return add( "#{name} is not null", {}, operator )
  end

  def null( name, operator = 'AND' )
    return add( "#{name} is null", {}, operator )
  end
end