class GraphqlBuilder < SiteBuilder
  graphql :somethings do
    query {
      somethings {
        id
        title
        age
        createdAt
      }
    }
  end

  def build
    # Loop through the data and create new documents
    queries.somethings.each do |something|
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
