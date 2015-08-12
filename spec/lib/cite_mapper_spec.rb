require 'spec_helper'

describe CiteMapper do
  it 'has a version number' do
    expect(CiteMapper::VERSION).not_to be nil
  end

  before(:all) do
    @mapper = CiteMapper.new
  end

  describe "#find_by_cite" do
    it "returns an object with info about the standard citation" do
     cite = 'urn:cts:latinLit:phi0448.phi001.perseus-grc1:6'
     res  = @mapper.find_by_cite(cite)
     res.author.should == 'Caes.'
     res.work.should == 'Gall.'
     res.section.should == '6'
    end
  end

  describe "#find_by_abbr" do
    it "returns an object with info about a greek urn" do
     cite = 'Hom. Il. 1.1'
     res  = @mapper.find_by_abbr(cite)
     res[:urn].should == 'urn:cts:greekLit:tlg0012.tlg001:1.1'
    end
    it "returns an object with info about a latin urn" do
     cite = 'Verg. A. 1.1'
     res  = @mapper.find_by_abbr(cite)
     res[:urn].should == 'urn:cts:latinLit:phi0690.phi003:1.1'
    end
    it "returns an object with urn without passage" do
     cite = 'Verg. A.'
     res  = @mapper.find_by_abbr(cite)
     res[:urn].should == 'urn:cts:latinLit:phi0690.phi003'
    end
    it "returns an object with urn without work" do
     cite = 'Verg.'
     res  = @mapper.find_by_abbr(cite)
     res[:urn].should == 'urn:cts:latinLit:phi0690'
    end
  end

end
