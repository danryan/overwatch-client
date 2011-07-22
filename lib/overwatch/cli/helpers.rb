module Overwatch
  module CLI
    module Helpers
      def f
        @f ||= Formatador.new
      end
      
      def display_line(string)
        f.display_line(string)
      end
      
      def default_headers
        { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      end
      
      def get(url, options={}, headers={})
        begin
          response = JSON.parse(RestClient.get(url, headers.merge!(default_headers)))
          format_output(response, options)
        rescue RestClient::Exception => e
          response = {:code => e.http_code.to_s, :errors => JSON.parse(e.http_body)}
          options.merge!(:fields => [ :code, :errors ])
          format_output(response, options)
          exit 1
        end
      end
      
      def post(url, payload={}, options={}, headers={})
        begin
          response = JSON.parse(RestClient.post(url, payload, headers.merge!(default_headers)))
          format_output(response, options)
        rescue RestClient::Exception => e
          response = {:code => e.http_code.to_s, :errors => JSON.parse(e.http_body)}
          options[:fields] = [ :code, :errors ]
          format_output(response, options)
          exit 1
        end
      end
      
      def delete(url, headers={})
        begin
          res = RestClient.delete(url, headers.merge!(default_headers))
          JSON.parse(res)
        rescue RestClient::Exception => e
        end
      end
      
      def format_output(rows, options)
        data = rows.is_a?(Array) ? rows : [rows]
        
        case options[:format]
        when 'text'
          puts Hirb::Helpers::TextTable.render(data, options)
        when 'json'
          pp JSON.generate(data)
        else
          puts Hirb::Helpers::Table.render(data, options)
        end
      end
    end
  end
end


class Hirb::Helpers::TextTable < Hirb::Helpers::Table
  CHARS = {
    :top => {
      :left => '', :center => '', :right => '', :horizontal => '', :vertical => {
        :outside => '', :inside => ''
      } 
    },
    :middle => {
      :left => '', :center => '', :right => '', :horizontal => ''
    },
    :bottom => {
      :left => '', :center => '', :right => '', :horizontal => '', :vertical => {
        :outside => '', :inside => ''
      } 
    }
  }
  
  def self.render(rows, options={})
    options.merge!(:headers => false, :description => false)
    new(rows, options).render
  end
  
  def render
    body = []
    unless @rows.length == 0
      setup_field_lengths
      body += render_rows
    end
    body.join("\n")
  end
end