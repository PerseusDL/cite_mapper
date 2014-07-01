require "cite_mapper/version"

class CiteMapper
  def initialize
    @authors = {}
    parse_abbr_file
  end

  def find_by_cite(urn_string)
    cts = CtsUrn.new(urn_string)
    author = @authors[cts.author]
    work   = author[cts.work]
    Result.new(author, work, cts.section)
  end

  private

  DATA_PATH = File.expand_path('../../data', __FILE__)

  def parse_abbr_file
    file = File.read(File.join(DATA_PATH, 'perseus.abb'))
    file.lines.each do |line|
      _, abbr, cts = line.strip.split("\t")
      author, work = parse_abbr(abbr)
      author_id, work_id = parse_cts(cts)

      add_entry(author, work, author_id, work_id)
    end
  end

  def parse_abbr(abbr)
    parts = abbr.split
    author = parts.shift
    work   = parts.join(' ')
    [author, work]
  end

  def parse_cts(cts)
    # they all start with abo:
    namespace, author_id, work_id = cts[4..-1].split(',')
    ["#{namespace}#{author_id}", "#{namespace}#{work_id}"]
  end

  def add_author(id, name)
    @authors[id] ||= Author.new(id, name)
  end

  def add_entry(author, work, author_id, work_id)
    author = add_author(author_id, author)
    author.add_work(work_id, work)
  end
end

class Author
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
    @works = {}
  end

  def [](id)
    @works[id]
  end

  def add_work(id,  name)
    @works[id] = Work.new(id, name)
  end
end

class Work
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end
end

class CtsUrn
  attr_reader :prefix, :category, :author, :work, :edition, :section

  def initialize(cts_urn)
    @urn = cts_urn
    parse
  end

  private

  def parse
    m = @urn.match(/(?<prefix>urn:cts):(?<category>.*?):(?<author>.*?)\.(?<work>.*?)\.(?<edition>.*?)(:(?<section>.*?))?$/)
    m.names.each do |name|
      instance_variable_set("@#{name}", m[name])
    end
  end
end

class Result
  attr_reader :section

  def initialize(author, work, section)
    @author_obj = author
    @work_obj = work
    @section = section
  end

  def author
    @author_obj.name
  end

  def work
    @work_obj.name
  end

  def to_json
    content = %i{ author work section }.map { |category| to_property(category) }
    %{{ #{content.join(', ')} }}
  end

  private

  def to_property(name)
    %{"#{name}" : "#{send(name)}"}
  end
end
