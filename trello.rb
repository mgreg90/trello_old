require 'rubygems'
require 'bundler'
Bundler.require(:default)

class Trello < Playwright::Play

  attr_writer :url

  TRELLO_FILE = '.trello'

  # get started doing your thing here!
  def run
    if trello_file_exists?
      open_trello
    else
      get_trello_url
    end
  end

  def open_trello
    `#{open} #{url}`
  end

  def open
    case RUBY_PLATFORM
    when /darwin/
      'open'
    when /linux/
      'xdg-open'
    else
      fail "We don't support Windows yet!"
    end
  end

  def get_trello_url
    puts "Please set the url to your trello board."
    print "URL: "
    url = gets.chomp
    write_url_to_file
  end

  private

  def url
    @url ||= trello_file_exists? && File.read(TRELLO_FILE)
  end

  def trello_file_exists?
    File.exists?(TRELLO_FILE)
  end

  def write_url_to_file
    File.open('.trello'. 'w') do |f|
      f.write(url)
    end
  end

end