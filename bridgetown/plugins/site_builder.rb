class SiteBuilder < Bridgetown::Builder
  class Queries < OpenStruct; end

  class << self
    attr_accessor :graphql_queries

    def graphql(graph_name, &block)
      self.graphql_queries ||= Queries.new
      graphql_queries.send("#{graph_name}=", block)
    end
  end

  def queries
    return self.class.graphql_queries if @_executed_queries

    self.class.graphql_queries.each_pair do |graph_name, block|
      client = Graphlient::Client.new(config[:graphql_endpoint])
      graph_dsl = Graphlient::Query.new(&block)

      self.class.graphql_queries.send(
        "#{graph_name}=",
        client.execute(graph_dsl.to_s).data.send(graph_name)
      )
    end

    @_executed_queries = true
    self.class.graphql_queries
  end
end

