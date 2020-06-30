require "graphlient"

class GraphqlBuilder < SiteBuilder
  def somethings_graph
    # Customize this query to suit the schema you're using:
    Graphlient::Query.new do
      query {
        somethings {
          id
          title
          age
          createdAt
        }
      }
    end
  end

  def build
    # Run the GraphQL Query. The symbol passed to the graphql method will
    # look for a :SYM_graph method to get the Graphlient query object
    # and then pull that same data structure out of the query.
    somethings = graphql(:somethings)

    # Loop through the posts data and create new post documents
    somethings.each do |something|
      # Turn the title into a slug: I'm a Title -> im-a-title
      slug = Bridgetown::Utils.slugify(something.title)
      # Construct the document:
      doc "#{slug}.md" do
        layout "post"
        date something.created_at
        front_matter something.to_h
        content "My **age** is #{something.age}"
      end
    end
  end
end
