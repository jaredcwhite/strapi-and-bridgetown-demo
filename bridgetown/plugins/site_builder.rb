class SiteBuilder < Bridgetown::Builder
  # write builders which subclass SiteBuilder in plugins/builder

  # Construct a GraphQL client pointing to the graqhql_endpoint config variable
  def graphql(graph_name)
    client = Graphlient::Client.new(config[:graphql_endpoint])
    client.execute(send(:"#{graph_name}_graph").to_s).data.send(graph_name)
  end
end

