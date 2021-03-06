# got it from https://github.com/nanoc/nanoc.ws/blob/master/lib/filters/add_toc.rb
require 'nokogiri'

class AddTOCFilter < Nanoc::Filter

  identifier :add_toc

  def run(content, params={})
    content.gsub('{{TOC}}') do
      # Find all top-level sections
      doc = Nokogiri::HTML(content)
      headers = doc.xpath('//h2').map do |header|
        { :title => header.inner_html, :id => header['id'] }
      end

      if headers.empty?
        next ''
      end

      # Build table of contents
      res = '<ul class="toc">'
      headers.each do |header|
        res << %[<li><a href="##{header[:id]}">#{header[:title]}</a></li>]
      end
      res << '</ul>'

      res
    end
  end

end