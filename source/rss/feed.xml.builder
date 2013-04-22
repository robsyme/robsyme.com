xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do
  xml.title "On Bioinformatics and Fungal Genomics"
  xml.subtitle "Ramblings and Miscellany"
  xml.id "http://robsyme.com/"
  xml.link "href" => "http://robsyme.com/"
  xml.link "href" => "http://robsyme.com/rss/feed.xml", "rel" => "self"
  xml.updated blogposts.first.date.to_time.iso8601
  xml.author { xml.name "Rob Syme" }

  blogposts[0..5].each do |article|
    xml.entry do
      xml.title article.title
      xml.link "rel" => "alternate", "href" => article.url
      xml.id article.url
      xml.published article.date.to_time.iso8601
      xml.updated article.date.to_time.iso8601
      xml.author { xml.name "Rob Syme" }
      # xml.summary article.description, "type" => "html"
      xml.content article.body, "type" => "html"
    end
  end
end
