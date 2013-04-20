module Rob

  class << self
    def registered(app)
      app.send :include, Helpers

      app.after_configuration do
        @data = PostData.new(self)
        sitemap.register_resource_list_manipulator(:custom_blog, @data, false)

        @tagger = TagPages.new(self, @data)
        sitemap.register_resource_list_manipulator(:tag_pages, @tagger, false)
      end
    end
    alias :included :registered
  end

  module Helpers
    def blogposts
      @data.all_articles
    end
  end

  class TagPages
    def initialize(app, data)
      @app = app
      @post_data = data
    end

    def manipulate_resource_list(resources)
      resources + @post_data.all_tags.map do |tag_name, articles|
        path = "blog/categories/#{tag_name}.html"
        tag_page = ::Middleman::Sitemap::Resource.new(@app.sitemap, path)
        tag_page.proxy_to('tag.html')

        tag_page.add_metadata :locals => {
          'page_type' => 'tag',
          'tagname' => tag_name,
          'articles' => articles,
          'data' => @post_data
        }

        tag_page
      end
    end
    
  end

  class PostData
    attr_reader :all_articles
    
    def initialize(app)
      @app = app
      @all_articles = []
    end
    
    def manipulate_resource_list(resources)
      @all_articles = []
      resources.each do |resource|
        # TODO This path should probably not be hard-coded
        next unless resource.destination_path =~ /^blog\/.*\/index.html/
        resource.extend Post
        @all_articles << resource
      end
    end

    def all_tags
      tags = Hash.new{|hash, key| hash[key] = []}
      @all_articles.each do |article|
        article.tags.each do |tag|
          tags[tag] << article
        end
      end
      
      return tags
    end
  end

  module Post
    def published?
      data["published"] != false
    end

    def tags
      article_tags = data["tags"]
      if article_tags
        article_tags.split(',').map(&:strip)
      else
        []
      end
    end

    def title
      data["title"] || "This post has no title"
    end

    def date
      path = self.destination_path
      match = destination_path.match(/blog\/(?<year>20\d\d)\/(?<month>\d\d)\/(?<day>\d\d)/)
      Time.new(match[:year],match[:month],match[:day])
    end

    def nicedate
      match = destination_path.match(/blog\/(?<year>20\d\d)\/(?<month>\d\d)\/(?<day>\d\d)/)
      [match[:year],match[:month],match[:day]].join("-")
    end

    def description
      data["description"] || "This post has no description"
    end

    def body
      render(:layout => false)
    end
  end
end

::Middleman::Extensions.register(:custom_blog, Rob)

